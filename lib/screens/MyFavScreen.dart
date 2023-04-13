import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gameapp/models/MyGame.dart';
import 'package:gameapp/screens/GameDetails.dart';
import 'package:gameapp/services/LikeServices.dart';
import 'package:gameapp/widget/MyLikeEmpty.dart';

class MyFavScreen extends StatefulWidget {
  const MyFavScreen({super.key});

  @override
  State<MyFavScreen> createState() => _MyFavScreenState();
}

class _MyFavScreenState extends State<MyFavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(26, 32, 37, 1),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Mes Likes"),
        backgroundColor: Color.fromRGBO(26, 32, 37, 1),
      ),
      body: StreamBuilder<List<MyGame>>(
        stream: LikesServices().getLikesList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: MyLikeEmpty());
          }

          final likeList = snapshot.data!;

          return ListView.builder(
            itemCount: likeList.length,
            itemBuilder: (context, index) {
              final order = likeList[index];

              return Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameDetails(game: order)));
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
                            order.imageUrl!,
                            height: 100,
                            width: 100,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: EdgeInsets.only(top: 15, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  order.name,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  order.publishers.first,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Prix : 10,00 €",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )
                              ],
                            ),
                          ),
                          width: 150,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(99, 106, 246, 1),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5)),
                          ),
                          width: 120,
                          child: Text(
                            "En savoir plus",
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
          );
        },
      ),
    );
  }
}
