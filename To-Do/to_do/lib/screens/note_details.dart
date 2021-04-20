import 'package:flutter/material.dart';
import 'package:to_do/services/crud.dart';
import 'package:to_do/shared/styles.dart';
import 'package:to_do/widgets/flat_button.dart';

import 'package:unicons/unicons.dart';

class NoteDetails extends StatefulWidget {
  final String tasktitle, taskDetail, taskId, taskPriority;

  const NoteDetails({
    Key key,
    this.tasktitle,
    this.taskDetail,
    this.taskId,
    this.taskPriority,
  }) : super(key: key);

  @override
  _NoteDetailsState createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  CrudMethods crudobj = new CrudMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: labelColor),
          elevation: 0,
          backgroundColor: backgroundColor,
          title: Text(
            "Details",
            style: titlelabelStyle.copyWith(fontSize: 25),
          ),
        ),
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: ListView(
            children: [
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 10.0),
                child: Text(
                  widget.tasktitle,
                  style: titlelabelStyle.copyWith(fontSize: 22),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: fillColor),
                  child: (Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          UniconsLine.bookmark,
                          size: 35,
                          color: primarySwatchColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.taskDetail,
                          style: subtitlelabelStyle,
                        ),
                      ),
                    ],
                  )),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              FlatButtonHelper(
                text: "Delete",
                onPressed: () {
                  crudobj.deleteData(widget.taskId, "todos");

                  Map<String, dynamic> noteData = {
                    'taskTitle': this.widget.tasktitle,
                    'taskDescription': this.widget.taskDetail,
                    'taskPriority': this.widget.taskPriority
                  };
                  crudobj.addTask(noteData, "deletedTodos");
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ));
  }
}
