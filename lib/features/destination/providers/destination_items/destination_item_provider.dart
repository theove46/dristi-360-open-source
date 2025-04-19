import 'package:dristi_open_source/features/destination/providers/destination_items/destination_item_notifier.dart';
import 'package:dristi_open_source/features/destination/providers/destination_items/destination_item_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final destinationItemsProvider =
    NotifierProvider<DestinationItemsNotifier, DestinationItemsState>(
      DestinationItemsNotifier.new,
      name: 'destinationItemsProvider',
    );
