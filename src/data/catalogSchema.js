/**
 * @fileoverview Master catalog schema definition and data loader utility.
 * This file serves as the single source of truth (Source of Truth pattern) for all plush archive items.
 * ALL product listings MUST be added here, following the defined schema.
 *
 * NOTE TO DEVELOPER: Use canonical keys when populating entities to ensure consistent filtering across the SPA.
 */

// --- 1. CORE SCHEMA DEFINITION ---

/**
 * Defines the structure for any single plush entry.
 * @typedef {Object} PlushEntry
 * @property {string} id - Unique, system-assigned ID (e.g., JIR-00001).
 * @property {string} title - Display name of the plush.
 * @property {string} imagePath - Relative path to the main image.
 * @property {Date|string} releaseYear - Year of official release.
 * @property {string} companyId - Canonical ID for the manufacturing company (e.g., 'TAKARA_TOMY').
 * @property {string} productLineId - Canonical identifier for the series/line.
 * @property {number} priceJPY - Price in JPY, if known.
 * @property {'owned' | 'unidentified'} ownedStatus - User-defined status ('owned', 'unidentified').
 * @property {{key: string, value: any}[]} metadata - Flexible key/value pairs for extra data (e.g., 'Character Origin': 'Pokémon').
 */

// --- 2. CANONICAL DATA UTILITIES (Normalization Logic) ---

/**
 * Standardizes raw company name strings into canonical IDs.
 * @param {string} rawName - The raw string from the source data.
 * @returns {string} Canonical ID or 'UNKNOWN'.
 */
const getCanonicalCompanyId = (rawName) => {
    if (!rawName) return 'UNKNOWN';
    const lowerName = rawName.toLowerCase();

    if (lowerName.includes('takara tomy')) return 'TAKARA_TOMY';
    if (lowerName.includes('bandai spirits')) return 'BANDAI_SPIRITS';
    // Add more mappings as we discover new brands
    return 'UNKNOWN';
};


// --- 3. MASTER CATALOG (The JSON Data) ---

/** @type {PlushEntry[]} */
const MasterCatalog = [
    {
        id: "JIR-00001",
        title: "Yawaraka Jirachi Plush",
        imagePath: "/assets/images/jir-00001.png", // Placeholder path
        releaseYear: 2019,
        companyId: 'BANDAI_SPIRITS', // Normalized from source data
        productLineId: 'UNKNOWN',  // To be filled with canonical ID
        priceJPY: null,             // Null if price is unknown
        ownedStatus: 'unidentified',
        metadata: [
            { key: "Character", value: "Jirachi" },
            { key: "Collection Status", value: "Master" }
        ]
    },
    {
        id: "JIR-00002",
        title: "Mecha Mofugutto Yellow Ver.",
        imagePath: "/assets/images/jir-00002.png",
        releaseYear: 2024,
        companyId: 'BANDAI_SPIRITS', // Assuming a consistent brand here for now
        productLineId: 'UNKNOWN',
        priceJPY: null,
        ownedStatus: 'unidentified',
        metadata: [
            { key: "Character", value: "Mofugutto" }
        ]
    },
    // !!! Add all 35 items here following the schema defined above.
];

/**
 * Exports the master catalog array and helper functions for use by the React component layer.
 */
export { MasterCatalog, getCanonicalCompanyId };