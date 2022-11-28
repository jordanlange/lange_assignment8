import 'package:flutter/material.dart';
import 'package:lange_a8/api.dart';
import 'package:lange_a8/main.dart';

class editStudent extends StatefulWidget {
  final String id, fname, lname, studentID, dateEntered;
  final SchoolAPI api = SchoolAPI();

  editStudent(
      this.id, this.fname, this.lname, this.studentID, this.dateEntered);

  @override
  State<editStudent> createState() =>
      _editStudentState(id, fname, lname, studentID, dateEntered);
}

class _editStudentState extends State<editStudent> {
  final String id, fname, lname, studentID, dateEntered;

  _editStudentState(
      this.id, this.fname, this.lname, this.studentID, this.dateEntered);

  void _changeStudentFname(id, fname) {
    setState(() {
      widget.api.editStudent(id, fname);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  TextEditingController fnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fname + ' ' + widget.lname),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Text(
                    "Enter a new first name for Student: " +
                        widget.fname +
                        " " +
                        widget.lname,
                    style: TextStyle(fontSize: 15),
                  ),
                  TextFormField(
                    controller: fnameController,
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      _changeStudentFname(widget.id, fnameController.text),
                    },
                    child: Text("Change First Name"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () => {
                Navigator.pop(context),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage())),
              }),
    );
  }
}
