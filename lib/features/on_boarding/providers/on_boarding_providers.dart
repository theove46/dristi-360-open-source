import 'package:dristi_open_source/features/on_boarding/providers/on_boarding_notifier.dart';
import 'package:dristi_open_source/features/on_boarding/providers/on_boarding_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onBoardingProvider =
    NotifierProvider<OnBoardingNotifier, OnBoardingState>(
      OnBoardingNotifier.new,
      name: 'splashProvider',
    );

final inFirstTime = StateProvider<bool>((ref) => false, name: 'inFirstTime');
