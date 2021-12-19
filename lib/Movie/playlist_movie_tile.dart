import 'package:flutter/material.dart';

import 'movie.dart';

class PlaylistTile extends StatelessWidget {


  final double height;
  final double width;
  final Movie movie;

  PlaylistTile({
    required this.height,
    required this.movie,
    required this.width,
  });


  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _moviePosterWidget(movie.poster),

          _movieInfoWidget(),
        ],
      ),
    );
  }

  Widget _moviePosterWidget(String _imageURL) {
    return Container(

      height: height,
      width: width,
      decoration: BoxDecoration(
        // color: Colors.amberAccent,
          image:DecorationImage(
            alignment: Alignment.centerLeft,
            image: NetworkImage(_imageURL),
          )
      ),
    );
  }
  Widget _movieInfoWidget() {
    return Container(
      // color: Colors.blue,
      height: height,
      width: width*4,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // color: Colors.black,
                  width: width*3.4,
                  child: Text(
                    movie.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 55,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 4,
                  )
              ),
              // FloatingActionButton(onPressed: (){
              //   Playlist.movies.add(movie);
              // },
              //   child: Icon(Icons.add),
              //   elevation: 10,
              //   tooltip: "Add to playlist",)
              // Padding(
              //   padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
              //   child:Text(movie.toString(),
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 50,
              //
              //     ),
              //   ),
              // )
            ],
          ),
          Container(
            // color: Colors.purpleAccent,
            padding: EdgeInsets.fromLTRB(0, height*0.1,0, 0),
            child: Text(
              'EN | R: false | Type: ${movie.type} | Year: ${movie.year}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30
              ),
            ),
          ),
          // Container(
          //   // color: Colors.green,
          //   padding: EdgeInsets.fromLTRB(0,height*0.1,0,0),
          //   child: Text(
          //     movie.,
          //     maxLines: 9,
          //     overflow: TextOverflow.ellipsis,
          //     style: TextStyle(
          //       color: Colors.white70,
          //       fontSize: 25,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}


