import 'package:dristi_open_source/domain/entities/settings_entity.dart';

class SettingsResponseModel {
  SettingsResponseModel(this.settingsEntity);

  SettingsResponseModel.fromJson({required dynamic json}) {
    settingsEntity = SettingsData.fromJson(json);
  }

  SettingsEntity settingsEntity = SettingsEntity.initial();
}

class SettingsData extends SettingsEntity {
  Follow? followData;
  RatingsReviews? ratingsReviewsData;
  Share? shareData;
  Contribution? contributionData;
  Contact? contactData;
  Support? supportData;
  PrivacyPolicy? privacyPolicyData;
  TermsServices? termsServicesData;
  String? messageData;

  SettingsData({
    this.followData,
    this.ratingsReviewsData,
    this.shareData,
    this.contributionData,
    this.contactData,
    this.supportData,
    this.privacyPolicyData,
    this.termsServicesData,
    this.messageData,
  }) : super(
         follow: followData ?? FollowData(),
         ratingsReviews: ratingsReviewsData ?? RatingsReviewsData(),
         share: shareData ?? ShareData(),
         contribution: contributionData ?? ContributionData(),
         contact: contactData ?? ContactData(),
         support: supportData ?? SupportData(),
         privacyPolicy: privacyPolicyData ?? PrivacyPolicyData(),
         termsServices: termsServicesData ?? TermsServicesData(),
         message: messageData ?? "",
       );

  factory SettingsData.fromJson(dynamic json) {
    Follow? followData =
        json['follow'] != null ? FollowData.fromJson(json['follow']) : null;

    RatingsReviews? ratingsReviewsData =
        json['ratings_reviews'] != null
            ? RatingsReviewsData.fromJson(json['ratings_reviews'])
            : null;

    Share? shareData =
        json['share'] != null ? ShareData.fromJson(json['share']) : null;

    Contribution? contributionData =
        json['contribution'] != null
            ? ContributionData.fromJson(json['contribution'])
            : null;

    Contact? contactData =
        json['contact'] != null ? ContactData.fromJson(json['contact']) : null;

    Support? supportData =
        json['support'] != null ? SupportData.fromJson(json['support']) : null;

    TermsServices? termsServicesData =
        json['terms_services'] != null
            ? TermsServicesData.fromJson(json['terms_services'])
            : null;

    PrivacyPolicy? privacyPolicyData =
        json['privacy_policy'] != null
            ? PrivacyPolicyData.fromJson(json['privacy_policy'])
            : null;

    return SettingsData(
      followData: followData,
      ratingsReviewsData: ratingsReviewsData,
      shareData: shareData,
      contributionData: contributionData,
      contactData: contactData,
      supportData: supportData,
      privacyPolicyData: privacyPolicyData,
      termsServicesData: termsServicesData,
      messageData: json['message'] ?? "",
    );
  }
}

class FollowData extends Follow {
  String? descriptionData;
  String? facebookUrlData;
  String? instagramUrlData;
  String? youtubeUrlData;

  FollowData({
    this.descriptionData,
    this.facebookUrlData,
    this.instagramUrlData,
    this.youtubeUrlData,
  }) : super(
         description: descriptionData ?? "",
         facebookUrl: facebookUrlData ?? "",
         instagramUrl: instagramUrlData ?? "",
         youtubeUrl: youtubeUrlData ?? "",
       );

  factory FollowData.fromJson(Map<String, dynamic> json) {
    return FollowData(
      descriptionData: json['description'] ?? "",
      facebookUrlData: json['facebook_url'] ?? "",
      instagramUrlData: json['instagram_url'] ?? "",
      youtubeUrlData: json['youtube_url'] ?? "",
    );
  }
}

class RatingsReviewsData extends RatingsReviews {
  String? descriptionData;
  String? playStoreLinkData;

  RatingsReviewsData({this.descriptionData, this.playStoreLinkData})
    : super(
        description: descriptionData ?? "",
        playStoreLink: playStoreLinkData ?? "",
      );

  factory RatingsReviewsData.fromJson(Map<String, dynamic> json) {
    return RatingsReviewsData(
      descriptionData: json['description'] ?? "",
      playStoreLinkData: json['play_store_link'] ?? "",
    );
  }
}

class ShareData extends Share {
  String? descriptionData;
  String? shareLinkData;

  ShareData({this.descriptionData, this.shareLinkData})
    : super(description: descriptionData ?? "", shareLink: shareLinkData ?? "");

  factory ShareData.fromJson(Map<String, dynamic> json) {
    return ShareData(
      descriptionData: json['description'] ?? "",
      shareLinkData: json['share_link'] ?? "",
    );
  }
}

class ContributionData extends Contribution {
  String? descriptionData;
  String? googleFormData;

  ContributionData({this.descriptionData, this.googleFormData})
    : super(
        description: descriptionData ?? "",
        googleForm: googleFormData ?? "",
      );

  factory ContributionData.fromJson(Map<String, dynamic> json) {
    return ContributionData(
      descriptionData: json['description'] ?? "",
      googleFormData: json['google_form'] ?? "",
    );
  }
}

class ContactData extends Contact {
  String? descriptionData;
  String? emailData;
  String? whatsappData;

  ContactData({this.descriptionData, this.emailData, this.whatsappData})
    : super(
        description: descriptionData ?? "",
        email: emailData ?? "",
        whatsapp: whatsappData ?? "",
      );

  factory ContactData.fromJson(Map<String, dynamic> json) {
    return ContactData(
      descriptionData: json['description'] ?? "",
      emailData: json['email'] ?? "",
      whatsappData: json['whatsapp'] ?? "",
    );
  }
}

class SupportData extends Support {
  String? descriptionData;
  String? facebookData;
  String? instagramData;

  SupportData({this.descriptionData, this.facebookData, this.instagramData})
    : super(
        description: descriptionData ?? "",
        facebook: facebookData ?? "",
        instagram: instagramData ?? "",
      );

  factory SupportData.fromJson(Map<String, dynamic> json) {
    return SupportData(
      descriptionData: json['description'] ?? "",
      facebookData: json['facebook'] ?? "",
      instagramData: json['instagram'] ?? "",
    );
  }
}

class PrivacyPolicyData extends PrivacyPolicy {
  String? descriptionData;
  List<String>? policiesData;

  PrivacyPolicyData({this.descriptionData, this.policiesData})
    : super(description: descriptionData ?? "", policies: policiesData ?? []);

  factory PrivacyPolicyData.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyData(
      descriptionData: json['description'] ?? "",
      policiesData: (json['policies'] as List).cast<String>(),
    );
  }
}

class TermsServicesData extends TermsServices {
  String? descriptionData;
  List<String>? termsServicesData;

  TermsServicesData({this.descriptionData, this.termsServicesData})
    : super(description: descriptionData ?? "", terms: termsServicesData ?? []);

  factory TermsServicesData.fromJson(Map<String, dynamic> json) {
    return TermsServicesData(
      descriptionData: json['description'] ?? "",
      termsServicesData: (json['terms'] as List).cast<String>(),
    );
  }
}
