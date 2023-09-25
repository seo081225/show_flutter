import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:show_flutter/constants/sizes.dart';
import 'package:show_flutter/features/settings/views/settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(SettingsScreen.routeName),
            icon: const Icon(Icons.settings_sharp),
          )
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: Text("Home", style: TextStyle(fontSize: Sizes.size48)),
        ),
      ),
    );
  }
}
