import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do/screens/note_details.dart';
import 'package:to_do/services/crud.dart';
import 'package:to_do/shared/styles.dart';

import 'package:unicons/unicons.dart';

class NotePage extends StatefulWidget {
  final String title;
  final IconData trailingIcon;
  final Stream task;
  const NotePage({Key key, this.trailingIcon, this.title, this.task})
      : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: Text(
          widget.title,
          style: titlelabelStyle.copyWith(fontSize: 25),
        ),
      ),
      body: Container(
          color: backgroundColor,
          height: MediaQuery.of(context).size.height,
          child: noteList()),
    );
  }

  Widget noteList() {
    return StreamBuilder(
      stream: widget.task,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: fillColor),
                  child: ListTile(
                    subtitle: Text(
                      "Priority: " +
                          snapshot.data.documents[index].data['taskPriority'],
                      style: subtitlelabelStyle,
                    ),
                    onTap: () {
                      if (widget.trailingIcon == UniconsLine.angle_right_b) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoteDetails(
                                      tasktitle: snapshot.data.documents[index]
                                          .data['taskTitle'],
                                      taskDetail: snapshot.data.documents[index]
                                          .data['taskDescription'],
                                      taskId: snapshot
                                          .data.documents[index].documentID,
                                      taskPriority: snapshot
                                          .data
                                          .documents[index]
                                          .data['taskPriority'],
                                    )));
                      }
                    },
                    leading: Icon(UniconsLine.pen),
                    title: Text(
                      snapshot.data.documents[index].data['taskTitle'],
                      style: titlelabelStyle,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        if (widget.trailingIcon == UniconsLine.angle_right_b) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NoteDetails(
                                        tasktitle: snapshot.data
                                            .documents[index].data['taskTitle'],
                                        taskDetail: snapshot
                                            .data
                                            .documents[index]
                                            .data['taskDescription'],
                                        taskId: snapshot
                                            .data.documents[index].documentID,
                                      )));
                        }
                      },
                      icon: Icon(widget.trailingIcon),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
