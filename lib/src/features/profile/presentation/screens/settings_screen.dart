import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/numbers.dart'
    show
        defaultPadding,
        mediumFontSize,
        mediumFontWeight,
        mediumSpacing,
        smallSpacing;
import '../../../auth/presentation/blocs/auth_bloc/auth_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: smallSpacing),
              const Text(
                "General",
                style: TextStyle(
                  fontWeight: mediumFontWeight,
                  fontSize: mediumFontSize,
                ),
              ),
              SwitchListTile(
                value: false,
                onChanged: (value) {
                  //TODO handle push notification blocking here
                },
                title: const Text("Push notification"),
              ),
              ListTile(
                title: const Text("Theme"),
                onTap: () {
                  //TODO handle theme switchinng here
                },
              ),
              ListTile(
                title: const Text("Clear history"),
                onTap: () {
                  //TODO handle history clearing here
                },
              ),
              const SizedBox(height: mediumSpacing),
              const Text(
                "About",
                style: TextStyle(
                  fontWeight: mediumFontWeight,
                  fontSize: mediumFontSize,
                ),
              ),
              ListTile(
                title: const Text("User agreement"),
                onTap: () {
                  //TODO show some user agreement here
                },
              ),
              ListTile(
                title: const Text("Privacy"),
                onTap: () {
                  //TODO show some privacy notes here
                },
              ),
              ListTile(
                title: const Text("Legal"),
                onTap: () {
                  //TODO show some legal notes here
                },
              ),
              const SizedBox(height: mediumSpacing * 2),
              const Text("Rate this app"),
              const SizedBox(height: mediumSpacing * 2.5),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    //TODO add confirmation box
                    final user = context.read<AuthBloc>().user;
                    context.read<AuthBloc>().add(
                          LogoutEvent(
                            userId: user!.userId,
                            token: user.authToken,
                          ),
                        );
                  },
                  child: const Text(
                    "SIGN OUT",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
