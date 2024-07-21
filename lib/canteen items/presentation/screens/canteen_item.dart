import 'package:flutter/material.dart';

class CanteenItems extends StatefulWidget {
  const CanteenItems({super.key, required this.title});

  final String title;

  @override
  State<CanteenItems> createState() => _CanteenItemsState();
}

class _CanteenItemsState extends State<CanteenItems> {
  int _active = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag),
            onPressed: () {
              print('Cart button pressed');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if (_active == 1) {
                        setState(() {
                          _active = 0;
                        });
                      } else {
                        setState(() {
                          _active = 1;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(12),
                        color: _active == 1 ? Colors.red : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/burger.png',
                              height: 25,
                            ),
                            const Text(
                              'Burger',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_active == 2) {
                        setState(() {
                          _active = 0;
                        });
                      } else {
                        setState(() {
                          _active = 2;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(12),
                        color: _active == 2 ? Colors.red : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/burger.png',
                              height: 25,
                            ),
                            const Text(
                              'Burger',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_active == 3) {
                        setState(() {
                          _active = 0;
                        });
                      } else {
                        setState(() {
                          _active = 3;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(12),
                        color: _active == 3 ? Colors.red : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/burger.png',
                              height: 25,
                            ),
                            const Text(
                              'Burger',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_active == 4) {
                        setState(() {
                          _active = 0;
                        });
                      } else {
                        setState(() {
                          _active = 4;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(12),
                        color: _active == 4 ? Colors.red : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/burger.png',
                              height: 25,
                            ),
                            const Text(
                              'Burger',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: const <Widget>[
                  ItemCard(
                      title: 'Chai + Bun Maska',
                      likes: 100,
                      price: 30,
                      imageUrl: 'assets/chai.jpg'),
                  ItemCard(
                      title: 'Chai + Bun Maska',
                      likes: 100,
                      price: 30,
                      imageUrl: 'assets/chai.jpg'),
                  ItemCard(
                      title: 'Chai + Bun Maska',
                      likes: 100,
                      price: 30,
                      imageUrl: 'assets/chai.jpg'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard(
      {super.key,
      required this.title,
      required this.likes,
      required this.price,
      required this.imageUrl});

  final String title;
  final int likes;
  final double price;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          print('$title pressed');
        },
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.fill,
                    width: 100,
                    height: 90,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          Text(likes.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.currency_rupee,
                            color: Colors.green,
                          ),
                          Text(price.toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
