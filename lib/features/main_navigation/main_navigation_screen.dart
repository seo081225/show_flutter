import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:show_flutter/constants/sizes.dart';
import 'package:show_flutter/features/posts/views/post_view_screen.dart';
import 'package:show_flutter/features/main_navigation/widgets/navigation_tab.dart';
import 'package:show_flutter/features/posts/views/post_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final String tab;

  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "post",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const PostViewScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const PostScreen(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + Sizes.size10),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavigationTab(
                text: "Home",
                isSelected: _selectedIndex == 0,
                icon: Icons.home_outlined,
                selectedIcon: Icons.home,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
              ),
              NavigationTab(
                text: "Post",
                isSelected: _selectedIndex == 1,
                icon: Icons.create_outlined,
                selectedIcon: Icons.create_sharp,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
