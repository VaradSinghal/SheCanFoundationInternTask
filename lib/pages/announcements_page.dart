import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:she_can_found_intern/bloc/app_bloc.dart';
import 'package:she_can_found_intern/bloc/app_state.dart';
import 'package:she_can_found_intern/models/announcement_model.dart';
import 'package:she_can_found_intern/pages/add_funds_page.dart';
import 'package:she_can_found_intern/pages/dashboard_page.dart';
import 'package:she_can_found_intern/pages/leaderboard_page.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  int _selectedIndex = 2;
  final Map<int, bool> _expandedStates = {};

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
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const DashboardPage(),
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
      case 1:
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LeaderboardPage(),
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
      case 2:
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
        if (state.announcements == null || state.announcements.isEmpty) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            appBar: AppBar(
              backgroundColor: const Color(0xFF006064),
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text(
                'Announcements',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            body: Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Text(
                  'No announcements available',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.045,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            bottomNavigationBar: _buildBottomNavigationBar(),
          );
        }

        final announcements = state.announcements.asMap().entries.map((entry) {
          final index = entry.key;
          final content = entry.value.toString();
          return Announcement(
            title: [
              'New Campaign Launched!',
              'Newsletter Feature',
              'Virtual Workshop',
              'New Reward Unlocked!',
              'Community Spotlight',
            ][index % 5],
            content: content,
            timestamp: 'Aug ${index + 1}, 2025',
            icon: [
              Icons.campaign,
              Icons.star,
              Icons.event,
              Icons.card_giftcard,
              Icons.favorite,
            ][index % 5],
          );
        }).toList();

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            backgroundColor: const Color(0xFF006064),
            elevation: 0,
            title: Text(
              'Announcements',
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
          body: ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.03,
            ),
            itemCount: announcements.length,
            itemBuilder: (context, index) {
              final announcement = announcements[index];
              final isExpanded = _expandedStates[index] ?? false;

              return FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _expandedStates[index] = !isExpanded;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF006064).withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      Icon(
                                        announcement.icon,
                                        color: const Color(0xFF006064),
                                        size: screenWidth * 0.05,
                                      ),
                                      SizedBox(width: screenWidth * 0.02),
                                      Flexible(
                                        child: Text(
                                          announcement.title,
                                          style: GoogleFonts.poppins(
                                            fontSize: screenWidth * 0.045,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF1E293B),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  announcement.timestamp,
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth * 0.035,
                                    color: const Color(0xFF64748B),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              announcement.content,
                              style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.04,
                                color: const Color(0xFF64748B),
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: isExpanded ? null : 2,
                              overflow: isExpanded
                                  ? TextOverflow.visible
                                  : TextOverflow.ellipsis,
                            ),
                            if (announcement.content.length > 100)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: screenHeight * 0.01,
                                ),
                                child: Text(
                                  isExpanded ? 'Show Less' : 'Show More',
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth * 0.035,
                                    color: const Color(0xFFF59E0B),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          bottomNavigationBar: _buildBottomNavigationBar(),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF006064), Color(0xFF00838F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
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
    );
  }
}
