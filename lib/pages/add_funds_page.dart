import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:she_can_found_intern/bloc/app_bloc.dart';
import 'package:she_can_found_intern/pages/announcements_page.dart';
import 'package:she_can_found_intern/pages/dashboard_page.dart';
import 'package:she_can_found_intern/pages/leaderboard_page.dart';

class AddFundsPage extends StatefulWidget {
  const AddFundsPage({super.key});

  @override
  State<AddFundsPage> createState() => _AddFundsPageState();
}

class _AddFundsPageState extends State<AddFundsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  final TextEditingController _amountController = TextEditingController();
  int _selectedIndex = 3;

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
    _amountController.dispose();
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LeaderboardPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AnnouncementsPage()),
        );
        break;
      case 3:
        break;
    }
  }

  void _selectAmount(double amount) {
    _amountController.text = amount.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF006064),
        elevation: 0,
        title: Text(
          'Add Funds',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Text(
                    'Contribute to the Cause',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF006064), Color(0xFF00838F)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF006064).withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter Donation Amount',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          TextField(
                            controller: _amountController,
                            decoration: InputDecoration(
                              labelText: 'Amount (₹)',
                              labelStyle: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: screenWidth * 0.04,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFFF59E0B),
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              prefixIcon: const Icon(
                                Icons.currency_rupee,
                                color: Colors.white,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Wrap(
                            spacing: screenWidth * 0.03,
                            runSpacing: screenHeight * 0.015,
                            children: [
                              _buildAmountButton(
                                context,
                                amount: 100,
                                screenWidth: screenWidth,
                              ),
                              _buildAmountButton(
                                context,
                                amount: 500,
                                screenWidth: screenWidth,
                              ),
                              _buildAmountButton(
                                context,
                                amount: 1000,
                                screenWidth: screenWidth,
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                final amount = double.tryParse(
                                  _amountController.text,
                                );
                                if (amount != null && amount > 0) {
                                  context.read<AppBloc>().add(
                                    AddDonation(amount),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Donation of ₹${amount.toStringAsFixed(0)} added!',
                                        style: GoogleFonts.poppins(),
                                      ),
                                      backgroundColor: const Color(0xFF006064),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                  Future.delayed(
                                    const Duration(seconds: 2),
                                    () {
                                      if (mounted) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const DashboardPage(),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Please enter a valid amount',
                                        style: GoogleFonts.poppins(),
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: screenWidth * 0.9,
                                padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.02,
                                  horizontal: screenWidth * 0.05,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF59E0B),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFFF59E0B,
                                      ).withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Add Donation',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
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
      ),
    );
  }

  Widget _buildAmountButton(
    BuildContext context, {
    required double amount,
    required double screenWidth,
  }) {
    return GestureDetector(
      onTap: () => _selectAmount(amount),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenWidth * 0.025,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Text(
          '₹${amount.toStringAsFixed(0)}',
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
