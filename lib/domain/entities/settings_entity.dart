class SettingsEntity {
  Follow follow;
  RatingsReviews ratingsReviews;
  Share share;
  Contribution contribution;
  Contact contact;
  Support support;
  PrivacyPolicy privacyPolicy;
  TermsServices termsServices;
  String message;

  SettingsEntity({
    required this.follow,
    required this.ratingsReviews,
    required this.share,
    required this.contribution,
    required this.contact,
    required this.support,
    required this.privacyPolicy,
    required this.termsServices,
    required this.message,
  });

  SettingsEntity.initial()
      : follow = Follow.initial(),
        ratingsReviews = RatingsReviews.initial(),
        share = Share.initial(),
        contribution = Contribution.initial(),
        contact = Contact.initial(),
        support = Support.initial(),
        privacyPolicy = PrivacyPolicy.initial(),
        termsServices = TermsServices.initial(),
        message = '';
}

class Follow {
  String description;
  String facebookUrl;
  String instagramUrl;
  String youtubeUrl;

  Follow({
    required this.description,
    required this.facebookUrl,
    required this.instagramUrl,
    required this.youtubeUrl,
  });

  Follow.initial()
      : description = "",
        facebookUrl = "",
        youtubeUrl = "",
        instagramUrl = "";
}

class RatingsReviews {
  String description;
  String playStoreLink;

  RatingsReviews({
    required this.description,
    required this.playStoreLink,
  });

  RatingsReviews.initial()
      : description = "",
        playStoreLink = "";
}

class Share {
  String description;
  String shareLink;

  Share({
    required this.description,
    required this.shareLink,
  });

  Share.initial()
      : description = "",
        shareLink = "";
}

class Contribution {
  String description;
  String googleForm;

  Contribution({
    required this.description,
    required this.googleForm,
  });

  Contribution.initial()
      : description = "",
        googleForm = "";
}

class Contact {
  String description;
  String whatsapp;
  String email;

  Contact({
    required this.description,
    required this.whatsapp,
    required this.email,
  });

  Contact.initial()
      : description = "",
        whatsapp = "",
        email = "";
}

class Support {
  String description;
  String facebook;
  String instagram;

  Support({
    required this.description,
    required this.facebook,
    required this.instagram,
  });

  Support.initial()
      : description = "",
        facebook = "",
        instagram = "";
}

class PrivacyPolicy {
  final String description;
  final List<String> policies;

  PrivacyPolicy({
    required this.description,
    required this.policies,
  });

  PrivacyPolicy.initial()
      : description = "",
        policies = [];
}

class TermsServices {
  final String description;
  final List<String> terms;

  TermsServices({
    required this.description,
    required this.terms,
  });

  TermsServices.initial()
      : description = "",
        terms = [];
}
