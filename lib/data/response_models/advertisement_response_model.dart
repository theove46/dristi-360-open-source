import 'package:dristi_open_source/domain/entities/advertisement_entity.dart';

class SingleAdvertisementResponseModel {
  SingleAdvertisementResponseModel(this.singleAdvertisementItem);

  SingleAdvertisementResponseModel.fromJson(
      {required Map<String, dynamic> json})
      : singleAdvertisementItem =
            AdvertisementData.fromJsonForSingleAdvertisement(json);

  AdvertisementEntity singleAdvertisementItem;
}

class MultipleAdvertisementResponseModel {
  MultipleAdvertisementResponseModel(this.multipleAdvertisementItems);

  MultipleAdvertisementResponseModel.fromJson({
    required List<dynamic> json,
  }) {
    multipleAdvertisementItems = <AdvertisementEntity>[];
    for (var item in json) {
      multipleAdvertisementItems
          .add(AdvertisementData.fromJsonForMultipleAdvertisement(item));
    }
  }

  List<AdvertisementEntity> multipleAdvertisementItems =
      <AdvertisementEntity>[];
}

class AdvertisementData extends AdvertisementEntity {
  String? advertisementTitle;
  String? advertisementUrl;
  String? advertisementImage;

  AdvertisementData({
    this.advertisementTitle,
    this.advertisementUrl,
    this.advertisementImage,
  }) : super(
          title: advertisementTitle ?? "",
          url: advertisementUrl ?? "",
          image: advertisementImage ?? "",
        );

  factory AdvertisementData.fromJsonForSingleAdvertisement(
      Map<String, dynamic> json) {
    return AdvertisementData(
      advertisementTitle: json['title'],
      advertisementUrl: json['url'],
      advertisementImage: json['image'],
    );
  }

  factory AdvertisementData.fromJsonForMultipleAdvertisement(dynamic json) {
    return AdvertisementData(
      advertisementTitle: json['title'],
      advertisementUrl: json['url'],
      advertisementImage: json['image'],
    );
  }
}
