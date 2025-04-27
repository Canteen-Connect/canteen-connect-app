import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:foodies/checkout/presentation/screens/summary_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    context.read<CartBloc>().add(GetCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CartLoaded) {
                  return ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = state.cartItems[index];
                      return ItemCard(
                        id: item.id,
                        title: item.name,
                        price: item.price,
                        imageUrl: item.photo,
                        quantity: item.quantity,
                      );
                    },
                  );
                } else if (state is CartError) {
                  return Center(child: Text('${state.message} Error'));
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          const Icon(
                            Icons.currency_rupee,
                            color: Colors.green,
                          ),
                          Text(state.totalPrice.toString(),
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SummaryPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 199, 59),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Proceed to Checkout',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

class ItemCard extends StatefulWidget {
  ItemCard(
      {super.key,
      required this.title,
      required this.price,
      required this.imageUrl,
      required this.id,
      required this.quantity});

  final String id;
  final String title;
  final String price;
  final String imageUrl;
  final String quantity;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
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
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.currency_rupee,
                          color: Colors.green,
                        ),
                        Text(widget.price.toString(),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.remove,
                                size: 12,
                              ),
                              onPressed: () {
                                int q = int.parse(widget.quantity);
                                if (q > 1) {
                                  q--;
                                }
                                context.read<CartBloc>().add(UpdateCart(widget.id, q.toString()));
                              },
                            ),
                            Text(
                              widget.quantity,
                              style: const TextStyle(fontSize: 15),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.add,
                                size: 12,
                              ),
                              onPressed: () {
                                int q = int.parse(widget.quantity);
                                q++;
                                context.read<CartBloc>().add(UpdateCart(widget.id, q.toString()));
                              },
                            ),
                          ],
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        IconButton(
                            onPressed: () {
                              context.read<CartBloc>().add(DeleteProduct(widget.id));
                            },
                            icon: const Icon(Icons.delete),
                            color: Colors.red),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
