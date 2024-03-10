import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart';
import '../../../../constants/strings.dart';
import 'collection_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                  child: Row(
                    children: [
                      //TODO profile-img comes here
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                        minRadius: 40,
                        child: Icon(Icons.person),
                      ),
                      const Spacer(flex: 1),
                      //TODO profile name comes here
                      const Text(
                        "Yakeen Radiat",
                        style: TextStyle(
                            fontWeight: mediumFontWeight, fontSize: mediumFontSize),
                      ),
                      const Spacer(flex: 3),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SettingsScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.settings),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: mediumSpacing),
                ListTile(
                  leading: const Icon(Icons.mail_outline_rounded),
                  title: const Text("Messages"),
                  onTap: () {
                    //TODO navigate to messages for person
                  },
                ),
                const SizedBox(height: smallSpacing),
                const Divider(thickness: 3),
                const SizedBox(height: smallSpacing),
                ListTile(
                  leading: const ImageIcon(AssetImage(collectionIcon)),
                  title: const Text("Collections"),
                  onTap: () {
                    //TODO navigate to collections(saved,wishlist,favorite)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CollectionsScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const ImageIcon(AssetImage(ordersIcon)),
                  title: const Text("Orders"),
                  onTap: () {
                    //TODO navigate to orders
                  },
                ),
                ListTile(
                  leading: const ImageIcon(AssetImage(recentsIcon)),
                  title: const Text("Recents"),
                  onTap: () {
                    //TODO navigate to recents
                  },
                ),
                const SizedBox(height: smallSpacing),
                const Divider(thickness: 3),
                const SizedBox(height: smallSpacing),
                ListTile(
                  leading: const ImageIcon(AssetImage(customerServiceIcon)),
                  title: const Text("Service center"),
                  onTap: () {
                    //TODO navigate to service center
                  },
                ),
                ListTile(
                  leading: const ImageIcon(AssetImage(feedbackIcon)),
                  title: const Text("Feedback"),
                  onTap: () {
                    //TODO navigate to feedback page
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
