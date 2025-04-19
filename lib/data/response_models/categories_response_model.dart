import 'package:dristi_open_source/domain/entities/categories_entity.dart';

class CategoriesResponseModel {
  CategoriesResponseModel(this.categoryItems);

  CategoriesResponseModel.fromJson({required List<dynamic> json}) {
    categoryItems = <CategoryEntity>[];
    for (var item in json) {
      categoryItems.add(CategoryData.fromJson(item));
    }
  }

  List<CategoryEntity> categoryItems = <CategoryEntity>[];
}

class CategoryData extends CategoryEntity {
  String? categoryTitle;
  String? categoryImage;

  CategoryData({this.categoryTitle, this.categoryImage})
    : super(title: categoryTitle ?? "", image: categoryImage ?? "");

  factory CategoryData.fromJson(dynamic json) {
    return CategoryData(
      categoryTitle: json['title'],
      categoryImage: json['image'],
    );
  }
}
