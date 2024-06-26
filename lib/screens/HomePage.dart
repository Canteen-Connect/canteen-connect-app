import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodies/Resources/AuthMethod.dart';
import 'package:foodies/screens/CanteenList.dart';
import 'package:foodies/screens/LoginPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  PageController pageController = PageController();

  void logout() async {
    String res = await AuthMethods().logoutUser();
    if (res != 'success') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User logged out successfully!')));
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()));
    }
    print('Logout button pressed');
  }

  void navigationTapped(int value) {
    pageController.jumpToPage(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.white),
                    accountName: Text(
                      'Farion Wick',
                      style: TextStyle(color: Colors.black),
                    ),
                    accountEmail: Text(
                      'farionwick@gmail.com',
                      style: TextStyle(color: Colors.black),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(Icons.person_2_rounded),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.text_snippet_rounded),
                    title: const Text('My Orders'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('My Profile'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.payment),
                    title: const Text('Payment Methods'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.contact_support),
                    title: const Text('Contact Us'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('Helps & FAQs'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                title: Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        alignment: Alignment.centerLeft,
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.orange),
                      ),
                      onPressed: logout,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.logout),
                          SizedBox(width: 8),
                          Text('Logout'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          setState(() {
            _page = value;
          });
        },
        children: const [
          CanteenList(),
          Text('Orders'),
          Text('Cart'),
          Text('Feedback'),
          Text('Notifications'),
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
            icon: Icon(Icons.shopping_bag),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
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
