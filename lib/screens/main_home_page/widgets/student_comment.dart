import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tobeto/screens/main_home_page/models/avatar_models.dart';

class StudentCommentCard extends StatefulWidget {
  final AvatarModel model;
  const StudentCommentCard({
    super.key,
    required this.model,
  });

  @override
  State<StudentCommentCard> createState() => _StudentCommentCardState();
}

class _StudentCommentCardState extends State<StudentCommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 5, vertical: 5), //Ekran ile card arasında ki mesafe için
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(90),
        ),
        border: GradientBoxBorder(
          width: 5, //border kalınlığı
          gradient: SweepGradient(
            startAngle: 2.3561944902, //rad türünden 135 derece
            endAngle: 5.4977871438, //rad türünden 315 derece
            colors: [
              Colors.transparent,
              Color.fromRGBO(110, 37, 132, 1),
              Colors.transparent,
            ],
            stops: [0.15, 0.5, 0.88], //renk dağılımını ayarlamak için
            tileMode: TileMode.mirror, // simetrik yansıtmak için
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Text(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: "Poppins",
                      color: Color.fromARGB(255, 130, 130, 130),
                      fontSize: 18),
                  widget.model.comment),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 15),
              child: CircleAvatar(
                backgroundImage: AssetImage(widget.model.avatar),
                radius: 45,
                backgroundColor: widget.model.color,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(
                widget.model.studentname,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Text(
                "Öğrenci",
                style: TextStyle(
                  color: Color.fromARGB(255, 130, 130, 130),
                  fontFamily: "Poppins",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
