import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/auth/presentation/model/user.dart';
import 'package:foodies/canteen%20items/presentation/blocs/add_cart_bloc/add_cart_bloc.dart';
import 'package:foodies/canteen%20items/presentation/blocs/items_bloc/item_bloc.dart';
import 'package:foodies/cart/data/repository/cart_repo.dart';
import 'package:foodies/cart/presentation/screens/cart_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CanteenItems extends StatefulWidget {
  const CanteenItems({super.key, required this.title, required this.id});

  final String title;
  final String id;

  @override
  State<CanteenItems> createState() => _CanteenItemsState();
}

class _CanteenItemsState extends State<CanteenItems> {
  int _active = 0;
  @override
  Widget build(BuildContext context) {
    context.read<ItemBloc>().add(FetchItems(widget.id));
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CartPage()));
            },
          ),
        ],
      ),
      body: BlocListener<AddCartBloc, AddCartState>(
        listener: (context, state) {
          if (state is AddCartSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 1),
            ));
          } else if (state is AddCartFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 1),
            ));
          }
        },
        child: Padding(
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
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/burger.png',
                                height: 25,
                              ),
                              const Text(
                                'Burger',
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
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
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/burger.png',
                                height: 25,
                              ),
                              const Text(
                                'Burger',
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
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
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/burger.png',
                                height: 25,
                              ),
                              const Text(
                                'Burger',
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
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
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/burger.png',
                                height: 25,
                              ),
                              const Text(
                                'Burger',
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
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
                child: BlocBuilder<ItemBloc, ItemState>(
                  builder: (context, state) {
                    if (state is ItemInitial) {
                      return const Center(
                        child: Text('No Items Available'),
                      );
                    } else if (state is ItemLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ItemLoaded) {
                      return ListView.builder(
                        itemCount: state.itemList.length,
                        itemBuilder: (context, index) {
                          return ItemCard(
                            id: state.itemList[index].id,
                            title: state.itemList[index].name,
                            price: state.itemList[index].price,
                            imageUrl: state.itemList[index].photo,
                          );
                        },
                      );
                    } else if (state is ItemError) {
                      return const Center(
                        child: Text('Error'),
                      );
                    } else {
                      return const Center(
                        child: Text('Error'),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemCard extends StatefulWidget {
  const ItemCard({super.key, required this.title, required this.price, required this.imageUrl, required this.id});

  final String id;
  final String title;
  final String price;
  final String imageUrl;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.currency_rupee,
                            color: Colors.green,
                            size: 16,
                          ),
                          Text(widget.price, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  size: 15,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (quantity > 1) {
                                      quantity--;
                                    }
                                  });
                                },
                              ),
                              Text(
                                quantity.toString(),
                                style: const TextStyle(fontSize: 15),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  size: 15,
                                ),
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          SizedBox(
                            height: 30,
                            width: 80,
                            child: OutlinedButton(
                                onPressed: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  Users user = Users.fromJson(jsonDecode(prefs.getString('user')!));
                                  context.read<AddCartBloc>().add(
                                      AddToCartEvent(id: user.id, productId: widget.id, quantity: quantity.toString()));
                                },
                                child: const Text(
                                  'Add',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                )),
                          )
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
