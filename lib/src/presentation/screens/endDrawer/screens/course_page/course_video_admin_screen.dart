import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tobeto/src/common/constants/firebase_constants.dart';
import 'package:tobeto/src/common/utilities/utilities.dart';
import 'package:tobeto/src/domain/repositories/course_repository.dart';
import 'package:tobeto/src/domain/repositories/firebase_storage_repository.dart';
import 'package:tobeto/src/models/course_model.dart';
import 'package:tobeto/src/models/course_video_model.dart';
import 'package:tobeto/src/presentation/widgets/input_field.dart';
import 'package:tobeto/src/presentation/widgets/purple_button.dart';
import 'package:tobeto/src/presentation/widgets/tbt_admin_sliver_app_bar.dart';
import 'package:tobeto/src/presentation/widgets/tbt_animated_container.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

class AdminCourseVideoScreen extends StatefulWidget {
  const AdminCourseVideoScreen({super.key});

  @override
  State<AdminCourseVideoScreen> createState() => _AdminCourseVideoScreenState();
}

class _AdminCourseVideoScreenState extends State<AdminCourseVideoScreen> {
  final TextEditingController _courseVideoNameController =
      TextEditingController();
  final TextEditingController _editCourseVideoNameController =
      TextEditingController();

  XFile? _selectedVideo;
  bool selected = false;
  VideoPlayerController? _videoPlayerController;
  List<String> courseNames = [];
  List<CourseModel> courses = [];
  String? selectedCourseName;
  String? selectedCourseId;
  final CourseRepository _courseRepository = CourseRepository();

