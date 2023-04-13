import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gameapp/models/MyGame.dart';
import 'package:gameapp/screens/WelcomeScreen.dart';
import 'package:get/get.dart';

final toast = FToast();

class WishListServices {
  Future<void> addWish(MyGame game, bool status) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final String? userId = user?.uid;

      final CollectionReference ordersRef =
          FirebaseFirestore.instance.collection('Wishlist');
      final DocumentReference userRef = ordersRef.doc(userId);
      final QuerySnapshot existingLikesSnapshot = await userRef
          .collection('user_Wishlist')
          .where('Id', isEqualTo: game.appid)
          .where('name', isEqualTo: game.name)
          .get(); // Check for existing record with same appid and name

      if (existingLikesSnapshot.docs.isNotEmpty) {
        // If existing record found, delete it
        await userRef
            .collection('user_Wishlist')
            .doc(existingLikesSnapshot.docs.first.id)
            .delete();
      }

      // Add new record
      final String orderId = userRef
          .collection('user_Wishlist')
          .doc()
          .id; // Generate a unique ID for the order
      await userRef.collection('user_Wishlist').doc(orderId).set({
        'Id': game.appid,
        'name': game.name,
        'description': game.description,
        'publisher': game.publishers,
        'image': game.imageUrl,
        'userUid': user?.uid,
        'status': status
      });
      print('Wish added successfully');
    } catch (e) {
      print('Error: $e');
    }
  }

  Stream<List<MyGame>> getWishList() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String? userId = user?.uid;

    final CollectionReference ordersRef =
        FirebaseFirestore.instance.collection('Wishlist');
    final DocumentReference userRef = ordersRef.doc(userId);

    return userRef.collection('user_Wishlist').snapshots().map(
      (QuerySnapshot snapshot) {
        List<MyGame> likesList = snapshot.docs.map((DocumentSnapshot document) {
          return MyGame(
            appid: document['Id'],
            name: document['name'],
            description: document['description'],
            publishers: List<String>.from(document['publisher']),
            imageUrl: document['image'],
          );
        }).toList();

        // Add the print statement here
        print('Likes list:');
        for (MyGame game in likesList) {
          print(game.name);
        }

        return likesList;
      },
    );
  }
}
