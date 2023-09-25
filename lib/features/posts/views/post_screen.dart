import 'package:flutter/material.dart';
import 'package:show_flutter/constants/gaps.dart';
import 'package:show_flutter/constants/sizes.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late ScrollController scrollcontroller;
  late TextEditingController _textEditingController;
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

  @override
  void dispose() {
    scrollcontroller.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    scrollcontroller = ScrollController();
    _textEditingController = TextEditingController();
    super.initState();
  }

  void moodToggle(int index) {
    for (int i = 0; i < isSelected.length; i++) {
      if (i == index) {
        isSelected[i] = true;
      } else {
        isSelected[i] = false;
      }
    }
    setState(() {});
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
                          onChanged: (texts) {
                            setState(() {});
                          },
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
                    children: const [
                      Icon(Icons.sentiment_satisfied_outlined),
                      Icon(Icons.emoji_emotions_outlined),
                      Icon(Icons.sentiment_very_satisfied_outlined),
                      Icon(Icons.sentiment_neutral_outlined),
                      Icon(Icons.sentiment_dissatisfied_outlined),
                      Icon(Icons.sentiment_very_dissatisfied_outlined),
                      Icon(Icons.sick_outlined),
                      Icon(Icons.favorite_border_outlined),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
