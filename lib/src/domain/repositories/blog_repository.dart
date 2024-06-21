import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobeto/src/common/utilities/utilities.dart';
import 'package:tobeto/src/models/blog_model.dart';

import '../../common/constants/firebase_constants.dart';

class BlogRepository {
  final bool isBlog;
  BlogRepository({required this.isBlog});
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference get _blogs =>
      _firebaseFirestore.collection(FirebaseConstants.blogsCollection);
  CollectionReference get _inThePress =>
      _firebaseFirestore.collection(FirebaseConstants.inThePressCollection);

  Future<String> addOrUpdateBlog({
    required BlogModel blogModel,
  }) async {
    String result = '';

    if (isBlog == true) {
      try {
        await _blogs.doc(blogModel.blogId).set(blogModel.toMap());
        result = 'success';
      } catch (error) {
        result = error.toString();
      }
    } else {
      try {
        await _inThePress.doc(blogModel.blogId).set(blogModel.toMap());
        result = 'success';
      } catch (error) {
        result = error.toString();
      }
    }
    return Utilities.errorMessageChecker(result);
  }

  Future<String> deleteBlog({
    required BlogModel blogModel,
  }) async {
    String result = '';

    if (isBlog == true) {
      try {
        await _blogs.doc(blogModel.blogId).delete();
        result = 'success';
      } catch (error) {
        result = error.toString();
      }
    } else {
      try {
        await _inThePress.doc(blogModel.blogId).delete();
        result = 'success';
      } catch (error) {
        result = error.toString();
      }
    }
    return Utilities.errorMessageChecker(result);
  }
}
