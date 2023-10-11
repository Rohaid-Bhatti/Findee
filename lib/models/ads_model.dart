class AdsModel {
  String id;
  String name;
  String image;
  String reward;
  String number;
  String desc;
  String longitude;
  String latitude;
  String category;
  String userId;
  String email;
  String username;

  AdsModel({
    required this.id,
    required this.name,
    required this.image,
    required this.reward,
    required this.number,
    required this.desc,
    required this.longitude,
    required this.latitude,
    required this.category,
    required this.userId,
    required this.email,
    required this.username,
  });

  factory AdsModel.fromJson(json) => AdsModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    reward: json["reward"],
    number: json["number"],
    desc: json["desc"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    category: json["category"],
    userId: json["userId"],
    email: json["email"],
    username: json["username"],
  );
}
