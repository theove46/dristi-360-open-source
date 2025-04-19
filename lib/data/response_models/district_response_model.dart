import 'package:dristi_open_source/domain/entities/district_entity.dart';

class DistrictResponseModel<T> {
  DistrictResponseModel({required this.message, required this.data});

  final String message;
  final List<DistrictEntity> data;

  factory DistrictResponseModel.fromJson(List<dynamic> jsonList) {
    List<DistrictEntity> convertedData =
        jsonList
            .map(
              (json) => DistrictEntity(
                title: json['title'] ?? '',
                division: json['division'] ?? '',
              ),
            )
            .toList();

    return DistrictResponseModel(message: '', data: convertedData);
  }
}
