// ignore_for_file: camel_case_types, file_names, unused_local_variable, unused_element, unnecessary_null_comparison, prefer_const_constructors, prefer_final_fields, unused_field, no_logic_in_create_state, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:db_todo/note.dart';
import 'package:db_todo/database_helper.dart';
import 'package:intl/intl.dart';

class noteDetail extends StatefulWidget {
  noteDetail(this.appBarTitle, this.note);
  final String? appBarTitle;
  final Note? note;

  @override
  State<StatefulWidget> createState() {
    return _noteDetailState(note!, appBarTitle!);
  }
}

class _noteDetailState extends State<noteDetail> {
  final Note note;
  final String appBarTitle;
  _noteDetailState(this.note, this.appBarTitle);
  static var _priority = ['High', 'Low'];
  DatabaseHelper databaseHelper = DatabaseHelper();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = note.title??'';
    descriptionController.text = note.description??'';
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            centerTitle: true,
            leading: IconButton(
              onPressed: moveToLastScreen,
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
                    //dropdown menu
                    child: ListTile(
                      leading: const Icon(Icons.low_priority),
                      title: DropdownButton(
                          items: _priority.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                            );
                          }).toList(),
                          value: updatePriorityString(note.priority??-1),
                          onChanged: (valueSelectedByUser) {
                            setState(() {
                              updatePriorityasInt(
                                  valueSelectedByUser.toString());
                            });
                          }),
                    ),
                  ),
                  // Second Element
                  Padding(
                    padding:
                        EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                    child: TextField(
                      controller: titleController,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      onChanged: (value) {
                        updateTitle();
                      },
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20),
                        icon: Icon(Icons.title),
                      ),
                    ),
                  ),

                  // Third Element
                  Padding(
                    padding:
                        EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                    child: TextField(
                      controller: descriptionController,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      onChanged: (value) {
                        updateDescription();
                      },
                      decoration: InputDecoration(
                        labelText: 'Details',
                        icon: Icon(Icons.details),
                      ),
                    ),
                  ),

                  // Fourth Element
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            child: Text(
                              'Save',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                debugPrint("Save button clicked");
                                _save();
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 5.0,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            child: Text(
                              'Delete',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                _delete();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () {
          return moveToLastScreen();
        });
  }

  _delete() async {
    moveToLastScreen();

    if (note.id == null) {
      _showAlertDialog('Status', 'First write note');
      return;
    }

    int result = await databaseHelper.deleteNote(note.id??0);
    if (result != 0) {
      _showAlertDialog('Status', 'Deleted successfully');
    } else {
      _showAlertDialog('Status', "Error");
    }
  }

  //Convert String to int;

  updatePriorityasInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  //Convert int to String
  String updatePriorityString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priority[0];
        break;
      case 2:
        priority = _priority[1];
        break;
      default:
        priority = 'Low';
    }
    return priority;
  }

  updateTitle() {
    note.title = titleController.text;
  }

  updateDescription() async {
    note.description = descriptionController.text;
    note.date = DateFormat.yMMMd().format(DateTime.now());
    // int result;
    // if (note.id != null) {
    //   result = await databaseHelper.updateNote(note);
    // } else {
    //   result = await databaseHelper.insertData(note);
    // }
    // if (result != 0) {
    //   _showAlertDialog('Status', 'Note Saved successfully');
    // } else {
    //   _showAlertDialog('Status', "Problem saving note");
    // }
  }

  _save() async {
    moveToLastScreen();
  }

  moveToLastScreen() {
    Navigator.pop(context, true);
  }

  _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
