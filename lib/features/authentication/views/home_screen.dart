import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:show_flutter/constants/sizes.dart';

class HomeScreen extends ConsumerWidget {
  static const routeName = "home";
  static const routeURL = "/";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Home", style: TextStyle(fontSize: Sizes.size48)),
        ),
      ),
    );
  }
}
