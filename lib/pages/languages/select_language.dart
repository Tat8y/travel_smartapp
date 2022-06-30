import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:travel_smartapp/app.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/providers/prefernce_provider.dart';
import 'package:travel_smartapp/l10n/l10n.dart';
import 'package:travel_smartapp/widgets/button/material_button.dart';

class LanguageSelectPage extends StatefulWidget {
  const LanguageSelectPage({Key? key}) : super(key: key);

  @override
  State<LanguageSelectPage> createState() => _LanguageSelectPageState();
}

class _LanguageSelectPageState extends State<LanguageSelectPage> {
  int selectedLanguageIndex = 1;
  List<Locale> languages = L10n.all;

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
              const Text("Choose Your Preferred Langugage",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: kFontSize * .8,
                  )),
              GFCarousel(
                  items: languages
                      .map((e) => buildLanguageButton(locale: e))
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
                      context
                          .read<PrefernceProvider>()
                          .setLocale(L10n.all[index]);
                    });
                  }),
            ],
          ),
        ),
        Expanded(
          child: Center(
              child: CustomButton(
                  text: "Next",
                  onPressed: () async {
                    context.read<PrefernceProvider>().firstTime = false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainApp()),
                    );
                  })),
        ),
      ],
    ));
  }

  Widget buildLanguageButton({required Locale locale}) {
    bool isSelected = languages.indexOf(locale) == selectedLanguageIndex;

    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: kPadding * 0.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        color: isSelected ? kPrimaryColor : kPrimaryColor.withOpacity(0.6),
      ),
      duration: const Duration(milliseconds: 200),
      child: Center(
          child: Text(
        L10n.languages[locale.languageCode].toString(),
        style: const TextStyle(
          fontSize: kFontSize,
          fontWeight: FontWeight.bold,
          color: kSecondaryColor,
        ),
      )),
    );
  }
}
