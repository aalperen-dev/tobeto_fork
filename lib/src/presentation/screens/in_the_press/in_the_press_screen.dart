import 'package:flutter/material.dart';
import 'package:tobeto/src/presentation/widgets/tbt_app_bar_widget.dart';
import 'package:tobeto/src/presentation/widgets/tbt_blog_stream.dart';
import 'package:tobeto/src/presentation/widgets/tbt_drawer_widget.dart';

class InThePressScreen extends StatelessWidget {
  const InThePressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return SafeArea(
      child: Scaffold(
        appBar: TBTAppBar(controller: controller),
        drawer: const TBTDrawer(),
        backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
        body: SingleChildScrollView(
          controller: controller,
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Text(
                  "Basında Biz",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 35,
                  ),
                ),
              ),
              // TBTBlogStream(isBlog: false),
            ],
          ),
        ),
      ),
    );
  }
}
