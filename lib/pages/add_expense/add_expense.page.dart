import 'package:daily/features/export.dart' as export_manager;
import 'package:daily/providers/font/font.provider.dart';
import 'package:daily/providers/general/general.provider.dart';
import 'package:flutter/material.dart';
import 'package:daily/model/expense/expense.dart' as expense;
import 'package:daily/utility/uuid_generator.dart' as uuid_generator;
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute(
        builder: (_) => const AddExpensePage(),
      );

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  String selectedType = expense.typeList[0];
  String selectedCategory = "";
  List<String> categories = [];
  String date = "";
  DateTime selectedDate = DateTime.now();
  var descTextEditingController = TextEditingController();
  var priceTextEditingController = TextEditingController();

  Future<bool> submit() async {
    Box expenseBox = await Hive.openBox(expense.expenseBox);

    expense.Expense dailyExpense = expense.Expense(
      uuid: await uuid_generator.generateUuid(expenseBox),
      category: selectedCategory,
      type: selectedType,
      price: double.parse(priceTextEditingController.text),
      description: descTextEditingController.text,
      date: selectedDate,
    );

    return expenseBox
        .add(dailyExpense)
        .then((value) => true)
        .catchError((onError) => false);
  }

  List<String> setCategories(String selectedType) {
    List<String> categoriesList =
        expense.getCategoriesBasedOnType(selectedType);

    selectedCategory = categoriesList[0];
    return categoriesList;
  }

  bool checkDate(DateTime date1, DateTime date2) {
    return (date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year);
  }

  @override
  Widget build(BuildContext context) {
    descTextEditingController.text = "";
    priceTextEditingController.text = "";
    GeneralProvider generalProvider = Provider.of<GeneralProvider>(
      context,
      listen: false,
    );

    FontProvider fontProvider = Provider.of<FontProvider>(
      context,
      listen: false,
    );

    if (categories.isEmpty) {
      categories = setCategories(selectedType);
    }

    double scrWidth = MediaQuery.of(context).size.width;
    double scrHeight = MediaQuery.of(context).size.height * 0.8;
    double heightGapForm = scrHeight * 0.05;
    double widthFormInput = scrWidth * 0.75;
    double heightFormInput = 50;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense"),
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: scrHeight,
                width: scrWidth,
                color: generalProvider.mainLight1,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: scrHeight * 0.05,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: widthFormInput,
                          height: heightFormInput,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedType,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 38,
                            elevation: 16,
                            style: TextStyle(
                              color: fontProvider.dropDownInputColor,
                            ),
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedType = newValue!;
                                categories = setCategories(selectedType);
                              });
                            },
                            items: expense.typeList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: heightGapForm,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: widthFormInput,
                          height: heightFormInput,
                          child: DropdownButton<String>(
                            value: selectedCategory,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 42,
                            elevation: 16,
                            style: TextStyle(
                              color: fontProvider.dropDownInputColor,
                            ),
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCategory = newValue!;
                              });
                            },
                            items: categories
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: heightGapForm,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: widthFormInput,
                          height: heightFormInput,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                generalProvider.primarySwatch.withOpacity(.0),
                              ),
                            ),
                            onPressed: () async {
                              final DateTime? selected = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(2010),
                                lastDate: DateTime(2025),
                              );
                              if (selected != null &&
                                  selected != selectedDate) {
                                setState(() {
                                  selectedDate = selected;
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${selectedDate.day}/"
                                  "${selectedDate.month}/"
                                  "${selectedDate.year}"
                                  "${checkDate(selectedDate, DateTime.now()) ? " (Today)" : ""}",
                                  style: TextStyle(
                                    color: fontProvider.dropDownInputColor,
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  color: fontProvider.dropDownInputColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: heightGapForm,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: widthFormInput,
                          height: heightFormInput,
                          child: TextFormField(
                            controller: descTextEditingController,
                            style: TextStyle(
                              color: fontProvider.textFieldInputColor,
                            ),
                            decoration: InputDecoration(
                              hintText: 'description',
                              hintStyle: TextStyle(
                                color: fontProvider.textFieldHintColor,
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(
                                0,
                                0,
                                0,
                                15.0,
                              ),
                              border: InputBorder.none,
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }

                              descTextEditingController.text = value;
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: heightGapForm,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: widthFormInput,
                          height: heightFormInput,
                          child: TextFormField(
                            controller: priceTextEditingController,
                            style: TextStyle(
                              color: fontProvider.textFieldInputColor,
                            ),
                            decoration: InputDecoration(
                              hintText: '0.00',
                              hintStyle: TextStyle(
                                color: fontProvider.textFieldHintColor,
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(
                                0,
                                0,
                                0,
                                15.0,
                              ),
                              border: InputBorder.none,
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the price';
                              }
                              try {
                                double priceInserted = double.parse(value);
                                priceTextEditingController.text =
                                    priceInserted.toString();
                              } on Exception catch (_) {
                                return "Please enter a valid price";
                              }

                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: heightGapForm,
                        ),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              generalProvider.primarySwatch,
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              bool saveStatus = await submit();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Status"),
                                    content: Text(saveStatus
                                        ? "Save Successfully"
                                        : "Failed to save"),
                                    actions: [
                                      TextButton(
                                        child: const Text("Ok"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            categories =
                                                setCategories(selectedType);
                                            priceTextEditingController.text =
                                                "";
                                            descTextEditingController.text = "";
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            child: const Text("R"),
            tooltip: "Reset all data",
            backgroundColor: Colors.red,
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Alert"),
                    content: const Text("Reset all data?"),
                    actions: [
                      TextButton(
                        child: const Text("Reset"),
                        onPressed: () async {
                          Box expenseBox =
                              await Hive.openBox(expense.expenseBox);
                          bool resetStatus = await expenseBox
                              .clear()
                              .then((value) => true)
                              .catchError((_) => false);

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Status"),
                                content: Text(resetStatus
                                    ? "Reset Successfully"
                                    : "Failed to reset"),
                                actions: [
                                  TextButton(
                                    child: const Text("Ok"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      TextButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          FloatingActionButton(
            heroTag: null,
            child: const Text("G"),
            tooltip: "Generate Excel File",
            backgroundColor: Colors.blue,
            onPressed: () async {
              var status = await Permission.manageExternalStorage.status;
              if (status.isGranted) {
                Box expenseBox = await Hive.openBox(expense.expenseBox);

                final exportOpts = export_manager.getExportOptions();
                exportOpts[export_manager.excelFileExt] = true;

                Map<String, Map<String, dynamic>> results = await export_manager
                    .exportFile(
                      category: export_manager.expenseAllCategory,
                      exportOptions: exportOpts,
                      box: expenseBox,
                    )
                    .catchError((onError) => {
                          "": {
                            export_manager.fileNameResultKey: "",
                            export_manager.statusResultKey: false,
                          }
                        });

                String generatedFiles = "Generated Files:\n";
                bool atLeastOneGenerated = false;

                results.forEach((fileExtName, result) {
                  if (result[export_manager.statusResultKey]) {
                    atLeastOneGenerated = true;
                    generatedFiles +=
                        result[export_manager.fileNameResultKey] + "\n";
                  }
                });

                if (!atLeastOneGenerated) {
                  generatedFiles = "Failed to generate file";
                }

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Status"),
                      content: Text(generatedFiles),
                      actions: [
                        TextButton(
                          child: const Text("Ok"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Manage Storage Permission'),
                    content: const Text(
                        'This app needs storage access to save file'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Okay'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: const Text('Settings'),
                        onPressed: () => openAppSettings(),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.75);
    path.cubicTo(
      size.width * 0.65,
      size.height * 0.45,
      size.width * 0.9,
      size.height * 0.05,
      size.width * 0,
      size.height * 0,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
