import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:she_can_found_intern/bloc/app_state.dart';
import 'package:she_can_found_intern/models/leaderboard_entry.dart';
import 'package:she_can_found_intern/models/reward_model.dart';
import 'package:she_can_found_intern/models/user_model.dart';

part 'app_event.dart';

const double bronzeThreshold = 2000;
const double silverThreshold = 10000;
const double goldThreshold = 20000;

final UserModel mockUser = UserModel(
  name: 'Varad Singhal',
  referralCode: 'varad2025',
  totalDonations: 5000,
  rewards: [
    RewardModel(
      title: 'Bronze Badge',
      icon: Icons.star,
      unlocked: true,
      color: const Color(0xFFCD7F32),
    ),
    RewardModel(
      title: 'Silver Badge',
      icon: Icons.star,
      unlocked: true,
      color: const Color(0xFFC0C0C0),
    ),
    RewardModel(
      title: 'Gold Badge',
      icon: Icons.star,
      unlocked: false,
      color: const Color(0xFFFFD700),
    ),
  ],
);

final List<LeaderboardEntry> mockLeaderboard = [
  LeaderboardEntry(
    name: 'Priya Patel',
    score: 21000,
    badges: [
      RewardModel(
        title: 'Bronze Badge',
        icon: Icons.star,
        unlocked: true,
        color: const Color(0xFFCD7F32),
      ),
      RewardModel(
        title: 'Silver Badge',
        icon: Icons.star,
        unlocked: true,
        color: const Color(0xFFC0C0C0),
      ),
      RewardModel(
        title: 'Gold Badge',
        icon: Icons.star,
        unlocked: true,
        color: const Color(0xFFFFD700),
      ),
    ],
  ),
  LeaderboardEntry(
    name: 'Rahul Verma',
    score: 11000,
    badges: [
      RewardModel(
        title: 'Bronze Badge',
        icon: Icons.star,
        unlocked: true,
        color: const Color(0xFFCD7F32),
      ),
      RewardModel(
        title: 'Silver Badge',
        icon: Icons.star,
        unlocked: true,
        color: const Color(0xFFC0C0C0),
      ),
      RewardModel(
        title: 'Gold Badge',
        icon: Icons.star,
        unlocked: false,
        color: const Color(0xFFFFD700),
      ),
    ],
  ),
  LeaderboardEntry(
    name: 'Sneha Gupta',
    score: 8000,
    badges: [
      RewardModel(
        title: 'Bronze Badge',
        icon: Icons.star,
        unlocked: true,
        color: const Color(0xFFCD7F32),
      ),
      RewardModel(
        title: 'Silver Badge',
        icon: Icons.star,
        unlocked: false,
        color: const Color(0xFFC0C0C0),
      ),
      RewardModel(
        title: 'Gold Badge',
        icon: Icons.star,
        unlocked: false,
        color: const Color(0xFFFFD700),
      ),
    ],
  ),
  LeaderboardEntry(
    name: 'Vikram Singh',
    score: 6500,
    badges: [
      RewardModel(
        title: 'Bronze Badge',
        icon: Icons.star,
        unlocked: true,
        color: const Color(0xFFCD7F32),
      ),
      RewardModel(
        title: 'Silver Badge',
        icon: Icons.star,
        unlocked: false,
        color: const Color(0xFFC0C0C0),
      ),
      RewardModel(
        title: 'Gold Badge',
        icon: Icons.star,
        unlocked: false,
        color: const Color(0xFFFFD700),
      ),
    ],
  ),
  LeaderboardEntry(
    name: 'Ananya Rao',
    score: 4000,
    badges: [
      RewardModel(
        title: 'Bronze Badge',
        icon: Icons.star,
        unlocked: true,
        color: const Color(0xFFCD7F32),
      ),
      RewardModel(
        title: 'Silver Badge',
        icon: Icons.star,
        unlocked: false,
        color: const Color(0xFFC0C0C0),
      ),
      RewardModel(
        title: 'Gold Badge',
        icon: Icons.star,
        unlocked: false,
        color: const Color(0xFFFFD700),
      ),
    ],
  ),
];

final List<String> mockAnnouncements = [
  'New campaign launched! Share your referral code to boost donations.',
  'Top fundraisers will be featured in our monthly newsletter!',
  'Event: Virtual Fundraising Workshop on August 10th, 2025.',
];

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.initial()) {
    on<LoadAppData>((event, emit) {
      emit(
        AppState(
          user: mockUser,
          leaderboard: mockLeaderboard,
          announcements: mockAnnouncements,
        ),
      );
    });

    on<AddDonation>((event, emit) {
      final currentUser = state.user;
      final newTotal = currentUser.totalDonations + event.amount;

      final updatedRewards = currentUser.rewards.map((reward) {
        if (reward.title == 'Bronze Badge' && newTotal >= bronzeThreshold) {
          return RewardModel(
            title: reward.title,
            icon: reward.icon,
            unlocked: true,
            color: reward.color,
          );
        } else if (reward.title == 'Silver Badge' &&
            newTotal >= silverThreshold) {
          return RewardModel(
            title: reward.title,
            icon: reward.icon,
            unlocked: true,
            color: reward.color,
          );
        } else if (reward.title == 'Gold Badge' && newTotal >= goldThreshold) {
          return RewardModel(
            title: reward.title,
            icon: reward.icon,
            unlocked: true,
            color: reward.color,
          );
        }
        return reward;
      }).toList();

      final updatedUser = UserModel(
        name: currentUser.name,
        referralCode: currentUser.referralCode,
        totalDonations: newTotal,
        rewards: updatedRewards,
      );

      emit(state.copyWith(user: updatedUser));
    });

    add(LoadAppData());
  }
}
