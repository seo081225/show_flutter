import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:show_flutter/constants/gaps.dart';
import 'package:show_flutter/constants/routes.dart';
import 'package:show_flutter/constants/sizes.dart';
import 'package:show_flutter/features/posts/view_models/post_view_model.dart';

class PostViewScreen extends ConsumerStatefulWidget {
  const PostViewScreen({super.key});

  @override
  ConsumerState<PostViewScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostViewScreen> {
  void _onLongPressItem(String? postUid) async {
    print(postUid);
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Delete",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const Text('Are you sure you want to do this ?'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Gaps.h10,
                    ElevatedButton(
                      child: const Text('Delete'),
                      onPressed: () => _deleteItem(postUid ?? ""),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteItem(String postUid) {
    if (postUid.isEmpty) return;
    ref.read(postProvider.notifier).deletePost(context, postUid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Mood Tracker",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(Routes.SETTING_NAME),
            icon: Icon(
              Icons.settings_sharp,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
      body: ref.watch(postViewProvider).when(
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
                        const EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onLongPress: () => _onLongPressItem(post.uid),
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mood : ",
                                        style: TextStyle(
                                            fontSize: Sizes.size16,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      Icon(
                                        IconData(post.mood,
                                            fontFamily: 'MaterialIcons'),
                                        color: Theme.of(context).primaryColor,
                                      )
                                    ],
                                  ),
                                  Gaps.v4,
                                  Text(
                                    post.content,
                                    style: const TextStyle(
                                      fontSize: Sizes.size16,
                                    ),
                                  ),
                                ],
                              ),
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
    style: const TextStyle(fontSize: Sizes.size12),
  );
}
