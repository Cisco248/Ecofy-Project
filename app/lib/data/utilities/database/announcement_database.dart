import 'package:e_wms_mobile/data/model/announce_model.dart';

class AnnouncementDatabase {
  static List<AnnouncementModel> announcement = [
    AnnouncementModel(
      title: 'Scheduled Maintenance',
      description:
          'The system will be undergoing maintenance on September 5th from 1:00 AM – 4:00 AM. Waste tracking and token redemption may be temporarily unavailable.',
      image: 'lib/core/assets/images/anouncement_banner_1.jpg',
    ),
    AnnouncementModel(
      title: 'New Reward Partner',
      description:
          'We’ve partnered with EcoMart Supermarkets! You can now redeem your tokens for shopping discounts.',
      image: 'lib/core/assets/images/anouncement_banner_2.jpg',
    ),
    AnnouncementModel(
      title: 'Weekly Waste Challenge',
      description:
          'Reduce your non-recyclable waste by 15% this week to earn bonus tokens.',
      image: 'lib/core/assets/images/anouncement_banner_1.jpg',
    ),
  ];

  AnnouncementDatabase();
}
