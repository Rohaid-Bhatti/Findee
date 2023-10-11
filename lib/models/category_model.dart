class CategoryModel {
  String categoryId;
  String categoryName;
  String categoryImage;
  String categoryDes;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryDes,
  });

  factory CategoryModel.fromJson(json) => CategoryModel(
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    categoryImage: json["categoryImage"],
    categoryDes: json["categoryDes"],
  );
}
