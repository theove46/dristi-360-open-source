import 'package:dristi_open_source/domain/entities/accommodations_list_entity.dart';

class AccommodationsListResponseModel {
  AccommodationsListResponseModel(this.response);

  AccommodationsListResponseModel.fromJson({required List<dynamic> json}) {
    response = <AccommodationsListEntity>[];
    for (var item in json) {
      response.add(AccommodationsListData.fromJson(item));
    }
  }

  List<AccommodationsListEntity> response = <AccommodationsListEntity>[];
}

class AccommodationsListData extends AccommodationsListEntity {
  String? listId;
  String? listTitle;
  String? listOnImageTitle;
  String? listDistrict;
  String? listDivision;
  List<String>? listCategory;
  String? listImage;

  AccommodationsListData({
    this.listId,
    this.listTitle,
    this.listOnImageTitle,
    this.listDistrict,
    this.listDivision,
    this.listCategory,
    this.listImage,
  }) : super(
         id: listId ?? "",
         title: listTitle ?? "",
         onImageTitle: listOnImageTitle ?? "",
         district: listDistrict ?? "",
         division: listDivision ?? "",
         category: listCategory ?? [],
         image: listImage ?? "",
       );

  factory AccommodationsListData.fromJson(dynamic json) {
    return AccommodationsListData(
      listId: json['id'],
      listTitle: json['title'],
      listOnImageTitle: json['onImageTitle'],
      listDistrict: json['district'],
      listDivision: json['division'],
      listCategory:
          json['category'] != null ? json['category'].cast<String>() : [],
      listImage: json['image'],
    );
  }
}
