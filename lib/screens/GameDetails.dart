import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gameapp/models/MyGame.dart';
import 'package:gameapp/services/LikeServices.dart';
import 'package:gameapp/services/WishlistServices.dart';
import 'package:gameapp/widget/Avis.dart';
import 'package:gameapp/widget/Description.dart';

class GameDetails extends StatefulWidget {
  final MyGame game;

  const GameDetails({super.key, required this.game});

  @override
  State<GameDetails> createState() => _GameDetailsState();
}

class _GameDetailsState extends State<GameDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool status = false;
  bool status2 = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(26, 32, 37, 1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(26, 32, 37, 1),
          title: Text("Détail du jeu"),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      LikesServices().addLike(
                          MyGame(
                              appid: widget.game.appid,
                              name: widget.game.name,
                              description: widget.game.description,
                              publishers: widget.game.publishers,
                              imageUrl: widget.game.imageUrl),
                          status ? false : true);
                      setState(() {
                        status = !status;
                      });
                    },
                    icon: status == false
                        ? Icon(
                            Icons.favorite_border,
                            color: Color.fromARGB(255, 235, 235, 235),
                          )
                        : Icon(
                            Icons.favorite,
                            color: Color.fromARGB(255, 235, 235, 235),
                          ),
                  ),
                  IconButton(
                    onPressed: () {
                      WishListServices().addWish(
                          MyGame(
                              appid: widget.game.appid,
                              name: widget.game.name,
                              description: widget.game.description,
                              publishers: widget.game.publishers,
                              imageUrl: widget.game.imageUrl),
                          status2 ? false : true);
                      setState(() {
                        status2 = !status2;
                      });
                    },
                    icon: status2 == false
                        ? Icon(
                            Icons.star_border,
                            color: Color.fromARGB(255, 235, 235, 235),
                          )
                        : Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 235, 235, 235),
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: Image.network(widget.game.imageUrl!,
                          fit: BoxFit.cover),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                    ),
                  ],
                ),
                Positioned(
                  top: 250, // adjust top position as needed
                  left: MediaQuery.of(context).size.width / 2 - 190,

                  child: Container(
                    width: 380,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(30, 38, 44, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
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
                            widget.game.imageUrl!,
                            height: 80,
                            width: 80,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: EdgeInsets.only(top: 25, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.game.name,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget.game.publishers.first,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          width: 180,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 390,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Color.fromRGBO(99, 106, 246, 1),
                ),
                color: Color.fromRGBO(30, 38, 44, 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: Color.fromRGBO(99, 106, 246, 1),
                labelStyle: TextStyle(color: Colors.white),
                tabs: [Text("DESCRIPTION"), Text("AVIS")],
              ),
            ),
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: [
                  DescriptionWd(
                    game: widget.game,
                  ),
                  MyAvis(game: widget.game)
                ],
              ),
            ),
          ],
        ));
  }
}
