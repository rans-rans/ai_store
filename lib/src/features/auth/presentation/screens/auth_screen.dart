import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/numbers.dart'
    show boldestFontWeight, buttonBorderRadius, inputBorderRadius, largeFontSize;
import '../../../../constants/strings.dart' show googleLogoImage;
import '../../../../widgets/wide_button_widget.dart' show WideButtonWidget;
import '../blocs/auth_bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  bool isLoading = false;

  final isLogin = ValueNotifier(true);

  ({bool valid, String msg}) validateForm() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final passwordConfirm = passwordController.text.trim();

    if (email.isEmpty || !email.contains('@') || !email.contains('.com')) {
      return (valid: false, msg: 'email invalid');
    }
    if (password.length < 6 == true) {
      if (!isLogin.value &&
          (password != passwordConfirm || passwordConfirm.length < 6)) {
        return (valid: false, msg: 'passwords do not match');
      }
      return (valid: false, msg: 'password too weak');
    }
    return (valid: true, msg: 'form valid');
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        if (state is AuthActionFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          setState(() {
            isLoading = false;
          });
        }
        if (state is AuthUnAvailable) {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Scaffold(
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
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: const InputDecoration(hintText: "Email"),
                ),
              ),
              const Spacer(),
              ValueListenableBuilder(
                valueListenable: isLogin,
                child: SizedBox(
                  height: 45,
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(inputBorderRadius),
                      ),
                    ),
                  ),
                ),
                builder: (context, logginIn, child) {
                  return Column(
                    children: [
                      child!,
                      const SizedBox(height: 16),
                      if (!logginIn)
                        SizedBox(
                          height: 45,
                          child: TextField(
                            obscureText: true,
                            controller: passwordConfirmController,
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius:
                                    BorderRadius.circular(inputBorderRadius),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const Spacer(flex: 2),
              ValueListenableBuilder(
                valueListenable: isLogin,
                builder: (context, value, child) {
                  return isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : WideButtonWidget(
                          text: value ? 'LOGIN' : 'SIGN UP',
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            ScaffoldMessenger.of(context).removeCurrentSnackBar();
                            final formValid = validateForm();

                            if (!formValid.valid) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(formValid.msg)),
                              );
                              return;
                            }

                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();
                            final function = context.read<AuthBloc>();

                            setState(() {
                              isLoading = true;
                            });
                            if (isLogin.value) {
                              function.add(LoginEvent(
                                email: email,
                                password: password,
                              ));
                            } else {
                              function.add(CreateAccountEvent(
                                email: email,
                                password: password,
                              ));
                            }
                          },
                        );
                },
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  child: ValueListenableBuilder(
                      valueListenable: isLogin,
                      builder: (context, isLogginIn, child) {
                        return Text(
                          isLogginIn ? "Sign up instead" : "Login instead",
                        );
                      }),
                  onPressed: () => isLogin.value = !isLogin.value,
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
      ),
    );
  }
}
