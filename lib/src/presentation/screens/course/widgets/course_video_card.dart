import 'package:flutter/material.dart';
import 'package:tobeto/src/models/course_model.dart';
import 'package:tobeto/src/models/course_video_model.dart';

class CourseVideoCard extends StatefulWidget {
  final CourseVideoModel courseVideo;
  final CourseModel course;
  final VoidCallback onTap;
  final double? watchedPercentage; // Yeni eklenen watchedPercentage

  const CourseVideoCard({
    required this.course,
    required this.courseVideo,
    required this.watchedPercentage,
    required this.onTap,
    super.key,
  });

  @override
  State<CourseVideoCard> createState() => _CourseVideoCardState();
}

class _CourseVideoCardState extends State<CourseVideoCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: double.infinity,
        child: Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.courseVideo.courseVideoName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                          'Instructors: ${widget.course.courseInstructors.join(', ')}'),
                    ],
                  ),
                ),
                if (widget.watchedPercentage != null &&
                    widget.watchedPercentage! > 0 &&
                    widget.watchedPercentage! < 100)
                  const Icon(
                    Icons.watch_later,
                    color: Colors.grey,
                  )
                else if (widget.watchedPercentage == 100)
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
