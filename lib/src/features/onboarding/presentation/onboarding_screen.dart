import 'package:ai_store/src/widgets/wide_button_widget.dart';
import 'package:flutter/material.dart'
    show Colors, Icons, Scaffold, TextButton, Theme;
import 'package:flutter/widgets.dart';

import '../../../constants/numbers.dart'
    show defaultPadding, largeFontSize, mediumFontSize, mediumFontWeight;
import '../../../constants/strings.dart' show onboardingBackgroundImage;

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(onboardingBackgroundImage),
          ),
        ),
        child: SizedBox(
          height: size.height * 0.45,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              border: Border.symmetric(vertical: BorderSide.none),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(27, 27, 27, 0.01),
                  Color.fromRGBO(27, 27, 27, 0.4),
                  Color.fromRGBO(0, 0, 0, 0.55),
                  Color.fromRGBO(0, 0, 0, 0.72),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Your shopping journey starts here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: largeFontSize,
                      color: Colors.black,
                      fontWeight: mediumFontWeight,
                    ),
                  ),
                  Table(
                    columnWidths: const {
                      1: FractionColumnWidth(0.75),
                      2: FractionColumnWidth(0.25),
                    },
                    children: [
                      TableRow(children: [
                        Icon(
                          Icons.check,
                          color: Theme.of(context).primaryColor,
                        ),
                        const Text(
                          "Over 300K products",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: mediumFontSize,
                              fontWeight: mediumFontWeight),
                        ),
                      ]),
                      TableRow(children: [
                        Icon(
                          Icons.check,
                          color: Theme.of(context).primaryColor,
                        ),
                        const Text(
                          "Quality guranteed",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: mediumFontSize,
                              fontWeight: mediumFontWeight),
                        ),
                      ]),
                      TableRow(children: [
                        Icon(
                          Icons.check,
                          color: Theme.of(context).primaryColor,
                        ),
                        const Text(
                          "Purchase security",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: mediumFontSize,
                              fontWeight: mediumFontWeight),
                        ),
                      ])
                    ],
                  ),
                  WideButtonWidget(
                    text: "SIGN UP",
                    onPressed: () {},
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: mediumFontWeight,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Login",
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
