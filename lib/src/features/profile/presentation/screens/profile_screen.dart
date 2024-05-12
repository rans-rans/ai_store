import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/numbers.dart';
import '../../../../constants/strings.dart';
import '../../../../utils/helper_functions.dart';
import '../../../auth/domain/entities/auth_user.dart';
import '../../../auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../../../orders/presentation/screens/orders_screen.dart';
import '../widgets/signout_button.dart';
import 'collection_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AuthUser? user;

  @override
  void initState() {
    super.initState();
    user = context.read<AuthBloc>().user;
  }

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
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                        minRadius: 40,
                        child: Icon(Icons.person),
                      ),
                      const Spacer(flex: 1),
                      Text(
                        user?.username ?? '',
                        style: const TextStyle(
                          fontWeight: mediumFontWeight,
                          fontSize: mediumFontSize,
                        ),
                      ),
                      const Spacer(flex: 3),
                    ],
                  ),
                ),
                const SizedBox(height: mediumSpacing),
                const SizedBox(height: smallSpacing),
                const Divider(thickness: 3),
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
                ListTile(
                  title: const Text("Legal"),
                  onTap: () {
                    //TODO show some legal notes here
                  },
                ),
                const Divider(thickness: 3),
                const SizedBox(height: smallSpacing),
                ListTile(
                  leading: const ImageIcon(AssetImage(collectionIcon)),
                  title: const Text("Liked"),
                  onTap: () {
                    HelperFunctions.gotoPage(
                      context: context,
                      page: const LikedProductsScreen(),
                    );
                  },
                ),
                ListTile(
                  leading: const ImageIcon(AssetImage(ordersIcon)),
                  title: const Text("Orders"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const OrdersScreen()),
                    );
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
                const SignoutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
