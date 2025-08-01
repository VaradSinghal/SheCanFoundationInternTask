import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:she_can_found_intern/bloc/app_bloc.dart';
import 'package:she_can_found_intern/bloc/app_state.dart';
import 'package:she_can_found_intern/pages/add_funds_page.dart';
import 'package:she_can_found_intern/pages/announcements_page.dart';
import 'package:she_can_found_intern/pages/dashboard_page.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeIn),
      ),
    );
    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
          ),
        );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
        break;
      case 1:
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AnnouncementsPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const AddFundsPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;
                  var tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final leaderboard = state.leaderboard;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            backgroundColor: const Color(0xFF006064),
            elevation: 0,
            title: Text(
              'Leaderboard',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: FadeTransition(
            opacity: _fadeAnimation,
            child: leaderboard.isEmpty
                ? Center(
                    child: Text(
                      'No leaderboard data available',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.045,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.03,
                    ),
                    itemCount: leaderboard.length,
                    itemBuilder: (context, index) {
                      final entry = leaderboard[index];
                      final isTopThree = index < 3;
                      final medalColor = index == 0
                          ? const Color(0xFFFFD700)
                          : index == 1
                          ? const Color(0xFFC0C0C0)
                          : index == 2
                          ? const Color(0xFFCD7F32)
                          : const Color(0xFF006064);

                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.01,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isTopThree
                                    ? [
                                        medalColor.withOpacity(0.2),
                                        Colors.white,
                                      ]
                                    : [Colors.white, Colors.white],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF006064,
                                  ).withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                                vertical: screenHeight * 0.015,
                              ),
                              leading: CircleAvatar(
                                backgroundColor: medalColor,
                                radius: screenWidth * 0.06,
                                child: Text(
                                  '${index + 1}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenWidth * 0.04,
                                  ),
                                ),
                              ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      entry.name,
                                      style: GoogleFonts.poppins(
                                        fontSize: screenWidth * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF1E293B),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: entry.badges
                                        .where((badge) => badge.unlocked)
                                        .map(
                                          (badge) => Padding(
                                            padding: EdgeInsets.only(
                                              left: screenWidth * 0.01,
                                            ),
                                            child: Icon(
                                              badge.icon,
                                              color: badge.color,
                                              size: screenWidth * 0.04,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                '₹${entry.score.toStringAsFixed(0)}',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.045,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF006064),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF006064), Color(0xFF00838F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF006064).withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: AnimatedScale(
                    scale: _selectedIndex == 0 ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.dashboard, size: 28),
                  ),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: AnimatedScale(
                    scale: _selectedIndex == 1 ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.leaderboard, size: 28),
                  ),
                  label: 'Leaderboard',
                ),
                BottomNavigationBarItem(
                  icon: AnimatedScale(
                    scale: _selectedIndex == 2 ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.announcement, size: 28),
                  ),
                  label: 'Announcements',
                ),
                BottomNavigationBarItem(
                  icon: AnimatedScale(
                    scale: _selectedIndex == 3 ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.add_circle, size: 28),
                  ),
                  label: 'Add Funds',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
