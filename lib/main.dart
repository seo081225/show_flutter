import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:show_flutter/firebase_options.dart';
import 'package:show_flutter/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
        routerConfig: ref.watch(routerProvider),
        debugShowCheckedModeBanner: false,
        title: 'Flutter',
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: const Color(0xFFE9435A),
        ));
  }
}
