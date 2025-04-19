import 'package:dristi_open_source/domain/entities/destinations_list_entity.dart';

class DestinationsListResponseModel {
  DestinationsListResponseModel(this.destinationsListItems);

  DestinationsListResponseModel.fromJson({
    required List<dynamic> json,
  }) {
    destinationsListItems = <DestinationsListEntity>[];
    for (var item in json) {
      destinationsListItems.add(DestinationsListData.fromJson(item));
    }
  }

  List<DestinationsListEntity> destinationsListItems =
      <DestinationsListEntity>[];
}

class DestinationsListData extends DestinationsListEntity {
  String? listId;
  String? listTitle;
  String? listOnImageTitle;
  String? listDistrict;
  String? listDivision;
  List<String>? listCategory;
  String? listImage;

  DestinationsListData({
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

  factory DestinationsListData.fromJson(dynamic json) {
    return DestinationsListData(
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
