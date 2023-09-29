import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:show_flutter/constants/rotes.dart';
import 'package:show_flutter/features/home/view_models/home_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("MOODS"),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(Routes.SETTING_NAME),
            icon: const Icon(Icons.settings_sharp),
          )
        ],
      ),
      body: ref.watch(postProvider).when(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) => Center(
              child: Text(
                'Could not load posts: $error',
              ),
            ),
            data: (posts) {
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text("Mood : "),
                                    Icon(IconData(post.mood,
                                        fontFamily: 'MaterialIcons'))
                                  ],
                                ),
                                Text(post.content),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: timeAgo(post.createdAt),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
    );
  }
}

Text timeAgo(int savedTimeInMilliseconds) {
  final currentTime = DateTime.now();
  final savedTime =
      DateTime.fromMillisecondsSinceEpoch(savedTimeInMilliseconds);
  final difference = currentTime.difference(savedTime);
  final minutesAgo = difference.inMinutes;

  String timeAgo = '방금 전';
  if (minutesAgo >= 1 && minutesAgo < 60) {
    timeAgo = '$minutesAgo 분 전';
  } else if (minutesAgo >= 60 && minutesAgo < 1440) {
    final hoursAgo = (minutesAgo / 60).round();
    timeAgo = '$hoursAgo 시간 전';
  } else if (minutesAgo >= 1440) {
    final daysAgo = (minutesAgo / 1440).round();
    timeAgo = '$daysAgo 일 전';
  }

  return Text(
    timeAgo,
    style: const TextStyle(fontSize: 12),
  );
}
