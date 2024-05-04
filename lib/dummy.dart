import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store Locator',
      home: StorePage(),
    );
  }
}

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: Text('Store'),
        actions: [Icon(Icons.menu)],
      ),
      body: ListView(
        children: <Widget>[
          StoreCard(storeName: 'USTORE', storeStatus: 'Your 2 - 13'),
          StoreCard(storeName: 'YOUTORE', storeStatus: '8 sore E: 32'),
          // Add more StoreCard widgets for additional stores
        ],
      ),
    );
  }
}

class StoreCard extends StatelessWidget {
  final String storeName;
  final String storeStatus;

  StoreCard({required this.storeName, required this.storeStatus});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(
              'assets/store_front.png'), // Replace with actual image path
          Text(storeName),
          Text(storeStatus),
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
