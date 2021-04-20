import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:to_do/services/crud.dart';
import 'package:to_do/shared/styles.dart';

class AddNotesPage extends StatefulWidget {
  final VoidCallback onButtonPressed;
  const AddNotesPage({Key key, this.onButtonPressed}) : super(key: key);

  @override
  _AddNotesPageState createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  // List note = [];
  // String input = "";

  String _notetitle, _notedescription, _priority;

  CrudMethods crudObj = new CrudMethods();

  TextEditingController _titleController = new TextEditingController();
  TextEditingController _noteController = new TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: Text(
          "Add Your Task",
          style: titlelabelStyle.copyWith(fontSize: 25),
        ),
      )),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              onChanged: (value) {
                _notetitle = value;
              },
              decoration: inputDecoration.copyWith(hintText: "title"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _selectPriority(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                _notedescription = value;
              },
              maxLines: 15,
              controller: _noteController,
              decoration: inputDecoration.copyWith(hintText: "Task"),
            ),
          ),
          Container(
              margin: EdgeInsets.all(12),
              height: 3 * 20.0,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(primarySwatchColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(color: primarySwatchColor)))),
                child: Text(
                  "Add Task",
                  style: subtitlelabelStyle.copyWith(
                      fontSize: 25, color: backgroundColor),
                ),
                onPressed: () {
                  Map<String, dynamic> noteData = {
                    'taskTitle': this._notetitle,
                    'taskDescription': this._notedescription,
                    'taskPriority': this._priority
                  };
                  crudObj.addTask(noteData, "todos").then((result) {
                    dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });

                  setState(() {
                    _titleController.clear();
                    _noteController.clear();
                  });
                },
              ))
        ],
      ),
    );
  }

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Added"),
            title: Text(
              "Task Added",
              style: titlelabelStyle,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget _selectPriority() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xfff5f5f5),
          border: Border.all(color: backgroundColor, width: 1)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Priority",
              style: subtitlelabelStyle,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.09,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _priority,
              //elevation: 5,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              items: <String>['High', 'Medium', 'Low']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                      //color: Color(0xffaedef5),
                      child: Text(
                    value,
                    style: GoogleFonts.montserrat(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Colors.grey),
                  )),
                );
              }).toList(),
              hint: Text("Set Priority", style: subtitlelabelStyle),
              onChanged: (String value) {
                setState(() {
                  _priority = value;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

InputDecoration inputDecoration = InputDecoration(
  hintStyle: subtitlelabelStyle,
  fillColor: fillColor,
  filled: true,
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: backgroundColor, width: 1.0),
    borderRadius: BorderRadius.circular(15.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: fillColor, width: 0.0),
    borderRadius: BorderRadius.circular(15.0),
  ),
);
