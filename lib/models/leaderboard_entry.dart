import 'package:she_can_found_intern/models/reward_model.dart';

class LeaderboardEntry {
  final String name;
  final double score;
  final List<RewardModel> badges;

  LeaderboardEntry({
    required this.name,
    required this.score,
    required this.badges,
  });
}