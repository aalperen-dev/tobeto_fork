import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/blocs/auth/auth_bloc.dart';
import 'package:tobeto/src/common/constants/utilities.dart';
import 'package:tobeto/src/domain/repositories/experience_repository.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/experience_model.dart';
import 'package:tobeto/src/models/user_model.dart';
import 'package:tobeto/src/presentation/widgets/tbt_animated_container.dart';
import 'package:uuid/uuid.dart';
import '../../../widgets/input_field.dart';
import '../../../widgets/purple_button.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _sectorController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _jobdescrbController = TextEditingController();

  String? _selectedExperienceType;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  bool _isCurrentlyWorking = false;
  bool isSelect = false;

  List<Map<String, String>> _cities = [];
  String? _selectedCityId;
  String? _selectedCityName;

  @override
  void initState() {
    super.initState();
    _loadCityData();
  }

  @override
  void dispose() {
    _companyController.dispose();
    _positionController.dispose();
    _sectorController.dispose();
    _cityController.dispose();
    _jobdescrbController.dispose();
    super.dispose();
  }

  Future<void> _loadCityData() async {
    // Verileri yükleme kodu burada olacak
    final cities = await PersonalInfoUtil.loadCityData();
    setState(() {
      _cities = cities;
    });
  }

  void _onCitySelected(String? newCityId) {
    setState(() {
      _selectedCityId = newCityId;
      _selectedCityName =
          _cities.firstWhere((city) => city["id"] == newCityId)["name"];
    });
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final selectedDate = await ExperienceUtil.selectStartDate(context);
    if (selectedDate != null) {
      setState(() {
        _selectedStartDate = selectedDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final selectedDate = await ExperienceUtil.selectEndDate(context);
    if (selectedDate != null) {
      setState(() {
        _selectedEndDate = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TBTAnimatedContainer(
                height: 370,
                infoText: 'Yeni Tecrübe Ekleyin',
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is Authenticated) {
                      UserModel currentUser = state.userModel;

                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: currentUser.experiencesList!.length,
                        itemBuilder: (context, index) {
                          ExperienceModel experience =
                              currentUser.experiencesList![index];
                          return Card(
                            child: ListTile(
                              title: Text(experience.companyName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(experience.experiencePosition),
                                  Text(
                                    'Başlangıç Tarihi: ${DateFormat('dd/MM/yyyy').format(experience.startDate)}',
                                  ),
                                  Text(
                                    experience.isCurrentlyWorking!
                                        ? 'Devam Ediyor'
                                        : 'Bitiş Tarihi: ${DateFormat('dd/MM/yyyy').format(experience.endDate)}',
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () async {
                                      ExperienceModel experienceModel =
                                          ExperienceModel(
                                        experienceId:
                                            'e9b1b5e0-962c-102e-8daa-2bf094a1a934',
                                        userId: 'alperen',
                                        companyName: 'alperen',
                                        experiencePosition: 'alperen',
                                        experienceType: 'alperen',
                                        experienceSector: 'alperen',
                                        experienceCity: 'alperen',
                                        startDate: DateTime.now(),
                                        endDate: DateTime.now(),
                                        isCurrentlyWorking: true,
                                        jobDescription:
                                            _jobdescrbController.text,
                                      );

                                      String result =
                                          await ExperienceRepository()
                                              .updateExperience(
                                                  experienceModel);

                                      print(result);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text("Deneyimi sil"),
                                          content: const Text(
                                              "Bu deneyimi silmek istediğinizden emin misiniz?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("İptal"),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                print(
                                                    "Silmek istediğim fonksiyon: ${experience.experienceId}");
                                                // await _deleteExperience(
                                                //     experience
                                                //         .experienceId);

                                                String result =
                                                    await ExperienceRepository()
                                                        .deleteExperience(
                                                            experience);

                                                print(result);
                                              },
                                              child: const Text('Sil'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTInputField(
                  hintText: "Kurum Adı",
                  controller: _companyController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTInputField(
                  hintText: "Pozisyon",
                  controller: _positionController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton<String>(
                  initialValue: _selectedExperienceType,
                  itemBuilder: (BuildContext context) {
                    return ['Tam Zamanlı', 'Yarı Zamanlı', 'Staj']
                        .map((String value) {
                      return PopupMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList();
                  },
                  onSelected: (String? newValue) {
                    setState(() {
                      _selectedExperienceType = newValue;
                    });
                  },
                  child: ListTile(
                    title:
                        Text(_selectedExperienceType ?? 'Deneyim Türünü Seçin'),
                    trailing: const Icon(Icons.arrow_drop_down),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTInputField(
                  hintText: "Sektör",
                  controller: _sectorController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton<String>(
                  initialValue: _selectedCityId,
                  itemBuilder: (BuildContext context) {
                    return _cities.map((city) {
                      return PopupMenuItem<String>(
                        value: city["id"],
                        child: Text(city["name"]!),
                      );
                    }).toList();
                  },
                  onSelected: _onCitySelected,
                  child: ListTile(
                    title: Text(_selectedCityName ?? 'Şehir Seçiniz'),
                    trailing: const Icon(Icons.arrow_drop_down),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectStartDate(context),
                        child: AbsorbPointer(
                          child: TBTInputField(
                            hintText: _selectedStartDate != null
                                ? DateFormat('dd/MM/yyyy')
                                    .format(_selectedStartDate!)
                                : 'Başlangıç Tarihi',
                            controller: TextEditingController(
                              text: _selectedStartDate != null
                                  ? DateFormat('dd/MM/yyyy')
                                      .format(_selectedStartDate!)
                                  : '',
                            ),
                            onSaved: (p0) {},
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: _isCurrentlyWorking
                            ? null
                            : () => _selectEndDate(context),
                        child: AbsorbPointer(
                          child: TBTInputField(
                            hintText: _isCurrentlyWorking
                                ? 'Devam Ediyor'
                                : _selectedEndDate != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(_selectedEndDate!)
                                    : 'Bitiş Tarihi',
                            controller: TextEditingController(
                              text: _isCurrentlyWorking
                                  ? 'Devam Ediyor'
                                  : _selectedEndDate != null
                                      ? DateFormat('dd/MM/yyyy')
                                          .format(_selectedEndDate!)
                                      : '',
                            ),
                            onSaved: (p0) {},
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: _isCurrentlyWorking,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _isCurrentlyWorking = newValue!;
                        });
                      },
                    ),
                    const Text('Çalışmaya devam ediyorum.'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTInputField(
                  hintText: "İş Tanımı",
                  controller: _jobdescrbController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
                ),
              ),
              TBTPurpleButton(
                buttonText: 'Kaydet',
                onPressed: () async {
                  UserModel? userModel =
                      await UserRepository().getCurrentUser();

                  ExperienceModel experienceModel = ExperienceModel(
                    experienceId: const Uuid().v1(),
                    userId: userModel!.userId,
                    companyName: _companyController.text,
                    experiencePosition: _selectedExperienceType.toString(),
                    experienceType: _selectedExperienceType.toString(),
                    experienceSector: _sectorController.text,
                    experienceCity: _selectedCityName.toString(),
                    startDate: _selectedStartDate!,
                    endDate: _selectedStartDate!,
                    isCurrentlyWorking: _isCurrentlyWorking,
                    jobDescription: _jobdescrbController.text,
                  );

                  String sonuc = await ExperienceRepository()
                      .addExperience(experienceModel);

                  print(sonuc);
                },
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
