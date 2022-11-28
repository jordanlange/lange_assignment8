import 'package:flutter/material.dart';
import 'package:lange_a8/api.dart';
import 'package:lange_a8/editStudent.dart';
import 'package:lange_a8/main.dart';

class editCourse extends StatefulWidget {
  final String id,
      courseInstructor,
      courseCredits,
      courseID,
      courseName,
      dateEntered;
  final SchoolAPI api = SchoolAPI();

  editCourse(this.id, this.courseInstructor, this.courseCredits, this.courseID,
      this.courseName, this.dateEntered);

  @override
  State<editCourse> createState() => _editCourseState(
      id, courseInstructor, courseCredits, courseID, courseName, dateEntered);
}

class _editCourseState extends State<editCourse> {
  final String id,
      courseInstructor,
      courseCredits,
      courseID,
      courseName,
      dateEntered;

  _editCourseState(this.id, this.courseInstructor, this.courseCredits,
      this.courseID, this.courseName, this.dateEntered);

  void _changeCourseInstructor(courseName, courseInstructor) {
    setState(() {
      widget.api.editCourse(courseName, courseInstructor);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  void _deleteCourse(id) {
    setState(() {
      widget.api.deleteCourse(id);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  List students = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();

    widget.api.getAllStudents().then((data) {
      setState(() {
        students = data;
        data.sort((a, b) {
          return a['fname'].toLowerCase().compareTo(b['fname'].toLowerCase());
        });
        _dbLoaded = true;
      });
    });
  }

  TextEditingController instructorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
      ),
      body: Center(
          child: _dbLoaded
              ? Column(
                  children: [
                    Expanded(
                        child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(15.0),
                      children: [
                        ElevatedButton(
                          onPressed: () => {
                            _deleteCourse(widget.id),
                          },
                          child: Text("Delete Course"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            'Student List',
                            style: TextStyle(
                                fontSize: 30, color: Colors.deepPurpleAccent),
                          ),
                        ),
                        ...students.map<Widget>(
                          (student) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: TextButton(
                              onPressed: () => {
                                Navigator.pop(context),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => editStudent(
                                            student['_id'],
                                            student['fname'],
                                            student['lname'],
                                            student['studentID'],
                                            student['dateEntered']))),
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  child: Text(student['studentID']),
                                ),
                                title: Text(
                                  student['fname'] + " " + student['lname'],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Database Loading",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    CircularProgressIndicator()
                  ],
                )),
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
