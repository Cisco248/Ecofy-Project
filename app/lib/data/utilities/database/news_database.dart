import 'package:e_wms_mobile/data/model/news_model.dart';

class NewsDatabase {
  static List<NewsModel> news = [
    NewsModel(
      title: 'City Launches Smart Waste Collection Program',
      description:
          'Our city has officially rolled out a digital waste tracking system. Residents can now monitor their waste contribution through the mobile app and earn redeemable tokens.',
      image: 'lib/core/assets/images/ravi.jpg',
    ),
    NewsModel(
      title: 'Plastic Recycling Rates Increase by 20% This Month',
      description:
          'Thanks to community participation, plastic recycling has seen a sharp increase. Let’s continue reducing single-use plastic !',
      image: 'lib/core/assets/images/ravi.jpg',
    ),
    NewsModel(
      title: 'Community Clean-Up Drive Successful',
      description:
          'Over 500 kg of waste was collected during last weekend’s community cleanup. Tokens have been credited to participants’ accounts.',
      image: 'lib/core/assets/images/ravi.jpg',
    ),
  ];

  NewsDatabase();
}
