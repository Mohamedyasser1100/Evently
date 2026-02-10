class OnboardingModel {
  final String image;
  final String title;
  final String? subTitle;

  OnboardingModel({required this.image, required this.title, this.subTitle});

  static List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      image: 'assets/images/onboarding2.png',
      title: 'Find Events That Inspire You',
      subTitle:
          'Dive into a world of events crafted to fit\nyour unique interests. Whether you are into\nlive music, art workshops, professional\nnetworking, or simply discovering new\nexperiences, we have something for\neveryone. Our curated recommendations\nwill help you explore, connect, and make\nthe most of every opportunity around you.',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding3.png',
      title: 'Effortless Event Planning',
      subTitle:
          'Take the hassle out of organizing events with\nour all-in-one planning tools. From setting\nup invites and managing RSVPs to scheduling\nreminders and coordinating details, we’ve\ngot you covered. Plan with ease and focus\non what matters – creating an unforgettable\nexperience for you and your guests.',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding4.png',
      title: 'Connect with Friends & Share Moments',
      subTitle:
          'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.',
    ),
  ];
}
