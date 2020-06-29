import 'package:flutter/material.dart';
import 'package:edonix/screens/utils/show_header.dart';
import 'package:edonix/screens/utils/episode_list.dart';

class Show extends StatelessWidget {
  // const Show({Key key}) : super(key: key);
  final int showId;
  final String posterPath;
  Show(this.showId, this.posterPath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Image(
            image: NetworkImage(
                'https://image.tmdb.org/t/p/original' + posterPath),
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: DraggableScrollableSheet(builder: (context, controller) {
              return ListView(controller: controller, children: [
                ShowHeaderBox(showId, 'tv'),
                EpisodeListBox(showId),
              ]);
            }),
          )
        ],
      ),
    );
  }
}
