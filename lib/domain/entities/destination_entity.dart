import 'package:dristi_open_source/domain/entities/blogs_entity.dart';
import 'package:dristi_open_source/domain/entities/images_entity.dart';

class DestinationEntity {
  String id;
  String title;
  String onImageTitle;
  String district;
  String division;
  List<String>? category;
  String image;
  String details;
  String mapUrl;
  List<ImagesEntity>? images;
  List<String>? seasons;
  List<String>? cautions;
  List<String>? specials;
  List<BlogsEntity>? blogs;

  DestinationEntity({
    required this.id,
    required this.title,
    required this.onImageTitle,
    required this.district,
    required this.division,
    required this.category,
    required this.image,
    required this.details,
    required this.mapUrl,
    required this.images,
    required this.seasons,
    required this.cautions,
    required this.specials,
    required this.blogs,
  });

  DestinationEntity.initial()
    : id = "",
      title = "",
      onImageTitle = "",
      district = "",
      division = "",
      category = [],
      image = "",
      mapUrl = "",
      details = "",
      images = [],
      seasons = [],
      cautions = [],
      specials = [],
      blogs = [];
}

class DestinationItemsEntity {
  DestinationItemsEntity({required this.title, required this.image});

  String title;
  String image;
}
