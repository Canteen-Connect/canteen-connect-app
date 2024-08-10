import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/canteen%20items/presentation/screens/canteen_item.dart';
import 'package:foodies/canteen%20list/presentation/bloc/canteen_bloc.dart';

class CanteenList extends StatelessWidget {
  const CanteenList({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CanteenBloc>().add(FetchCanteenList());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 8, right: 50),
          child: const Text(
            'From where would you like to order?',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(8),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: BlocBuilder<CanteenBloc, CanteenState>(
            builder: (context, state) {
              if (state is CanteenLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CanteenLoaded) {
                return ListView.builder(
                  itemCount: state.canteenList.length,
                  itemBuilder: (context, index) {
                    return FoodCard(
                      title: state.canteenList[index].name,
                      subtitle: state.canteenList[index].description,
                      operatingHours: '9:00 AM - 9:00 PM',
                      imageUrl: 'assets/canteen-pic.jpg',
                    );
                  },
                );
              } else if (state is CanteenError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Center(
                  child: Text('No data found'),
                );
              }
            },
          ),
        )
      ],
    );
  }
}

class FoodCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String operatingHours;
  final String imageUrl;

  const FoodCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.operatingHours,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CanteenItems(
                  title: title,
                )));
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
                  width: 150,
                  height: 100,
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
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      operatingHours,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
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
