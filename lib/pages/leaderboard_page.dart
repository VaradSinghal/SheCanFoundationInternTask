import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:she_can_found_intern/bloc/app_bloc.dart';
import 'package:she_can_found_intern/bloc/app_state.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final leaderboard = state.leaderboard;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Leaderboard'),
            backgroundColor: const Color(0xFF4A90E2),
          ),
          body: FadeTransition(
            opacity: _fadeAnimation,
            child: leaderboard.isEmpty
                ? const Center(child: Text('No leaderboard data available'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: leaderboard.length,
                    itemBuilder: (context, index) {
                      final entry = leaderboard[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFF4A90E2),
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Row(
                            children: [
                              Text(entry.name),
                              const SizedBox(width: 8),
                              Row(
                                children: entry.badges
                                    .where((badge) => badge.unlocked)
                                    .map(
                                      (badge) => Padding(
                                        padding: const EdgeInsets.only(
                                          left: 4.0,
                                        ),
                                        child: Icon(
                                          badge.icon,
                                          color: badge.color,
                                          size: 16,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                          trailing: Text('₹${entry.score.toStringAsFixed(0)}'),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
