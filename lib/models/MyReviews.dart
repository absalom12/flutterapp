class MyReview {
  final String reviewerId;
  final String reviewText;

  MyReview({
    required this.reviewerId,
    required this.reviewText,
  });

  factory MyReview.fromJson(Map<String, dynamic> json) {
    return MyReview(
      reviewerId: json['author']['steamid'] ?? "",
      reviewText: json['review'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        'reviewerId': reviewerId,
        'reviewText': reviewText,
      };
}
