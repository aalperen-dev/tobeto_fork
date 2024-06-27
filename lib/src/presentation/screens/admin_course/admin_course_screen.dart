import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../common/export_common.dart';
import '../../../domain/export_domain.dart';
import '../../../models/export_models.dart';
import '../../widgets/export_widgets.dart';

class AdminCourseScreen extends StatefulWidget {
  const AdminCourseScreen({super.key});

  @override
  State<AdminCourseScreen> createState() => _AdminCoursePageState();
}

class _AdminCoursePageState extends State<AdminCourseScreen> {
  CourseRepository courseRepository = CourseRepository();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  XFile? _selectedImage;
  bool selected = false;

  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _manufacturerController = TextEditingController();
  final TextEditingController _editCourseNameController =
      TextEditingController();
  final TextEditingController _editManufacturerController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _courseNameController.dispose();
    _manufacturerController.dispose();
    _editCourseNameController.dispose();
    _editManufacturerController.dispose();
  }

  void _pickImage() async {
    final imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(
        () {
          _selectedImage = file;
          selected = true;
        },
      );
    }
  }

  void _addCourse(
      {required BuildContext context,
      required String courseName,
      required DateTime startDate,
      required DateTime endDate,
      required String manufacturer}) async {
    List<String> adminIdsList = await UserRepository().getAdminIds();
    UserModel? currentUser = await UserRepository().getCurrentUser();
    List<String?> courseInstructorsIds = [];
    if (currentUser!.userRank == UserRank.instructor) {
      courseInstructorsIds.add(currentUser.userId);
    }
    courseInstructorsIds += adminIdsList;

    String courseId = const Uuid().v1();
    String? courseThumbnailUrl = await FirebaseStorageRepository()
        .uploadCourseThumbnailsAndSaveUrl(
            selectedCourseThumbnail: _selectedImage);
    CourseModel courseModel = CourseModel(
      courseId: courseId,
      courseThumbnailUrl: courseThumbnailUrl!,
      courseName: courseName,
      courseStartDate: selectedStartDate!,
      courseEndDate: selectedEndDate!,
      courseManufacturer: manufacturer,
      courseInstructorsIds: courseInstructorsIds,
    );

    String result = await CourseRepository().addCourse(courseModel);

    if (!context.mounted) return;
    Utilities.showSnackBar(
      snackBarMessage: result,
      context: context,
    );
  }

  void _deleteCourse(
      {required BuildContext context, required String videoId}) async {
    String result = await courseRepository.deleteCourse(videoId);

    if (!context.mounted) return;
    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  void _editCourseFunction(
      {required BuildContext context,
      required String selectedCourseId,
      required String newCourseName,
      required String newManufacturer}) async {
    String result = await courseRepository.editCourse(
        selectedCourseId, newCourseName, newManufacturer);
    if (!context.mounted) return;
    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  void _showEditDialog(
      {required BuildContext context, required String courseId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Seçili Dersi Düzenle",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          content: StreamBuilder<List<CourseModel>>(
            stream: courseRepository.fetchAllCoursesAsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No courses available.'));
              } else {
                return Column(
                  children: [
                    TBTInputField(
                      hintText: 'Yeni Ders ismini girin.',
                      controller: _editCourseNameController,
                      onSaved: (p0) {},
                      keyboardType: TextInputType.multiline,
                    ),
                    TBTInputField(
                      hintText: 'Ders üretici firma ismini girin.',
                      controller: _editManufacturerController,
                      onSaved: (p0) {},
                      keyboardType: TextInputType.multiline,
                    ),
                  ],
                );
              }
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _editCourseFunction(
                    selectedCourseId: courseId,
                    newCourseName: _editCourseNameController.text,
                    newManufacturer: _editManufacturerController.text,
                    context: context);
                Navigator.pop(context);
              },
              child: Text(
                "Değişiklikleri Kaydet",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            )
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
                        TBTAnimatedContainer(
                          height: 300,
                          infoText: "Ders Ekle & Düzenle",
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _pickImage();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 50, top: 30),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            150, 150, 150, 0.2),
                                        image: selected
                                            ? DecorationImage(
                                                image: FileImage(
                                                  File(_selectedImage!.path),
                                                ),
                                              )
                                            : null,
                                      ),
                                      child: selected
                                          ? null
                                          : const Icon(
                                              Icons.camera_alt,
                                              size: 50,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              TBTInputField(
                                hintText: 'Ders İsmi',
                                controller: _courseNameController,
                                onSaved: (p0) {},
                                keyboardType: TextInputType.multiline,
                              ),
                              TBTInputField(
                                hintText: 'Üretici Firma',
                                controller: _manufacturerController,
                                onSaved: (p0) {},
                                keyboardType: TextInputType.multiline,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton.icon(
                                    icon: const Icon(
                                        Icons.calendar_today_outlined),
                                    onPressed: () async {
                                      selectedStartDate =
                                          await Utilities.datePicker(context);
                                      setState(() {});
                                    },
                                    label: Text(
                                      style: const TextStyle(fontSize: 10),
                                      selectedStartDate == null
                                          ? 'Başlangıç Tarihi Seç'
                                          : DateFormat('dd/MM/yyyy')
                                              .format(selectedStartDate!),
                                    ),
                                  ),
                                  TextButton.icon(
                                    icon: Icon(
                                      Icons.calendar_today_outlined,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    onPressed: () async {
                                      selectedEndDate =
                                          await Utilities.datePicker(context);
                                      setState(() {});
                                    },
                                    label: Text(
                                      style: const TextStyle(fontSize: 10),
                                      selectedEndDate == null
                                          ? 'Bitiş Tarihi Seç'
                                          : DateFormat('dd/MM/yyyy')
                                              .format(selectedEndDate!),
                                    ),
                                  ),
                                ],
                              ),
                              TBTPurpleButton(
                                buttonText: "Ders Ekle",
                                onPressed: () => _addCourse(
                                  courseName: _courseNameController.text,
                                  startDate: selectedStartDate!,
                                  endDate: selectedEndDate!,
                                  manufacturer: _manufacturerController.text,
                                  context: context,
                                ),
                              ),
                            ],
                          ),
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(FirebaseConstants.coursesCollection)
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

                                  CourseModel courseModel = CourseModel.fromMap(
                                      documentSnapshot.data()
                                          as Map<String, dynamic>);

                                  return Slidable(
                                    key: ValueKey(index),
                                    endActionPane: ActionPane(
                                      extentRatio: 0.6,
                                      motion: const DrawerMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) => _deleteCourse(
                                            videoId: courseModel.courseId,
                                            context: context,
                                          ),
                                          backgroundColor:
                                              const Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Sil',
                                        ),
                                        SlidableAction(
                                          onPressed: (context) =>
                                              _showEditDialog(
                                                  courseId:
                                                      courseModel.courseId,
                                                  context: context),
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
                                        'Ders adı: ${courseModel.courseName}',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
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
