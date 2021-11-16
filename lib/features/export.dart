import 'dart:io';

import 'package:daily/utility/date_time.dart';
import 'package:daily/utility/file_utility.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

const expenseAllCategory = "expense-all";
const excelFileExt = "excel";
const pdfFileExt = "pdf";

const Map<String, String> _fileExts = {
  excelFileExt: "xlsx",
  pdfFileExt: "pdf",
};

const String fileNameResultKey = "file_name";
const String statusResultKey = "status";

Map<String, bool> getExportOptions() {
  return {
    excelFileExt: false,
    pdfFileExt: false,
  };
}

Future<Map<String, Map<String, dynamic>>> exportFile({
  required Map<String, bool> exportOptions,
  required category,
  required Box box,
}) async {
  Map<String, Map<String, dynamic>> exportStatus = {};

  switch (category) {
    case expenseAllCategory:
      exportOptions.forEach((extType, ext) async {
        switch (extType) {
          case excelFileExt:
            if (!ext) break;
            final dailyExpenses =
                box.toMap().entries.map((entry) => entry.value).toList();
            final resultStatus = await _generateExcelExpenseAll(dailyExpenses);
            exportStatus.putIfAbsent(
              excelFileExt,
              () => resultStatus,
            );
            break;
          case pdfFileExt:
            if (!ext) break;
            break;
        }
      });
      break;
  }

  return exportStatus;
}

Future<Map<String, dynamic>> _generateExcelExpenseAll(
    List<dynamic> dailyExpenses) async {
  Map<String, dynamic> generateResult = {
    fileNameResultKey: "",
    statusResultKey: false,
  };

  try {
    //Create a Excel document.

    //Creating a workbook.
    final Workbook workbook = Workbook();
    //Accessing via index
    final Worksheet sheet = workbook.worksheets[0];
    sheet.showGridlines = true;

    // Enable calculation for worksheet.
    sheet.enableSheetCalculations();

    //Set data in the worksheet.

    final Range rangeLabel = sheet.getRangeByName('A1:G1');
    rangeLabel.cellStyle.fontSize = 10;
    rangeLabel.cellStyle.bold = true;

    int startRow = 1;

    sheet.getRangeByIndex(startRow, 1).setText('No');
    sheet.getRangeByIndex(startRow, 2).setText('UUID');
    sheet.getRangeByIndex(startRow, 3).setText('Category');
    sheet.getRangeByIndex(startRow, 4).setText('Type');
    sheet.getRangeByIndex(startRow, 5).setText('Price');
    sheet.getRangeByIndex(startRow, 6).setText('Description');
    sheet.getRangeByIndex(startRow, 7).setText('Date');

    int lastRow = ++startRow;
    for (var dailyExpense in dailyExpenses) {
      sheet.getRangeByIndex(lastRow, 1).setNumber(lastRow - 1);
      sheet.getRangeByIndex(lastRow, 2).setText(dailyExpense.uuid);
      sheet.getRangeByIndex(lastRow, 3).setText(dailyExpense.category);
      sheet.getRangeByIndex(lastRow, 4).setText(dailyExpense.type);
      sheet.getRangeByIndex(lastRow, 5).setNumber(dailyExpense.price);
      sheet.getRangeByIndex(lastRow, 6).setText(dailyExpense.description);
      sheet.getRangeByIndex(lastRow, 7).dateTime = dailyExpense.date;

      ++lastRow;
    }

    // AutoFit applied to a single Column.
    sheet.autoFitColumn(1);
    // sheet.autoFitColumn(2);
    sheet.autoFitColumn(3);
    sheet.autoFitColumn(4);
    sheet.getRangeByName('E1').columnWidth = 10;
    sheet.autoFitColumn(6);
    sheet.getRangeByName('G1').columnWidth = 35;

    sheet.getRangeByIndex(startRow, 7, lastRow, 7).numberFormat =
        r'[$-x-sysdate]dddd, mmmm dd, yyyy';
    sheet.getRangeByIndex(startRow, 5, lastRow, 5).numberFormat =
        r'"RM "#,##0.00';

    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();

    String fileName = cleanFileName(
      fileName: "expenses ${getCurrentLocalDateTimeStringForFileName()}",
      fileExt: _fileExts[excelFileExt] ?? "",
    );

    generateResult.update(fileNameResultKey, (_) => fileName);

    String path = await getDirectory(isPublic: true);

    if (path == "") return generateResult;

    File(path + fileName).writeAsBytes(bytes);
    generateResult.update(statusResultKey, (_) => true);

    return generateResult;
  } on Exception {
    return generateResult;
  }
}
