import 'dart:io';

import 'package:dristi_open_source/core/global_providers/deep_linking/deep_linking_state.dart';
import 'package:dristi_open_source/core/loggers/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

class DeepLinkingNotifier extends Notifier<DeepLinkingState> {
  @override
  DeepLinkingState build() {
    return const DeepLinkingState();
  }

  Future<void> navigateToEmail({
    required String emailAccount,
    String subject = '',
    String body = '',
  }) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAccount,
    );

    try {
      await launchUrl(emailLaunchUri);
      state = state.copyWith(
        status: DeepLinkingStatus.success,
      );
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      state = state.copyWith(
        status: DeepLinkingStatus.failure,
      );
      throw Exception("Error opening email app.");
    }
  }

  Future<void> navigateToWhatsappMessage({
    required String phoneNumber,
  }) async {
    var androidUrl = "whatsapp://send?phone=$phoneNumber";
    var iosUrl = "https://wa.me/$phoneNumber";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }

      state = state.copyWith(
        status: DeepLinkingStatus.success,
      );
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      state = state.copyWith(
        status: DeepLinkingStatus.failure,
      );
      throw Exception(
          "Whatsapp is not installed or Error on loading Whatsapp.");
    }
  }

  // TODO: Implement after publish in play store.
  Future<void> openStoreListing({required String packageName}) async {
    final InAppReview inAppReview = InAppReview.instance;

    inAppReview.requestReview();

    inAppReview.openStoreListing(
      appStoreId: packageName,
    );
  }

  Future<void> openSocialAccountsOrLinks({required String url}) async {
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

      state = state.copyWith(
        status: DeepLinkingStatus.success,
      );
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());

      state = state.copyWith(
        status: DeepLinkingStatus.failure,
      );
      throw Exception("Error opening social media app.");
    }
  }
}
