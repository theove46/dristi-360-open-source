class AccommodationsListEntity {
  AccommodationsListEntity({
    required this.id,
    required this.title,
    required this.onImageTitle,
    required this.district,
    required this.division,
    required this.category,
    required this.image,
  });

  String id;
  String title;
  String onImageTitle;
  String district;
  String division;
  List<String> category;
  String image;
}
