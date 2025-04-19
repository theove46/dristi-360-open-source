import 'package:dristi_open_source/features/accommodation/providers/accommodation_data/accommodation_notifier.dart';
import 'package:dristi_open_source/features/accommodation/providers/accommodation_data/accommodation_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accommodationProvider =
    NotifierProvider<AccommodationNotifier, AccommodationState>(
      AccommodationNotifier.new,
      name: 'accommodationProvider',
    );
