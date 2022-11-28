import 'package:dio/dio.dart';

import './Models/courses.dart';

const String localhost = "http://10.0.2.2:1200/";

class SchoolAPI {
  final _dio = Dio(BaseOptions(baseUrl: localhost));

  Future<List> getAllCourses() async {
    final response = await _dio.get('/getAllCourses');

    return response.data['courses'];
  }

  Future<List> getAllStudents() async {
    final response = await _dio.get('/getAllStudents');

    return response.data['students'];
  }

  Future editCourse(String courseName, String courseInstructor) async {
    final response = await _dio.post('/editCourseByCourseName',
        data: {'courseName': courseName, 'courseInstructor': courseInstructor});
    return response.data;
  }

  Future editStudent(String id, String fname) async {
    final response =
        await _dio.post('/editStudentById', data: {'id': id, 'fname': fname});
    return response.data;
  }

  Future deleteCourse(String id) async {
    final response = await _dio.post('/deleteCourseById', data: {'id': id});
  }
}
