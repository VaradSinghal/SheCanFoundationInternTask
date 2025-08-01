import 'package:she_can_found_intern/models/reward_model.dart';

class UserModel {
  final String name;
  final String referralCode;
  final double totalDonations;
  final List<RewardModel> rewards;

  UserModel({
    required this.name,
    required this.referralCode,
    required this.totalDonations,
    required this.rewards,
  });
  UserModel copyWith({
    String? name,
    String? referralCode,
    double? totalDonations,
    List<RewardModel>? rewards,
  }) {
    return UserModel(
      name: name ?? this.name,
      referralCode: referralCode ?? this.referralCode,
      totalDonations: totalDonations ?? this.totalDonations,
      rewards: rewards ?? this.rewards,
    );
  }
}
