import 'package:flutter/material.dart';
import 'package:edonix/screens/utils/show_header.dart';

class Movie extends StatelessWidget {
  // const Show({Key key}) : super(key: key);
  final int showId;
  final String posterPath;
  Movie(this.showId, this.posterPath);

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
          Align(
              widthFactor: double.infinity,
              heightFactor: double.infinity,
              alignment: Alignment.bottomRight,
              // padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Color(0XFF242131),
                    child: ShowHeaderBox(showId, 'movie'),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
