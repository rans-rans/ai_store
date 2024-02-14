import 'package:flutter/material.dart'
    show Scaffold, Colors, Icons, ElevatedButton, TextButton;
import 'package:flutter/widgets.dart';

import '../../../constants/colors.dart' show primaryColor;
import '../../../constants/numbers.dart'
    show
        buttonBorderRadius,
        defaultPadding,
        largeFontSize,
        mediumFontSize,
        mediumFontWeight;
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
                    children: const [
                      TableRow(children: [
                        Icon(
                          Icons.check,
                          color: primaryColor,
                        ),
                        Text(
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
                          color: primaryColor,
                        ),
                        Text(
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
                          color: primaryColor,
                        ),
                        Text(
                          "Purchase security",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: mediumFontSize,
                              fontWeight: mediumFontWeight),
                        ),
                      ])
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(buttonBorderRadius),
                      ),
                    ),
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(fontSize: mediumFontSize),
                    ),
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
                        child: const Text(
                          "Login",
                          style: TextStyle(color: primaryColor),
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
