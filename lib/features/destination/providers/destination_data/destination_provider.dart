import 'package:dristi_open_source/features/destination/providers/destination_data/destination_notifier.dart';
import 'package:dristi_open_source/features/destination/providers/destination_data/destination_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final destinationProvider =
    NotifierProvider<DestinationNotifier, DestinationState>(
      DestinationNotifier.new,
      name: 'destinationProvider',
    );

final currentPageProvider = StateProvider.autoDispose.family<int, String>((
  ref,
  instanceId,
) {
  return 0;
}, name: 'currentPageProvider');
