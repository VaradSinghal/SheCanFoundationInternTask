import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:she_can_found_intern/bloc/app_state.dart';
import 'package:she_can_found_intern/models/leaderboard_entry.dart';
import 'package:she_can_found_intern/models/reward_model.dart';
import 'package:she_can_found_intern/models/user_model.dart';

part 'app_event.dart';
final UserModel mockUser = UserModel(
  name: 'Varad Singhal',
  referralCode: 'varad2025',
  totalDonations: 5000,
  rewards: [
    RewardModel(
      title: 'Bronze Badge',
      icon: Icons.star_border,
      unlocked: true,
      color: const Color(0xFFCD7F32), 
    ),
    RewardModel(
      title: 'Silver Badge',
      icon: Icons.star_half,
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
);

final List<LeaderboardEntry> mockLeaderboard = [
  LeaderboardEntry(name: 'Priya Patel', score: 12000),
  LeaderboardEntry(name: 'Rahul Verma', score: 9500),
  LeaderboardEntry(name: 'Sneha Gupta', score: 8000),
  LeaderboardEntry(name: 'Vikram Singh', score: 6500),
  LeaderboardEntry(name: 'Ananya Rao', score: 5000),
];

final List<String> mockAnnouncements = [
  'New campaign launched! Share your referral code to boost donations.',
  'Top fundraisers will be featured in our monthly newsletter!',
  'Event: Virtual Fundraising Workshop on August 10th, 2025.',
];

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.initial()) {

    on<LoadAppData>((event, emit) {
      emit(AppState(
        user: mockUser,
        leaderboard: mockLeaderboard,
        announcements: mockAnnouncements,
      ));
    });
    on<AddDonation>((event, emit) {
      final currentUser = state.user;
      final updatedUser = UserModel(
        name: currentUser.name,
        referralCode: currentUser.referralCode,
        totalDonations: currentUser.totalDonations + event.amount,
        rewards: currentUser.rewards,
      );
      emit(state.copyWith(user: updatedUser));
    });
    add(LoadAppData());
  }
}