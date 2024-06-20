import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'dart:io';

import 'package:tobeto/src/models/course_model.dart';
import 'package:tobeto/src/models/course_video_model.dart';

class CourseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Future<List<CourseModel>> fetchAllCourses() async {
  //   try {
  //     final querySnapshot = await _firestore.collection('courses').get();
  //     return querySnapshot.docs
  //         .map((doc) => CourseModel.fromMap(doc.data()))
  //         .toList();
  //   } catch (e) {
  //     throw Exception('Error fetching courses: $e');
  //   }
  // }
  Stream<List<CourseModel>> fetchAllCourses() {
    return _firestore
        .collection(FirebaseConstants.coursesCollection)
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs
            .map((doc) => CourseModel.fromMap(doc.data()))
            .toList();
      },
    );
  }

  Stream<List<String>> fetchCourseNames() {
    return _firestore
        .collection(FirebaseConstants.coursesCollection)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc['courseName'] as String).toList();
    });
  }

  Future<List<CourseVideoModel>> fetchCourseVideos(String courseId) async {
    try {
      final querySnapshot = await _firestore
          .collection(FirebaseConstants.videosCollection)
          .where('courseId', isEqualTo: courseId)
          .get();

      return querySnapshot.docs
          .map((doc) => CourseVideoModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error fetching course videos: $e');
    }
  }

  Future<void> addCourse(CourseModel course) async {
    try {
      //await _firestore.collection('courses').doc(course.).set(course.toMap());
    } catch (e) {
      throw Exception('Error adding course: $e');
    }
  }

  // Admin panelinde video yüklemek için
  // Future<void> uploadVideoAndSaveUrl(String courseId, File videoFile) async {
  //   try {
  //     // Upload video to Firebase Storage
  //     String filePath =
  //         'videos/$courseId/${DateTime.now().millisecondsSinceEpoch}.mp4';
  //     UploadTask uploadTask = _storage.ref().child(filePath).putFile(videoFile);
  //     TaskSnapshot snapshot = await uploadTask;
  //     String videoUrl = await snapshot.ref.getDownloadURL();

  //     // Save video URL to Firestore
  //     await _firestore
  //         .collection('courses')
  //         .doc(courseId)
  //         .collection('videos')
  //         .add({
  //       'videoUrl': videoUrl,
  //       'courseVideoName': 'Video Name',
  //       'courseInstructor': 'Instructor Name',
  //       'startDate': '2024-01-01',
  //       'endDate': '2024-02-01',
  //       'estimatedDate': '2024-01-15',
  //       'manufacturer': 'Manufacturer Name'
  //     });
  //   } catch (e) {
  //     throw Exception('Error uploading video and saving URL: $e');
  //   }
  // }

  Future<void> editVideo(String videoId, String newCourseVideoName,
      String newCourseId, String newCourseName) async {
    try {
      await _firestore
          .collection(FirebaseConstants.videosCollection)
          .doc(videoId)
          .update(
        {
          'courseVideoName': newCourseVideoName,
          'courseId': newCourseId,
          'courseName': newCourseName,
        },
      );
    } catch (e) {
      throw Exception('Ders videosunu güncellerken hata: $e');
    }
  }

  Future<void> editCourse(
      String courseId, String newCourseName, String manufacturer) async {
    try {
      await _firestore
          .collection(FirebaseConstants.coursesCollection)
          .doc(courseId)
          .update(
        {
          'courseName': newCourseName,
          'manufacturer': manufacturer,
        },
      );
    } catch (e) {
      throw Exception('Dersi güncellerken hata: $e');
    }
  }

  // Future<void> editCourse(
  //     String courseId, String newCourseName, String? newCourseId) async {
  //   try {
  //     await _firestore.collection('videos').doc(videoId).update({
  //       'courseVideoName': newCourseVideoName,
  //       'courseId': newCourseId,
  //     });
  //   } catch (e) {
  //     throw Exception('Error updating video: $e');
  //   }
  // }
  Future<void> saveCourseVideo(CourseVideoModel courseVideoModel) async {
    await _firestore
        .collection(FirebaseConstants.videosCollection)
        .doc(courseVideoModel.videoId)
        .set(courseVideoModel.toMap());
  }

  Future<void> saveCourse(CourseModel courseModel) async {
    await _firestore
        .collection(FirebaseConstants.coursesCollection)
        .doc(courseModel.courseId)
        .set(courseModel.toMap());
  }

  // Admin panelinden ders silmek için
  Future<void> deleteCourse(String courseId) async {
    try {
      await _firestore
          .collection(FirebaseConstants.coursesCollection)
          .doc(courseId)
          .delete();
    } catch (e) {
      throw Exception('Error deleting course: $e');
    }
  }

  Future<void> deleteVideo(String videoId) async {
    try {
      await _firestore
          .collection(FirebaseConstants.videosCollection)
          .doc(videoId)
          .delete();

      await _storage.ref('videos/$videoId').delete();
    } catch (e) {
      throw Exception('Error deleting course: $e');
    }
  }
}
