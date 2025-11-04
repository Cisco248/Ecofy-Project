import 'package:e_wms_mobile/data/model/goal_model.dart';

class GoalDatabase {
  static List<Goal> goals = [
    Goal(
      title: 'Recycle 1000 kg of Plastic in September',
      description:
          'Community-wide challenge to recycle 1000 kg of plastic waste. Progress will be tracked on the dashboard.',
      image: 'lib/core/assets/images/goal_banner.png',
    ),
    Goal(
      title: 'Zero Food Waste in Schools',
      description:
          'Partner schools aim to reduce food wastage by 50% this term by promoting portion control and composting.',
      image: 'lib/core/assets/images/goal_banner.png',
    ),
    Goal(
      title: 'Reward 500 Active Users with Eco-Tokens',
      description:
          'Encourage participation in the system by rewarding the first 500 users who actively track and segregate their waste.',
      image: 'lib/core/assets/images/goal_banner.png',
    ),
  ];
  GoalDatabase();
}
