import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/account/presentation/screens/account_page.dart';
import 'package:foodies/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:foodies/canteen%20list/presentation/screens/canteen_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  PageController pageController = PageController();

  void logout() async {
    context.read<AuthBloc>().add(LogOut());
  }

  void navigationTapped(int value) {
    setState(() {
      _page = value;
    });
    pageController.jumpToPage(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          // context.read<PageBloc>().add(PageChanged(page: value));
          setState(() {
            _page = value;
          });
        },
        children: const [
          CanteenList(),
          Text('Orders'),
          Text('Feedback'),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        height: 70,
        iconSize: 30,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_pin),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        activeColor: Colors.orange,
        currentIndex: _page,
        onTap: (value) => navigationTapped(value),
      ),
    );
  }
}
