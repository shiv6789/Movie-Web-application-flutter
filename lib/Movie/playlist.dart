import 'dart:ui';

import 'package:finalmovie/Movie/playlist_movie_tile.dart';
import 'package:flutter/material.dart';

import 'movie.dart';
import 'movie_tile.dart';
class Playlist extends StatelessWidget {


  static List<Movie> movies=[];





  late double _deviceHeight;
  late double _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    _deviceWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _backgroundWidget(),
            _foregroundWidgets(),
          ],
        ),
      ),
    );

  }
  Widget _foregroundWidgets() {
    return Container(
      // color: Colors.blue,
        padding: EdgeInsets.fromLTRB(10, _deviceHeight * 0.1, 10, 0),
        width: _deviceWidth * 0.88,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _topBarWidget(),
            Container(
              // color: Colors.red,
              height: _deviceHeight * 0.8,
              padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.01),
              child: _movieListViewWidget(),
            )
          ],
        )
    );
  }
  Widget _backgroundWidget() {
    return Container(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
          ),
        ),
      ),
      height: _deviceHeight,
      width: _deviceWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(
                "https://image.tmdb.org/t/p/original//kv2Qk9MKFFQo4WQPaYta599HkJP.jpg"),
            fit: BoxFit.fitWidth,
          )
      ),
    );
  }
  Widget _topBarWidget() {
    return Container(
      height: _deviceHeight * 0.1,

      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child:Text("Playlist",
          style: TextStyle(
            letterSpacing: 2,
            fontSize: 40,
            color: Colors.white24,
          ),),
      ),
    );
  }

  Widget _movieListViewWidget(){

    final List<Movie>_movies1=movies;


    if(_movies1.length!=0){

      return ListView.builder(
        itemCount: _movies1.length,
        itemBuilder: (BuildContext _context,int _count){
          return Padding(
            padding: EdgeInsets.symmetric(vertical: _deviceHeight*0.01,
                horizontal:0 ),
            child: GestureDetector(
              onTap: (){

              },
              child: PlaylistTile(movie: _movies1[_count],
                height:_deviceHeight*0.4 ,
                width: _deviceWidth*0.17,),
            ),
          );
        },
      );
    }
    else{
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Colors.black54,
        ),
      );
    }
  }
}
