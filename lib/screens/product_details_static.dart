import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class ProductDetailsStaticScreen extends StatelessWidget {
  const ProductDetailsStaticScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8C6F9),
              Color(0xFFF6E6F9),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context),
                const SizedBox(height: 18),
                _buildCard(),
                const SizedBox(height: 32),
                _buildLastActivities(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 1),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Text(
            'Chards',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              letterSpacing: 0.5,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.help_outline, color: Colors.black54),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Center(
      child: Container(
        width: 320,
        height: 180,
        decoration: BoxDecoration(
          color: const Color(0xFFF76CA7),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF76CA7).withOpacity(0.18),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 24,
              left: 24,
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/883/883407.png', // chip icon
                width: 36,
                height: 36,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 24,
              right: 24,
              child: Icon(Icons.wifi, color: Colors.white.withOpacity(0.8)),
            ),
            Positioned(
              top: 28,
              left: 80,
              child: const Text(
                'World',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
              left: 24,
              bottom: 48,
              child: const Text(
                '5413 7502 3412 2455',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(
              left: 24,
              bottom: 28,
              child: const Text(
                'Account card',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),
            Positioned(
              right: 24,
              bottom: 24,
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/0/04/Mastercard-logo.png',
                width: 48,
                height: 32,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastActivities() {
    final activities = [
      {
        'title': 'Netflix',
        'date': '15 Dec 2024',
        'amount': '\u000015,48',
        'icon': Icons.star_border,
      },
      {
        'title': 'Spotify',
        'date': '14 Dec 2024',
        'amount': '\u000019,90',
        'icon': Icons.star_border,
      },
      {
        'title': 'Netflix',
        'date': '12 Dec 2024',
        'amount': '\u000015,48',
        'icon': Icons.star_border,
      },
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Last activities',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Open all',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...activities.map((activity) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Icon(
                      activity['icon'] as IconData,
                      color: Colors.black54,
                    ),
                  ),
                  title: Text(
                    activity['title'] as String,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    activity['date'] as String,
                    style: const TextStyle(fontSize: 13, color: Colors.black45),
                  ),
                  trailing: Text(
                    '\u0000${activity['amount']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
} 