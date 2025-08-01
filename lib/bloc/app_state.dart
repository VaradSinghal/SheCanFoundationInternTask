import 'package:she_can_found_intern/models/leaderboard_entry.dart';
import 'package:she_can_found_intern/models/user_model.dart';

class AppState {
  final UserModel user;
  final List<LeaderboardEntry> leaderboard;
  final List<String> announcements;

  AppState({
    required this.user,
    required this.leaderboard,
    required this.announcements,
  });

  AppState copyWith({
    UserModel? user,
    List<LeaderboardEntry>? leaderboard,
    List<String>? announcements,
  }) {
    return AppState(
      user: user ?? this.user,
      leaderboard: leaderboard ?? this.leaderboard,
      announcements: announcements ?? this.announcements,
    );
  }

  factory AppState.initial() {
    return AppState(
      user: UserModel(
        name: ' ',
        referralCode: ' ',
        totalDonations: 0.00,
        rewards: [],
      ),
      leaderboard: [],
      announcements: [],
    );
  }
}
