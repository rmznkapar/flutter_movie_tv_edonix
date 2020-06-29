import 'package:flutter/material.dart';
import 'package:edonix/screens/utils/story.dart';
import 'package:edonix/screens/utils/cat_title.dart';
import 'package:edonix/screens/utils/continue.dart';
import 'package:edonix/screens/utils/list_item.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ListView(children: [
        StoryBox(),
        CatTitle('Continue Watching'),
        ContinueBox(),
        CatTitle('Popular on Edonix'),
        ListItemBox(0),
        CatTitle('Trending Now'),
        ListItemBox(1),
      ]),
    );
  }
}
