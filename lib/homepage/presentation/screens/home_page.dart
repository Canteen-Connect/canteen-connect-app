import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:foodies/canteen%20list/presentation/screens/canteen_list.dart';
import 'package:foodies/auth/presentation/screens/login_page.dart';
import 'package:foodies/cart/presentation/screens/cart_page.dart';
import 'package:foodies/homepage/presentation/bloc/page_bloc.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CartPage()));
            },
          ),
        ],
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
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    ));
                  } else if (state is AuthSignOutSuccess) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage()));
                  }
                },
                child: ListTile(
                  title: Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          alignment: Alignment.centerLeft,
                          backgroundColor: WidgetStateProperty.all<Color>(Colors.orange),
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
            ),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          context.read<PageBloc>().add(PageChanged(page: value));
        },
        children: const [
          CanteenList(),
          Text('Orders'),
          Text('Feedback'),
          Text('Profile'),
        ],
      ),
      bottomNavigationBar: BlocBuilder<PageBloc, PageState>(
        builder: (context, state) {
          if (state is PageLoaded) {
            _page = state.page;
          }
          return CupertinoTabBar(
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
          );
        },
      ),
    );
  }
}
