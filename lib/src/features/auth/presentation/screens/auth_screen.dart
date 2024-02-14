import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart'
    show boldestFontWeight, buttonBorderRadius, inputBorderRadius, largeFontSize;
import '../../../../constants/strings.dart' show googleLogoImage;
import '../../../../widgets/wide_button_widget.dart' show WideButtonWidget;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 4),
            const Text(
              "WELCOME BACK",
              style: TextStyle(
                fontWeight: boldestFontWeight,
                fontSize: largeFontSize,
              ),
            ),
            const Text(
              "Sign into your account",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 45,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(inputBorderRadius),
                  ),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 45,
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(inputBorderRadius),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 2),
            WideButtonWidget(
              text: "LOGIN",
              onPressed: () {},
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {},
                child: const Text("Sign up instead"),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: size.width * 0.3,
                  child: const Divider(
                    thickness: 2,
                  ),
                ),
                const Text("or"),
                SizedBox(
                  width: size.width * 0.3,
                  child: const Divider(
                    thickness: 2,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonBorderRadius),
                  side: BorderSide(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(googleLogoImage),
                  const Spacer(),
                  const Text("Continue with google"),
                  const Spacer(),
                ],
              ),
            ),
            const Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
