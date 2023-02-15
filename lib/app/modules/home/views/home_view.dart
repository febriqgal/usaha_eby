import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:usaha_eby/app/modules/history/views/history_view.dart';
import 'package:usaha_eby/app/modules/home/views/home.dart';
import 'package:usaha_eby/app/modules/profile/views/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final user = FirebaseAuth.instance.currentUser;
  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    const Home(),
    const HistoryView(),
    const ProfileView(),
  ];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icon_home.png',
                width: 24,
              ),
              label: 'home'),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_order.png',
              width: 24,
            ),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_profile.png',
              width: 24,
            ),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
