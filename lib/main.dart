import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:show_flutter/features/settings/repositories/setting_repository.dart';
import 'package:show_flutter/features/settings/view_models/setting_view_model.dart';
import 'package:show_flutter/firebase_options.dart';
import 'package:show_flutter/router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  final repository = SettingRepository(sharedPreferences);

  runApp(
    ProviderScope(
      overrides: [
        settingProvider.overrideWith(() => SettingViewModel(repository)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      title: 'Mood Tracker',
      themeMode: ref.watch(settingProvider).darkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        textTheme: GoogleFonts.doHyeonTextTheme(),
        // appBarTheme: AppBarTheme(
        //     titleTextStyle:
        //         TextStyle(color: Theme.of(context).primaryColor))
      ),
      darkTheme: FlexThemeData.dark(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue, brightness: Brightness.dark),
        textTheme: GoogleFonts.doHyeonTextTheme(),
      ),
    );
  }
}
