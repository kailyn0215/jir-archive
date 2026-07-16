/**
 * Jirachi Plush Archive — Collection Management Module
 * Single source of truth for localStorage collection state.
 * 
 * Schema: { owned: string[], wanted: string[], trade: string[] }
 * Key: 'jirachi-collection'
 * 
 * Dispatches 'collection:changed' CustomEvent on any state change.
 */

(function(global) {
  'use strict';
  
  const STORAGE_KEY = 'jirachi-collection';
  const LEGACY_STORAGE_KEY = 'jirachi-plush-collection';
  const VALID_STATUSES = ['owned', 'wanted', 'trade'];

  function normalizeCollection(raw) {
    const normalized = { owned: [], wanted: [], trade: [] };

    if (!raw || typeof raw !== 'object') {
      return normalized;
    }

    if (Array.isArray(raw.owned) || Array.isArray(raw.wanted) || Array.isArray(raw.trade)) {
      normalized.owned = Array.isArray(raw.owned) ? [...new Set(raw.owned)] : [];
      normalized.wanted = Array.isArray(raw.wanted) ? [...new Set(raw.wanted)] : [];
      normalized.trade = Array.isArray(raw.trade) ? [...new Set(raw.trade)] : [];
      return normalized;
    }

    Object.keys(raw).forEach(id => {
      const status = raw[id];
      if (VALID_STATUSES.includes(status)) {
        normalized[status].push(id);
      }
    });

    return normalized;
  }
  
  /**
   * Get the full collection object from localStorage.
   * @returns {{ owned: string[], wanted: string[], trade: string[] }}
   */
  function getCollection() {
    try {
      const stored = localStorage.getItem(STORAGE_KEY);
      if (stored) {
        return normalizeCollection(JSON.parse(stored));
      }

      const legacyStored = localStorage.getItem(LEGACY_STORAGE_KEY);
      if (legacyStored) {
        const parsed = JSON.parse(legacyStored);
        const migrated = normalizeCollection(parsed);
        localStorage.setItem(STORAGE_KEY, JSON.stringify(migrated));
        localStorage.removeItem(LEGACY_STORAGE_KEY);
        return migrated;
      }
    } catch (e) {
      console.warn('Failed to parse collection from localStorage:', e);
    }
    return { owned: [], wanted: [], trade: [] };
  }
  
  /**
   * Save the collection object to localStorage and dispatch change event.
   * @param {{ owned: string[], wanted: string[], trade: string[] }} collection
   */
  function saveCollection(collection) {
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify(collection));
      dispatchChangeEvent(collection);
    } catch (e) {
      console.warn('Failed to save collection to localStorage:', e);
    }
  }
  
  /**
   * Dispatch a custom event when collection changes.
   * @param {{ owned: string[], wanted: string[], trade: string[] }} collection
   */
  function dispatchChangeEvent(collection) {
    const event = new CustomEvent('collection:changed', {
      detail: { collection },
      bubbles: true
    });
    document.dispatchEvent(event);
  }
  
  /**
   * Get the status of a specific plush by ID.
   * @param {string} id - Archive ID (e.g., 'JIR-TOMY-0001')
   * @returns {'owned' | 'wanted' | 'trade' | null}
   */
  function getStatus(id) {
    const col = getCollection();
    if (col.owned.includes(id)) return 'owned';
    if (col.wanted.includes(id)) return 'wanted';
    if (col.trade.includes(id)) return 'trade';
    return null;
  }
  
  /**
   * Check if a plush has a specific status.
   * @param {string} id - Archive ID
   * @param {'owned' | 'wanted' | 'trade'} status - Status to check
   * @returns {boolean}
   */
  function has(id, status) {
    const col = getCollection();
    if (!VALID_STATUSES.includes(status)) return false;
    return col[status].includes(id);
  }
  
  /**
   * Set the status of a specific plush.
   * @param {string} id - Archive ID
   * @param {'owned' | 'wanted' | 'trade' | null} status - New status, or null to remove
   */
  function setStatus(id, status) {
    const col = getCollection();
    
    // Remove from all arrays first
    col.owned = col.owned.filter(x => x !== id);
    col.wanted = col.wanted.filter(x => x !== id);
    col.trade = col.trade.filter(x => x !== id);
    
    // Add to appropriate array if status is valid
    if (status && VALID_STATUSES.includes(status)) {
      col[status].push(id);
    }
    
    saveCollection(col);
  }
  
  /**
   * Cycle through statuses: null → owned → wanted → trade → null
   * @param {string} id - Archive ID
   * @returns {'owned' | 'wanted' | 'trade' | null} - The new status
   */
  function cycleStatus(id) {
    const current = getStatus(id);
    let next;
    
    switch (current) {
      case null: next = 'owned'; break;
      case 'owned': next = 'wanted'; break;
      case 'wanted': next = 'trade'; break;
      case 'trade': next = null; break;
      default: next = 'owned';
    }
    
    setStatus(id, next);
    return next;
  }
  
  /**
   * Get array of owned IDs (backward compatibility).
   * @returns {string[]}
   */
  function getOwned() {
    return getCollection().owned;
  }
  
  /**
   * Get total counts for stats.
   * @returns {{ owned: number, wanted: number, trade: number, total: number }}
   */
  function getCounts() {
    const col = getCollection();
    return {
      owned: col.owned.length,
      wanted: col.wanted.length,
      trade: col.trade.length,
      total: col.owned.length + col.wanted.length + col.trade.length
    };
  }
  
  /**
   * Import collection data (merge or replace).
   * @param {{ owned?: string[], wanted?: string[], trade?: string[] }} data
   * @param {boolean} replace - If true, replace; if false, merge
   */
  function importCollection(data, replace = false) {
    let col = replace ? { owned: [], wanted: [], trade: [] } : getCollection();
    
    if (Array.isArray(data.owned)) {
      col.owned = replace ? data.owned : [...new Set([...col.owned, ...data.owned])];
    }
    if (Array.isArray(data.wanted)) {
      col.wanted = replace ? data.wanted : [...new Set([...col.wanted, ...data.wanted])];
    }
    if (Array.isArray(data.trade)) {
      col.trade = replace ? data.trade : [...new Set([...col.trade, ...data.trade])];
    }
    
    // Ensure no ID is in multiple categories (priority: owned > wanted > trade)
    const owned = new Set(col.owned);
    col.wanted = col.wanted.filter(id => !owned.has(id));
    const wantedSet = new Set(col.wanted);
    col.trade = col.trade.filter(id => !owned.has(id) && !wantedSet.has(id));
    
    saveCollection(col);
  }
  
  /**
   * Export collection as JSON string.
   * @returns {string}
   */
  function exportAsJSON() {
    return JSON.stringify(getCollection(), null, 2);
  }
  
  /**
   * Export collection as CSV string.
   * @param {Array<{archive_id: string, current_name: string}>} plushData - Optional plush metadata
   * @returns {string}
   */
  function exportAsCSV(plushData = []) {
    const col = getCollection();
    const rows = [['Archive ID', 'Name', 'Status']];
    
    const getStatusStr = (id) => {
      if (col.owned.includes(id)) return 'Owned';
      if (col.wanted.includes(id)) return 'Wanted';
      if (col.trade.includes(id)) return 'For Trade';
      return '';
    };
    
    const allIds = [...new Set([...col.owned, ...col.wanted, ...col.trade])];
    
    allIds.forEach(id => {
      const plush = plushData.find(p => p.archive_id === id);
      const name = plush ? plush.current_name : '';
      rows.push([id, name, getStatusStr(id)]);
    });
    
    return rows.map(row => row.map(cell => `"${String(cell).replace(/"/g, '""')}"`).join(',')).join('\n');
  }
  
  /**
   * Clear entire collection.
   */
  function clearCollection() {
    saveCollection({ owned: [], wanted: [], trade: [] });
  }
  
  // Status display helpers
  const STATUS_ICONS = {
    owned: '✓',
    wanted: '♡',
    trade: '↔'
  };
  
  const STATUS_LABELS = {
    owned: 'Owned',
    wanted: 'Wanted',
    trade: 'For Trade'
  };
  
  // Export to global scope
  global.JirachiCollection = {
    getCollection,
    getStatus,
    has,
    setStatus,
    toggle: function(id, status) {
      // Toggle a specific status (used by detail page)
      const current = has(id, status);
      if (current) {
        setStatus(id, null);
      } else {
        setStatus(id, status);
      }
    },
    cycleStatus,
    getOwned,
    getCounts,
    importCollection,
    exportAsJSON,
    exportAsCSV,
    clearCollection,
    STATUS_ICONS,
    STATUS_LABELS,
    STORAGE_KEY,
    VALID_STATUSES
  };
  
})(typeof window !== 'undefined' ? window : this);
