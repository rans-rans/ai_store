import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/entities/auth_user.dart';
import '../../../auth/presentation/blocs/auth_bloc/auth_bloc.dart';

class SignoutButton extends StatelessWidget {
  const SignoutButton({
    super.key,
    required this.user,
  });

  final AuthUser user;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          showAdaptiveDialog(
            context: context,
            builder: (_) => AlertDialog.adaptive(
              title: const Text("Confirm sign out"),
              content: const Text(
                """Are you sure you want to sign out? You will lose """
                """all your data stored on this device and will be logged out of all devices""",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          LogoutEvent(
                            userId: user.userId,
                            token: user.authToken,
                          ),
                        );
                  },
                  child: const Text('yes'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'NO',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
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
    );
  }
}