  @override
  void initState() {
    fetchCourseNames();
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Future<void> fetchCourseNames() async {
    List<String> names = await _courseRepository.fetchCourseNamesList();
    setState(() {
      courseNames = names;
    });
  }

  // void _pickVideo() async {
  //   final videoPicker = ImagePicker();
  //   XFile? file = await videoPicker.pickVideo(source: ImageSource.gallery);

  //   if (file != null) {
  //     _videoPlayerController = VideoPlayerController.file(File(file.path))
  //       ..initialize().then((_) {
  //         setState(() {
  //           selectedVideo = file;
  //           selected = true;
  //         });
  //         _videoPlayerController!.play();
  //       });
  //   }
  // }
  Future<void> _getVideoFromGallery() async {
    final video = await Utilities.getVideoFromGallery();
    if (video != null) {
      _videoPlayerController = VideoPlayerController.file(File(video.path))
        ..initialize().then((_) {
          setState(() {
            _selectedVideo = video;
            selected = true;
          });
          _videoPlayerController!.play();
        });
    }
  }

  void _addCourseVideo(
      {required BuildContext context,
      required String selectedCourseId,
      required String courseVideoName,
      required String selectedCourseName}) async {
    if (_selectedVideo != null && _courseVideoNameController.text.isNotEmpty) {
      String? videoUrl = await FirebaseStorageRepository()
          .uploadCourseVideoAndSaveUrl(selectedVideo: _selectedVideo);
      if (videoUrl != null) {
        CourseVideoModel courseVideoModel = CourseVideoModel(
          videoId: const Uuid().v1(),
          courseId: selectedCourseId,
          courseVideoName: _courseVideoNameController.text,
          courseName: selectedCourseName,
          videoUrl: videoUrl,
        );
        String result =
            await _courseRepository.addOrUpdateCourseVideo(courseVideoModel);

        if (!context.mounted) return;
        Utilities.showSnackBar(
          snackBarMessage: result,
          context: context,
        );
      }
    }
  }

  void _deleteVideoFunction(
      {required BuildContext context, required String videoId}) async {
    String result = await _courseRepository.deleteVideo(videoId);

    if (!context.mounted) return;
    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  void _editVideoFunction({
    required BuildContext context,
    required String videoId,
    required String selectedCourseId,
    required String newCourseVideoName,
  }) async {
    String newCourseVideoName = _editCourseVideoNameController.text;
    String newCourseId = selectedCourseId;

    String result = await _courseRepository.editVideo(
        videoId, newCourseVideoName, newCourseId, selectedCourseName!);

    if (!context.mounted) return;
    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  void _showEditDialog(
      {required BuildContext context, required String videoId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Seçili Videoyu Düzenle"),
          content: StreamBuilder<List<CourseModel>>(
            stream: _courseRepository.fetchAllCourses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No courses available.'));
              } else {
                List<CourseModel> courses = snapshot.data!;
                List<String> courseNames =
                    courses.map((course) => course.courseName).toList();

                return Column(
                  children: [
                    TBTInputField(
                      hintText: 'Yeni Video ismini girin.',
                      controller: _editCourseVideoNameController,
                      onSaved: (p0) {},
                      keyboardType: TextInputType.multiline,
                    ),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      hint: const Text("Ders Kategorisi"),
                      value: selectedCourseName,
                      items: courseNames.map(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedCourseName = newValue;

                          selectedCourseId = courses
                              .firstWhere(
                                  (course) => course.courseName == newValue)
                              .courseId;
                        });
                      },
                    ),
                  ],
                );
              }
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _editVideoFunction(
                    context: context,
                    videoId: videoId,
                    selectedCourseId: selectedCourseId!,
                    newCourseVideoName: _editCourseVideoNameController.text);
                Navigator.pop(context);
              },
              child: Text(
                "Değişiklikleri Kaydet",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const TBTAdminSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "Ders Videosu Ekle & Düzenle",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        TBTAnimatedContainer(
                          height: 400,
                          infoText: 'Ders Videosu Ekle',
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: _getVideoFromGallery,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 50,
                                      top: 30,
                                    ),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              150, 150, 150, 0.2),
                                          image: selected
                                              ? DecorationImage(
                                                  image: FileImage(
                                                    File(_selectedVideo!.path),
                                                  ),
                                                )
                                              : null,
                                        ),
                                        child: selected
                                            ? null
                                            : const Icon(
                                                Icons.video_call,
                                                size: 50,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                TBTInputField(
                                  hintText: 'Ders Video İsmi',
                                  controller: _courseVideoNameController,
                                  onSaved: (p0) {},
                                  keyboardType: TextInputType.multiline,
                                ),
                                DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  hint: const Text("Ders Kategorisi"),
                                  value: selectedCourseName,
                                  items: courseNames.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(
                                      () {
                                        selectedCourseName = newValue;
                                        selectedCourseId = courses
                                            .firstWhere((course) =>
                                                course.courseName == newValue)
                                            .courseId;
                                      },
                                    );
                                  },
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: TBTPurpleButton(
                                    buttonText: "Kaydet",
                                    onPressed: () {
                                      _addCourseVideo(
                                          context: context,
                                          selectedCourseId: selectedCourseId!,
                                          selectedCourseName:
                                              selectedCourseName!,
                                          courseVideoName: selectedCourseName!);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(FirebaseConstants.videosCollection)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot documentSnapshot =
                                      snapshot.data!.docs[index];

                                  CourseVideoModel courseVideoModel =
                                      CourseVideoModel.fromMap(documentSnapshot
                                          .data() as Map<String, dynamic>);

                                  return Slidable(
                                    key: ValueKey(index),
                                    endActionPane: ActionPane(
                                      extentRatio: 0.6,
                                      motion: const DrawerMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) =>
                                              _deleteVideoFunction(
                                            context: context,
                                            videoId: courseVideoModel.videoId,
                                          ),
                                          backgroundColor:
                                              const Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Sil',
                                        ),
                                        SlidableAction(
                                          onPressed: (context) {
                                            _showEditDialog(
                                                context: context,
                                                videoId:
                                                    courseVideoModel.videoId);
                                          },
                                          backgroundColor:
                                              const Color(0xFF21B7CA),
                                          foregroundColor: Colors.white,
                                          icon: Icons.edit,
                                          label: 'Düzenle',
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      title: Text(
                                          'Video adı: ${courseVideoModel.courseVideoName}'),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
