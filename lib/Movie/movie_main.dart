import 'dart:convert';
import 'dart:ui';
import 'package:finalmovie/screen/Login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:finalmovie/Movie/playlist.dart';
import 'package:flutter/material.dart';

import 'movie.dart';
import 'movie_tile.dart';

// class MyApp extends StatelessWidget {
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(title: Text("Movie"),),
//       )
//     );
//   }
// }


class HomePage extends StatefulWidget {
  String email;
  HomePage(
      this.email,
      );
  @override
  _HomePageState createState() => _HomePageState(email);
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

_signOut() async {
  await _firebaseAuth.signOut();
}
class _HomePageState extends State<HomePage> {
  String email;
 _HomePageState(
    this.email,
    );
  List<Movie> _movies=[];
  late double _deviceHeight;
  late double _deviceWidth;

  late TextEditingController _serchTextFieldController;

  void _populateAllMovies(String enterKeyword) async {
    final movies = await _fetchAllMovies(enterKeyword);
    setState(() {
      _movies = movies;
    });

  }

  void _runFilter(String enterKeyword){

    if(enterKeyword.isEmpty){
      _movies=[];
    }
    else{
      _populateAllMovies(enterKeyword);
    }


  }


  Future<List<Movie>> _fetchAllMovies(String enterKeyword) async {
    final response = await http.get(Uri.parse(
        "http://www.omdbapi.com/?s=${enterKeyword}&apikey=d9960063"
    ));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["Search"];
      return list.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Failed to load movies");
    }
  }
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
    _serchTextFieldController = TextEditingController();
    return MaterialApp(
        home: Scaffold(
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
                "https://image.tmdb.org/t/p/original//1eh6Yv6bAU2ghHxP1zgUlMfaOR3.jpg"),
            fit: BoxFit.fitWidth,
          )
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
          crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _topBarWidget() {
    return Container(
      height: _deviceHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _searchFileWidget(),
          SizedBox(width: 20,),
          _profile(),
          SizedBox(width: 40,),
          _playList(),
        ],
      ),
    );
  }

  Widget _profile(){
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[IconButton(
               tooltip: "Log out",
               icon: Icon(Icons.logout,size: 30,
               color: Colors.white54,),
              onPressed: () async {
                await _signOut();
                if (_firebaseAuth.currentUser == null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              }),


          SizedBox(width:10),
          Text(
              email,
              maxLines: 2,
              style:TextStyle(
                fontSize: 20,
                color: Colors.white54,
              )
          )]
    );
  }
  Widget _playList(){
    return IconButton(onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Playlist(),
        ),
      );
    },
      tooltip: "Playlist",
      icon: Icon(Icons.playlist_play_outlined,color: Colors.white54,),
      iconSize: 30,);
  }
  Widget _searchFileWidget() {
    final _border = InputBorder.none;
    return Container(
        width: _deviceWidth * 0.60,
        height: _deviceHeight * 0.05,
        child: TextField(
          controller: _serchTextFieldController,
          onSubmitted: (_input) => _runFilter(_input),
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            focusedBorder: _border,
            border: _border,
            prefixIcon: Icon(Icons.search, color: Colors.white54),
            hintStyle: TextStyle(
              color: Colors.white54,
            ),
            filled: false,
            fillColor: Colors.white24,
            hintText: "Search....",

          ),
        )
    );
  }
// Widget _categorySelectionWidget(){
//   return DropdownButton(
//     dropdownColor: Colors.black38,
//     value: SearchCategory.popular,
//     icon: Icon(Icons.menu,
//         color:Colors.white24),
//     underline: Container(
//       height: 1,
//       color: Colors.white24,
//     ),
//     onChanged: (_value){
//
//     },
//     items: [
//       DropdownMenuItem(child: Text(SearchCategory.popular,style: TextStyle(
//         color:Colors.white,
//       )
//       ),
//         value: SearchCategory.popular,
//       ),
//       DropdownMenuItem(child: Text(SearchCategory.upcoming,style: TextStyle(
//         color:Colors.white,
//       )
//       ),
//         value: SearchCategory.upcoming,
//       ),
//       DropdownMenuItem(child: Text(SearchCategory.none,style: TextStyle(
//         color:Colors.white,
//       )
//       ),
//         value: SearchCategory.none,
//       ),
//     ],
//   );
// }

  Widget _movieListViewWidget(){

    final List<Movie>_movies1=_movies;

    // for(var i=0;i<20;i++){
    //   _movies.add(Movie(
    //     name: "Venom: Let There Be Carnage",
    //     description: "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
    //     releaseDate: "2021-09-30",
    //     rating: 7.2,
    //     posterPath: "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg" ,
    //     language: "en",
    //     isAdult: false,
    //     backdropPath:"/eENEf62tMXbhyVvdcXlnQz2wcuT.jpg",
    //   ));
    // }

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
              child: MovieTile(movie: _movies1[_count],
                height:_deviceHeight*0.4 ,
                width: _deviceWidth*0.17,),
            ),
          );
        },
      );
    }
    else{
      // return Center(
      //   child: CircularProgressIndicator(
      //     backgroundColor: Colors.white,
      //     color: Colors.black54,
      //   ),
      // );
      return Center(
        child: Text("Search for Movies Or Web Series......",
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w200,
          color: Colors.white54,
        ),),
      );
    }
  }
}
