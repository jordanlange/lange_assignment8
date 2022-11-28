import 'package:flutter/material.dart';
import 'package:lange_a8/editStudent.dart';
import 'package:lange_a8/editCourse.dart';
import 'api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final SchoolAPI api = SchoolAPI();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List courses = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();

    widget.api.getAllCourses().then((data) {
      setState(() {
        courses = data;
        data.sort((a, b) {
          return a['courseName']
              .toLowerCase()
              .compareTo(b['courseName'].toLowerCase());
        });
        _dbLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' School App'),
      ),
      body: Center(
          child: _dbLoaded
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Courses',
                        style: TextStyle(
                            fontSize: 30, color: Colors.deepPurpleAccent),
                      ),
                    ),
                    Expanded(
                        child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(15.0),
                      children: [
                        ...courses.map<Widget>(
                          (course) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: TextButton(
                              onPressed: () => {
                                Navigator.pop(context),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => editCourse(
                                            course['_id'],
                                            course['courseInstructor'],
                                            course['courseCredits'],
                                            course['courseID'],
                                            course['courseName'],
                                            course['dateEntered']))),
                              },
                              child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 50,
                                    child: Text(course['courseID']),
                                  ),
                                  title: Column(children: <Widget>[
                                    Text(
                                      course['courseName'],
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      course['courseInstructor'],
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    Text(
                                      course['courseCredits'],
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ])),
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
    );
  }
}
