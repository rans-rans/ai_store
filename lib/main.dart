import 'dart:convert';

import 'package:ai_store/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:ai_store/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'injector.dart';
import 'src/constants/colors.dart' show darkTheme, lightTheme;
import 'src/features/auth/domain/entities/auth_user.dart';
import 'src/features/auth/domain/entities/express_auth_user.dart';
import 'src/features/home/presentation/screens/home_controller_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final user = await getUserData();
  runApp(MyApp(user));
}

//TODO  under the all categories page, make the ui  such that as  the
//user scrolls, for each category, about  five products are listed

Future<AuthUser?> getUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final userData = prefs.getString('user');
  if (userData == null) return null;
  final userMap = json.decode(userData) as Map<String, dynamic>;
  final user = ExpressAuthUser.fromMap(userMap);
  return user;
}

class MyApp extends StatelessWidget {
  final AuthUser? user;
  const MyApp(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Injector(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (Navigator.canPop(context)) {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            }
            final isAuthenticated = (user != null || state is AuthAvailable);
            if (isAuthenticated) {
              late AuthUser authUser;
              if (state is AuthAvailable) {
                authUser = state.authUser;
              }
              context.read<AuthBloc>().setUser(user ?? authUser);
              return HomeControllerScreen(user ?? authUser);
            }
            return const OnboardingScreen();
          },
        ),
      ),
    );
  }
}
