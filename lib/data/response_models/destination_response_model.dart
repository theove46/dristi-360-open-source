import 'package:dristi_open_source/domain/entities/blogs_entity.dart';
import 'package:dristi_open_source/domain/entities/images_entity.dart';
import 'package:dristi_open_source/domain/entities/destination_entity.dart';

class DestinationResponseModel {
  DestinationResponseModel(this.destination);

  DestinationResponseModel.fromJson({required dynamic json}) {
    destination = DestinationData.fromJson(json);
  }

  DestinationEntity destination = DestinationEntity.initial();
}

class DestinationData extends DestinationEntity {
  String? destinationId;
  String? destinationTitle;
  String? destinationOnImageTitle;
  String? destinationDistricts;
  String? destinationDivision;
  List<String>? destinationCategory;
  String? destinationImage;
  String? destinationDetails;
  String? destinationMapUrl;
  List<ImagesData>? destinationImages;
  List<String>? destinationSeasons;
  List<String>? destinationCautions;
  List<String>? destinationSpecials;
  List<BlogsData>? destinationBlogs;

  DestinationData({
    this.destinationId,
    this.destinationTitle,
    this.destinationOnImageTitle,
    this.destinationDistricts,
    this.destinationDivision,
    this.destinationCategory,
    this.destinationImage,
    this.destinationMapUrl,
    this.destinationDetails,
    this.destinationImages,
    this.destinationSeasons,
    this.destinationCautions,
    this.destinationSpecials,
    this.destinationBlogs,
  }) : super(
         id: destinationId ?? "",
         title: destinationTitle ?? "",
         onImageTitle: destinationOnImageTitle ?? "",
         district: destinationDistricts ?? "",
         division: destinationDivision ?? "",
         category: destinationCategory ?? [],
         image: destinationImage ?? "",
         mapUrl: destinationMapUrl ?? "",
         details: destinationDetails ?? "",
         images: destinationImages ?? [],
         seasons: destinationSeasons ?? [],
         cautions: destinationCautions ?? [],
         specials: destinationSpecials ?? [],
         blogs: destinationBlogs ?? [],
       );

  factory DestinationData.fromJson(dynamic json) {
    List<dynamic>? imagesJson = json['images'];
    List<ImagesData>? imagesDataList =
        imagesJson?.map((v) => ImagesData.fromJson(v)).toList();

    List<dynamic>? blogsJson = json['blogs'];
    List<BlogsData>? blogsDataList =
        blogsJson?.map((v) => BlogsData.fromJson(v)).toList();

    return DestinationData(
      destinationId: json['id'],
      destinationTitle: json['title'],
      destinationOnImageTitle: json['onImageTitle'],
      destinationDistricts: json['district'],
      destinationDivision: json['division'],
      destinationCategory:
          json['category'] != null ? json['category'].cast<String>() : [],
      destinationImage: json['image'],
      destinationMapUrl: json['mapUrl'],
      destinationDetails: json['details'],
      destinationImages: imagesDataList,
      destinationSeasons:
          json['seasons'] != null ? json['seasons'].cast<String>() : [],
      destinationCautions:
          json['cautions'] != null ? json['cautions'].cast<String>() : [],
      destinationSpecials:
          json['specials'] != null ? json['specials'].cast<String>() : [],
      destinationBlogs: blogsDataList,
    );
  }
}

class ImagesData extends ImagesEntity {
  String? imageUrl;
  String? imageCredit;

  ImagesData({this.imageUrl, this.imageCredit})
    : super(url: imageUrl ?? "", credit: imageCredit ?? "");

  factory ImagesData.fromJson(dynamic json) {
    return ImagesData(imageUrl: json['url'], imageCredit: json['credit']);
  }
}

class BlogsData extends BlogsEntity {
  String? blogsTitle;
  String? blogsUrl;
  String? blogsAuthor;
  String? blogsSite;

  BlogsData({this.blogsTitle, this.blogsUrl, this.blogsAuthor, this.blogsSite})
    : super(
        title: blogsTitle ?? "",
        url: blogsUrl ?? "",
        author: blogsAuthor ?? "",
        site: blogsSite ?? "",
      );

  factory BlogsData.fromJson(dynamic json) {
    return BlogsData(
      blogsTitle: json['title'],
      blogsUrl: json['url'],
      blogsAuthor: json['author'],
      blogsSite: json['site'],
    );
  }
}

class DestinationItemsResponseModel<T> {
  DestinationItemsResponseModel({required this.message, required this.data});

  final String message;
  final List<DestinationItemsEntity> data;

  factory DestinationItemsResponseModel.fromJson(List<dynamic> jsonList) {
    List<DestinationItemsEntity> convertedData =
        jsonList
            .map(
              (json) => DestinationItemsEntity(
                title: json['title'] ?? '',
                image: json['image'] ?? '',
              ),
            )
            .toList();

    return DestinationItemsResponseModel(message: '', data: convertedData);
  }
}
