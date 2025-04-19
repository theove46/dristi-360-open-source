import 'package:dristi_open_source/domain/entities/images_entity.dart';
import 'package:flutter/material.dart';

class GalleryScreenEntity {
  final Key? key;
  final String galleryName;
  final List<ImagesEntity> images;
  final int initialIndex;
  GalleryScreenEntity({
    this.key,
    required this.galleryName,
    required this.images,
    this.initialIndex = 0,
  });
}
