import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/pages/login/login.dart';
import 'package:travel_smartapp/widgets/button/material_button.dart';

class LanguageSelectPage extends StatelessWidget {
  const LanguageSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Image.asset(kLoginLogo, fit: BoxFit.fitWidth),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Choose Your Preferred Language",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: kFontSize * .8,
                  )),
              CarouselSlider(
                options: CarouselOptions(
                  height: 150.0,
                  scrollPhysics: const BouncingScrollPhysics(),
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.6,
                  initialPage: 1,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                ),
                items: [
                  buildLanguageButton(title: "Tamil"),
                  buildLanguageButton(title: "English"),
                  buildLanguageButton(title: "Sinhala")
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
              child: CustomButton(
                  text: "Next",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  })),
        ),
      ],
    ));
  }

  Widget buildLanguageButton({required String title}) {
    return Container(
      //margin: const EdgeInsets.all(kPadding * 0.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        color: Colors.yellow,
      ),
      child: Center(
          child: Text(
        title,
        style: const TextStyle(
          fontSize: kFontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      )),
    );
  }
}
