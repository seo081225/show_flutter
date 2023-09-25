import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:show_flutter/features/authentication/repository/authentication_repository.dart';
import 'package:show_flutter/features/settings/view_models/setting_view_model.dart';

class SettingsScreen extends ConsumerWidget {
  static const routeURL = "/setting";
  static const routeName = "setting";

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(Localizations.localeOf(context));
    return Localizations.override(
      context: context,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: ListView(
          children: [
            SwitchListTile.adaptive(
              value: ref.watch(settingProvider).darkMode,
              onChanged: (value) =>
                  ref.read(settingProvider.notifier).setDarkMode(value),
              title: const Text("Dark mode"),
            ),
            ListTile(
              title: const Text("Log out (iOS / Bottom)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: const Text("Are you sure?"),
                    message: const Text("Please dooooont gooooo"),
                    actions: [
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Not log out"),
                      ),
                      CupertinoActionSheetAction(
                        isDestructiveAction: true,
                        onPressed: () {
                          ref.read(authRepository).signOut();
                          context.go("/login");
                        },
                        child: const Text("Yes plz."),
                      )
                    ],
                  ),
                );
              },
            ),
            const AboutListTile(
              applicationVersion: "1.0",
              applicationLegalese: "Don't copy me.",
            ),
          ],
        ),
      ),
    );
  }
}
