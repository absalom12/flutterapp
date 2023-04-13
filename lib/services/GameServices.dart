import 'dart:convert';
import 'dart:math';

import 'package:gameapp/models/MyGame.dart';
import 'package:gameapp/models/MyReviews.dart';
import 'package:http/http.dart' as http;

class GameServices {
  Future<List<MyGame>> fetchGames() async {
    final response = await http.get(
        Uri.parse('https://api.steampowered.com/ISteamApps/GetAppList/v2/'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> gamesJson = json['applist']['apps'];
      final reversed = gamesJson.reversed;
      final selectedGames = gamesJson.reversed
          .take(20)
          .where((gameJson) =>
              gameJson['name'] != null &&
              gameJson['name'].isNotEmpty) // filter out games with empty name

          .map((gameJson) => MyGame(
                appid: gameJson['appid'],
                name: gameJson['name'],
              ))
          .toList();
      // Get detailed information for each game
      final List<String> appIds =
          selectedGames.map((game) => game.appid.toString()).toList();
      final List<MyGame> detailedGames = await fetchDetailedGames(appIds);
      final List<MyGame> reviewdGames = await fetchDetailedGames(appIds);

      // Merge detailed information into the original list of games
      for (int i = 0; i < selectedGames.length; i++) {
        selectedGames[i] = selectedGames[i].merge(detailedGames[i]);
        selectedGames[i] = selectedGames[i].merge(reviewdGames[i]);
      }
      for (MyGame game in selectedGames) {
        print(
            'Name: ${game.name}, ID: ${game.appid},publisher: ${game.publishers},${game.reviews}');
      }

      return selectedGames;
    } else {
      throw Exception('Failed to fetch games');
    }
  }

  Future<List<MyGame>> fetchDetailedGames(List<String> appIds) async {
    final List<MyGame> detailedGames = [];

    for (String appId in appIds) {
      final response = await http.get(Uri.parse(
          'https://store.steampowered.com/api/appdetails?appids=$appId'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final Map<String, dynamic>? gameJson = json['$appId']['data'];
        final String priceOverview = gameJson?['price_overview'] != null
            ? gameJson!['price_overview']['final_formatted'] ?? ""
            : "";
        detailedGames.add(MyGame(
          appid: gameJson?['steam_appid'] ?? 0,
          name: gameJson?['name'] ?? "",
          price_overview: priceOverview,
          imageUrl: gameJson?['header_image'] ?? "", // new property
          publishers: gameJson?['publishers'] != null
              ? List<String>.from(gameJson?['publishers'])
              : [],
          description: gameJson?['short_description'] ?? "",
        ));
      } else {
        throw Exception('Failed to fetch game details for appid: $appId');
      }
    }

    return detailedGames;
  }

  Future<List<MyGame>> fetchReviewsGames(List<String> appIds) async {
    final List<MyGame> reviewsGames = [];

    for (String appId in appIds) {
      final response = await http.get(
          Uri.parse('https://store.steampowered.com/appreviews/$appId?json=1'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final Map<String, dynamic>? gameJson = json['$appId']['data'];
        final List<dynamic>? reviewsJson = json['$appId']['reviews'];
        final List<MyReview> reviews = [];
        if (reviewsJson != null) {
          for (final reviewJson in reviewsJson) {
            final reviewerId = reviewJson['author']['steamid'];
            final reviewText = reviewJson['review'];
            reviews
                .add(MyReview(reviewerId: reviewerId, reviewText: reviewText));
          }
        }
        reviewsGames.add(MyGame(
          appid: gameJson?['steam_appid'] ?? 0,
          name: gameJson?['name'] ?? "",
          reviews: reviews,
        ));
      } else {
        throw Exception('Failed to fetch game details for appid: $appId');
      }
    }

    return reviewsGames;
  }
}
