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
      title: 'Flutter',
      themeMode: ref.watch(settingProvider).darkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      theme: FlexThemeData.light(
          colorScheme: flexSchemeLight,
          textTheme: GoogleFonts.doHyeonTextTheme()),
      darkTheme: FlexThemeData.dark(
          colorScheme: flexSchemeDark,
          textTheme: GoogleFonts.doHyeonTextTheme()),
    );
  }
}

const ColorScheme flexSchemeLight = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff00296b),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffa0c2ed),
  onPrimaryContainer: Color(0xff0e1014),
  secondary: Color(0xffd26900),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffffd270),
  onSecondaryContainer: Color(0xff14120a),
  tertiary: Color(0xff5c5c95),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffc8dbf8),
  onTertiaryContainer: Color(0xff111214),
  error: Color(0xffb00020),
  onError: Color(0xffffffff),
  errorContainer: Color(0xfffcd8df),
  onErrorContainer: Color(0xff141213),
  background: Color(0xfff8f9fa),
  onBackground: Color(0xff090909),
  surface: Color(0xfff8f9fa),
  onSurface: Color(0xff090909),
  surfaceVariant: Color(0xffe0e3e6),
  onSurfaceVariant: Color(0xff111112),
  outline: Color(0xff7c7c7c),
  outlineVariant: Color(0xffc8c8c8),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff101113),
  onInverseSurface: Color(0xfff5f5f5),
  inversePrimary: Color(0xff8dacdd),
  surfaceTint: Color(0xff00296b),
);

const ColorScheme flexSchemeDark = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xffb1cff5),
  onPrimary: Color(0xff111414),
  primaryContainer: Color(0xff3873ba),
  onPrimaryContainer: Color(0xffe8f1fc),
  secondary: Color(0xffffd270),
  onSecondary: Color(0xff14140c),
  secondaryContainer: Color(0xffd26900),
  onSecondaryContainer: Color(0xfffff0df),
  tertiary: Color(0xffc9cbfc),
  onTertiary: Color(0xff131314),
  tertiaryContainer: Color(0xff535393),
  onTertiaryContainer: Color(0xffececf6),
  error: Color(0xffcf6679),
  onError: Color(0xff140c0d),
  errorContainer: Color(0xffb1384e),
  onErrorContainer: Color(0xfffbe8ec),
  background: Color(0xff191a1c),
  onBackground: Color(0xffeceded),
  surface: Color(0xff191a1c),
  onSurface: Color(0xffeceded),
  surfaceVariant: Color(0xff3e4245),
  onSurfaceVariant: Color(0xffe0e1e1),
  outline: Color(0xff767d7d),
  outlineVariant: Color(0xff2c2e2e),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xfffbfcfe),
  onInverseSurface: Color(0xff131313),
  inversePrimary: Color(0xff5b6776),
  surfaceTint: Color(0xffb1cff5),
);
