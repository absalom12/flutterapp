import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gameapp/models/MyGame.dart';
import 'package:gameapp/screens/GameDetails.dart';
import 'package:gameapp/screens/LoginScreen.dart';
import 'package:gameapp/screens/MyFavScreen.dart';
import 'package:gameapp/screens/MyWishScreen.dart';
import 'package:gameapp/services/GameServices.dart';
import 'package:gameapp/services/LikeServices.dart';
import 'package:get/get.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<MyGame> _games = [];
  List<MyGame> _filteredGames = [];
  late Future<List<MyGame>> _gameListFuture;
  TextEditingController _searchController = TextEditingController();
  int _filteredGamesCount = 0;

  static const IconData heart = IconData(0xf442);

  @override
  void initState() {
    super.initState();
    _fetchGames();
    _gameListFuture = GameServices().fetchGames();
    _filteredGames = []; // Initialize with an empty list
  }

  Future<void> _fetchGames() async {
    final gameServices = GameServices();
    final games = await gameServices.fetchGames();
    setState(() {
      _games = games;
      _filteredGames = _games;
    });
  }

  void _filterGames(String query) {
    List<MyGame> filteredGames = _games.where((game) {
      String name = game.name ?? '';
      return name.toLowerCase().contains(query.toLowerCase()) ||
          name
              .toLowerCase()
              .split(' ')
              .any((part) => part.startsWith(query.toLowerCase()));
    }).toList();
    setState(() {
      _filteredGames = filteredGames;
      _filteredGamesCount = filteredGames.length; // Update the count
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(26, 32, 37, 1),
        floatingActionButton: SpeedDial(
          backgroundColor: Color.fromRGBO(99, 106, 246, 1),
          child: Icon(Icons.add),
          children: [
            SpeedDialChild(
              child: Icon(Icons.logout_sharp),
              label: 'Se Deconnecter',
              onTap: () {
                FirebaseAuth.instance
                    .signOut()
                    .then((value) => Get.to(LoginScreen()));
              },
            ),
          ],
        ),
        appBar: AppBar(
          title: Text("Acceuil"),
          elevation: 2,
          backgroundColor: Color.fromRGBO(26, 32, 37, 1),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {
                      Get.to(MyFavScreen());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.star),
                    onPressed: () {
                      Get.to(MyWishScreen());
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Center(
              // wrap with Center widget

              child: Container(
                width: 390,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(30, 38, 44, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _searchController,
                        onChanged: (value) {
                          _filterGames(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Rechercher un jeu…',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.search,
                        color: Color.fromRGBO(99, 106, 246, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Visibility(
              visible: _searchController.text.isEmpty,
              child: FutureBuilder<List<MyGame>>(
                future: _gameListFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      color: Color.fromARGB(255, 31, 31, 31),
                      height: 190,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: Image.network(
                                  snapshot.data![index].imageUrl!,
                                ).image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  width:
                                      MediaQuery.of(context).size.width / 1.8,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 8, bottom: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index].name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.fade,
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          snapshot.data![index].description,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5),
                                        TextButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              Color.fromRGBO(99, 106, 246, 1),
                                            ),
                                            shape: MaterialStateProperty.all<
                                                OutlinedBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                side: BorderSide(
                                                  color: Color.fromRGBO(
                                                      99, 106, 246, 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        GameDetails(
                                                            game:
                                                                snapshot.data![
                                                                    index])));
                                          },
                                          child: Text(
                                            "En savoir plus",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.8,
                                  color: Colors.blue,
                                  child: Image.network(
                                    snapshot.data![index].imageUrl!,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Failed to load games'),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Container(
                width: 390,
                alignment: Alignment.centerLeft,
                child: _searchController.text.isEmpty
                    ? Text(
                        "Les meilleures ventes",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            decoration: TextDecoration.underline),
                      )
                    : Text(
                        "Nombre de résultats : $_filteredGamesCount",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            decoration: TextDecoration.underline),
                      ),
              ),
            ),
            SizedBox(height: 15),
            Flexible(
              child: Center(
                // wrap with Center widget
                child: _games.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _filteredGames.length,
                        itemBuilder: (BuildContext context, int index) {
                          final game = _filteredGames[index];
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GameDetails(game: game)));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(30, 38, 44, 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                // ignore: sort_child_properties_last
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomLeft: Radius.circular(5)),
                                      ),
                                      width: 100,
                                      child: Image.network(
                                        game.imageUrl!,
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 15, left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              game.name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              game.publishers.first,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              game.price_overview.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            )
                                          ],
                                        ),
                                      ),
                                      width: 170,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(99, 106, 246, 1),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5)),
                                      ),
                                      width: 100,
                                      child: Text(
                                        "En savoir plus",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                height: 120,
                                width: 390,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ));
  }
}
