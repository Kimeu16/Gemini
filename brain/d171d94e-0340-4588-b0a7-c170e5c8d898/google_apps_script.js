/**
 * GOOGLE APPS SCRIPT FOR GOOGLE SHEETS SYNC
 * 
 * Paste this into 'Extensions > Apps Script' in your Google Sheet.
 * Click 'Deploy > New Deployment > Web App'.
 * Set 'Execute as' to 'Me' and 'Who has access' to 'Anyone'.
 * 
 * Copy the URL and run this in your browser console:
 * localStorage.setItem("google_apps_script_url", "YOUR_URL_HERE");
 */

function doPost(e) {
  var params = JSON.parse(e.postData.contents);
  var action = params.action;
  
  if (action === "update") {
    return handleUpdate(params);
  }
}

function handleUpdate(params) {
  var sheetName = params.sheetName || "Sites";
  var idKey = params.idKey || "No";
  var idValue = params.idValue;
  var data = params.data;
  
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var sheet = ss.getSheetByName(sheetName);
  
  if (!sheet) {
    return ContentService.createTextOutput(JSON.stringify({ error: "Sheet not found" }))
                         .setMimeType(ContentService.MimeType.JSON);
  }
  
  var tableData = sheet.getDataRange().getValues();
  var headers = tableData[0];
  
  // Find row index by ID
  var idIndex = headers.indexOf(idKey);
  if (idIndex === -1) {
    return ContentService.createTextOutput(JSON.stringify({ error: "ID Key not found" }))
                         .setMimeType(ContentService.MimeType.JSON);
  }
  
  var rowIndex = -1;
  for (var i = 1; i < tableData.length; i++) {
    if (String(tableData[i][idIndex]) === String(idValue)) {
      rowIndex = i + 1; // 1-indexed for sheet
      break;
    }
  }
  
  if (rowIndex === -1) {
    return ContentService.createTextOutput(JSON.stringify({ error: "Row not found" }))
                         .setMimeType(ContentService.MimeType.JSON);
  }
  
  // Update cells
  for (var key in data) {
    var colIndex = headers.indexOf(key);
    if (colIndex !== -1) {
      sheet.getRange(rowIndex, colIndex + 1).setValue(data[key]);
    }
  }
  
  return ContentService.createTextOutput(JSON.stringify({ success: true }))
                       .setMimeType(ContentService.MimeType.JSON);
}
