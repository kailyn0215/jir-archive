/**
 * @fileoverview Data Importer Utility.
 * This module handles taking raw, unstructured data (e.g., from a spreadsheet or CSV export)
 * and mapping it into the standardized PlushEntry schema defined in catalogSchema.js.
 * This acts as a crucial translation layer between external data sources and our internal state.
 */

import { getCanonicalCompanyId } from '../data/catalogSchema';

/**
 * Converts a raw CSV row (array of strings) into a structured PlushEntry object,
 * applying all necessary canonicalization rules during the process.
 * @param {Array<string>} csvRow - An array representing one row from the source data.
 * @returns {{plush: Object|null, error: string|null}} The resulting plush object and any errors encountered.
 */
export const importCsvRow = (csvRow) => {
    if (!csvRow || csvRow.length < 5) {
        return { plush: null, error: "Skipping row: Input data array is too sparse." };
    }

    // ASSUMPTION MAPPING: We assume the following column order in the CSV:
    // [0] ID | [1] Title | [2] Image Path | [3] Year | [4] Company Name | [5] Product Line | [6] Price | [7] Owned Status
    const rawId = csvRow[0];
    const title = csvRow[1] || "";
    const imagePath = csvRow[2] || "";
    const yearStr = csvRow[3] || "Unknown";
    const rawCompany = csvRow[4] || "";
    const productLineRaw = csvRow[5] || "";
    const priceRaw = csvRow[6] || null;
    const ownedStatusRaw = csvRow[7] || 'unidentified';

    // --- 1. Core Utility Functions (Normalization) ---
    try {
        const companyId = getCanonicalCompanyId(rawCompany);
        let year = parseInt(yearStr);
        if (isNaN(year)) throw new Error("Invalid Year.");

        let price = priceRaw ? parseFloat(priceRaw.replace(/[^0-9.]/g, '')) : null;

        // --- 2. Building the final schema object ---
        const plushEntry = {
            id: rawId,
            title: title.trim(),
            imagePath: imagePath.trim(),
            releaseYear: year,
            companyId: companyId, // Uses canonical ID
            productLineId: productLineRaw.trim() || 'UNKNOWN', // Simple mapping for now
            priceJPY: isNaN(price) ? null : price,
            ownedStatus: ownedStatusRaw.toLowerCase().includes('own') ? 'owned' : 'unidentified',
            metadata: [
                { key: "Source Row ID", value: rawId },
                // Future meta-data can be added here based on other columns
            ]
        };

        return { plush: plushEntry, error: null };

    } catch (e) {
        console.error(`Error processing row ${rawId}:`, e);
        return { plush: null, error: `Schema mapping failed: ${e.message}` };
    }
};


/**
 * Processes an entire array of raw CSV rows into a cleaned list of PlushEntry objects.
 * @param {Array<string[]>} csvData - Array where each element is a row (array of strings).
 * @returns {{successList: Object[], failureLog: Array<{row: string[], reason: string}>}} The processed data and any errors encountered.
 */
export const processBulkImport = (csvData) => {
    const successfulImports = [];
    const failedRows = [];

    csvData.forEach((row, index) => {
        const result = importCsvRow(row);
        if (result.error === null && result.plush) {
            successfulImports.push(result.plush);
        } else {
            failedRows.push({
                row: row,
                reason: result.error || "Unknown schema mapping error."
            });
        }
    });

    return { successList: successfulImports, failureLog: failedRows };
};