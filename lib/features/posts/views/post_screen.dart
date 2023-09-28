import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:show_flutter/constants/gaps.dart';
import 'package:show_flutter/constants/icons.dart';
import 'package:show_flutter/constants/sizes.dart';
import 'package:show_flutter/features/authentication/views/widgets/form_button.dart';
import 'package:show_flutter/features/posts/view_models/post_view_model.dart';

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key});

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  late ScrollController scrollcontroller;
  late final TextEditingController _textEditingController =
      TextEditingController();
  late List<bool> isSelected = <bool>[
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  String _context = "";
  int _mood = 0;

  @override
  void dispose() {
    scrollcontroller.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    scrollcontroller = ScrollController();
    _textEditingController.addListener(() {
      _context = _textEditingController.text;
    });
    super.initState();
  }

  void moodToggle(int index) {
    for (int i = 0; i < isSelected.length; i++) {
      if (i == index) {
        isSelected[i] = true;
        _mood = icons[i].codePoint;
      } else {
        isSelected[i] = false;
      }
    }
    setState(() {});
  }

  void _uploadPost() {
    if (_mood < 0) return;
    ref.read(postForm.notifier).state = {
      "content": _context,
      "mood": _mood,
    };

    print(ref.read(postForm));
    ref.read(postProvider.notifier).uploadPost(context);

    if (context.mounted) {
      setState(() {
        _textEditingController.text = "";
        _context = "";
        _mood = 0;
        isSelected = <bool>[
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MOOD"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v32,
                  const Text("How do you feel?",
                      style: TextStyle(fontSize: Sizes.size20)),
                  Gaps.v10,
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        TextField(
                          maxLength: 300,
                          style: const TextStyle(),
                          controller: _textEditingController,
                          maxLines: null,
                          decoration: const InputDecoration(
                              suffix: SizedBox(
                                height: 120,
                                child: Text(''),
                              ),
                              border: InputBorder.none,
                              hintText: "Write it down here!",
                              hintStyle:
                                  TextStyle(overflow: TextOverflow.ellipsis)),
                        ),
                      ],
                    ),
                  ),
                  Gaps.v32,
                  const Text("What's your mood?",
                      style: TextStyle(fontSize: Sizes.size20)),
                  Gaps.v10,
                  ToggleButtons(
                    isSelected: isSelected,
                    selectedColor: Theme.of(context).primaryColor,
                    onPressed: (index) => moodToggle(index),
                    children: [for (var i in icons) Icon(i)],
                  ),
                  Gaps.v32,
                  GestureDetector(
                    onTap: _uploadPost,
                    child: FormButton(
                      disabled: _mood <= 0,
                      text: "Post",
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
