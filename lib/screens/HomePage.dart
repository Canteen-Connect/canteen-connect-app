import 'package:flutter/material.dart';
import 'package:foodies/Resources/AuthMethod.dart';
import 'package:foodies/screens/LoginPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.search),
        title: const Text('Store'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      body: ListView(
        children: const <Widget>[
          StoreCard(storeName: 'USTORE', storeStatus: 'Your 2 - 13'),
          StoreCard(storeName: 'YOUTORE', storeStatus: '8 sore E: 32'),
          // Add more StoreCard widgets for additional stores
        ],
      ),
    );
  }
}

class StoreCard extends StatefulWidget {
  final String storeName;
  final String storeStatus;

  const StoreCard({required this.storeName, required this.storeStatus});

  @override
  State<StoreCard> createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(
              'assets/store_front.png'), // Replace with actual image path
          Text(widget.storeName),
          Text(widget.storeStatus),
          ElevatedButton(
            onPressed: () {
              // Add action for OPEN button
            },
            child: Text('OPEN'),
          ),
        ],
      ),
    );
  }
}
