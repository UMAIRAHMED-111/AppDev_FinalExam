class BannerModel {
  final String id;
  final String imageUrl;
  final String? link;

  BannerModel({
    required this.id,
    required this.imageUrl,
    this.link,
  });

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      link: map['link'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'link': link,
    };
  }
} 