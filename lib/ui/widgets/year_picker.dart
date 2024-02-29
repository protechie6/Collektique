import 'package:flutter/material.dart';

class SelectYearDialog extends StatefulWidget {
  const SelectYearDialog({Key? key, required this.selectedYear, this.year})
      : super(key: key);

  final ValueChanged<String> selectedYear;
  final String? year;

  @override
  State<StatefulWidget> createState() => SelectYearDialogState();
}

class SelectYearDialogState extends State<SelectYearDialog> {
  late String year;
  DateTime _selectedYear = DateTime.now();

  @override
  void initState() {
    if (widget.year == null) {
      year = "Add details";
    } else {
      year = widget.year!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextButton(
        onPressed: () async {
          showDialog(
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Add Year"),
                  content: SizedBox(
                    width: 250,
                    height: 250,
                    child: YearPicker(
                        firstDate:
                            DateTime(1900 /*DateTime.now().year - 23,1*/),
                        lastDate: DateTime(2050),
                        selectedDate: _selectedYear,
                        onChanged: (DateTime dateTime) {
                          setState(() {
                            _selectedYear = dateTime;
                            year = "${dateTime.year}";
                            widget.selectedYear(year);
                          });
                          Navigator.of(context).pop();
                        }),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(15),
                        child: const Text("Cancel",
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Color.fromRGBO(32, 72, 72, 1),
                                fontFamily: 'Poppins')),
                      ),
                    ),
                  ],
                );
              },
              context: context);
        },
        child: Text(year,
            style: const TextStyle(
                fontSize: 14.0,
                color: Color.fromRGBO(32, 72, 72, 1),
                fontFamily: 'Poppins')),
      ),
    );
  }
}
