import 'package:gameapp/models/MyReviews.dart';

class MyGame {
  final int appid;
  final String name;
  final String description;
  final String price_overview;
  final List<String> genres;
  final List<String> developers;
  final List<String> publishers;
  final String? imageUrl;
  final String releaseDate;
  List<MyReview> reviews;

  MyGame({
    required this.appid,
    required this.name,
    this.price_overview = "",
    this.description = "",
    this.genres = const [],
    this.developers = const [],
    this.publishers = const [],
    this.imageUrl,
    this.releaseDate = "",
    this.reviews = const [],
  });

  MyGame.fromJson(Map<String, dynamic> json)
      : appid = json['steam_appid'] ?? 0,
        name = json['name'] ?? "",
        description = json['detailed_description'] ?? "",
        genres = json['genres'] != null
            ? List<String>.from(
                json['genres'].map((genre) => genre['description']))
            : [],
        developers = json['developers'] != null
            ? List<String>.from(json['developers'])
            : [],
        price_overview = json['price_overview'] != null
            ? json['price_overview']['final_formatted'] ?? ""
            : "",
        imageUrl = json['header_image'] ?? "",
        publishers = json['publishers'] != null
            ? List<String>.from(json['publishers'])
            : [],
        releaseDate = json['release_date'] != null
            ? json['release_date']['date'] ?? ""
            : "",
        reviews = [];

  Map<String, dynamic> toJson() => {
        'appid': appid,
        'price_overview': price_overview,
        'imageUrl': imageUrl,
        'name': name,
        'description': description,
        'genres': genres,
        'developers': developers,
        'publishers': publishers,
        'release_date': {'date': releaseDate},
        'reviews': reviews.map((review) => review.toJson()).toList(),
      };

  MyGame merge(MyGame other) {
    return MyGame(
      appid: appid,
      imageUrl: other.imageUrl,
      name: name,
      price_overview: other.price_overview.isNotEmpty
          ? other.price_overview
          : price_overview,
      description:
          other.description.isNotEmpty ? other.description : description,
      genres: other.genres.isNotEmpty ? other.genres : genres,
      developers: other.developers.isNotEmpty ? other.developers : developers,
      publishers: other.publishers.isNotEmpty ? other.publishers : publishers,
      releaseDate:
          other.releaseDate.isNotEmpty ? other.releaseDate : releaseDate,
      reviews: other.reviews.isNotEmpty ? other.reviews : reviews,
    );
  }
}
