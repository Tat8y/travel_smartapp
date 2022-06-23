import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/enums/languages/languages.dart';
import 'package:travel_smartapp/pages/login/login.dart';
import 'package:travel_smartapp/widgets/button/material_button.dart';

class LanguageSelectPage extends StatefulWidget {
  const LanguageSelectPage({Key? key}) : super(key: key);

  @override
  State<LanguageSelectPage> createState() => _LanguageSelectPageState();
}

class _LanguageSelectPageState extends State<LanguageSelectPage> {
  int selectedLanguageIndex = 1;
  List<AppLanguages> languages = AppLanguages.values;

  @override
  void initState() {
    super.initState();
  }

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
              GFCarousel(
                  items: languages
                      .map((e) =>
                          buildLanguageButton(title: appLanguagesToStr[e]!))
                      .toList(),
                  initialPage: 1,
                  aspectRatio: 16 / 9,
                  height: 150.0,
                  scrollPhysics: const BouncingScrollPhysics(),
                  enlargeMainPage: true,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.6,
                  onPageChanged: (index) {
                    setState(() {
                      selectedLanguageIndex = index;
                    });
                  }),
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
    bool isSelected =
        languages.indexOf(appLanguagesFromStr[title]!) == selectedLanguageIndex;

    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: kPadding * 0.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        color: isSelected ? kPrimaryColor : kPrimaryColor.withOpacity(0.6),
      ),
      duration: const Duration(milliseconds: 200),
      child: Center(
          child: Text(
        title,
        style: const TextStyle(
          fontSize: kFontSize,
          fontWeight: FontWeight.bold,
          color: kSecondaryColor,
        ),
      )),
    );
  }
}
