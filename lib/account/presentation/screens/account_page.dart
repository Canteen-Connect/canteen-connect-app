import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/account/presentation/screens/profile_page.dart';
import 'package:foodies/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:foodies/auth/presentation/screens/login_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Accounts',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
          child: Column(
            children: [
              _buildAccountMenuItems(context),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'All Rights Reserved.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.amber,
                      size: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Version 1.00',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountMenuItems(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.local_offer, 'title': 'Offers & Discounts'},
      {'icon': Icons.person_outline, 'title': 'My Profile'},
      {'icon': Icons.notifications_none, 'title': 'Notifications'},
      {'icon': Icons.history, 'title': 'Order History'},
      {'icon': Icons.loop, 'title': 'Refund Status'},
      {'icon': Icons.headset_mic_outlined, 'title': 'Support'},
      {'icon': Icons.logout, 'title': 'Logout'},
    ];

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: menuItems.length,
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        indent: 16,
        endIndent: 16,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // Provide visual feedback when tapped
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${menuItems[index]['title']} clicked'),
                duration: const Duration(milliseconds: 800),
              ),
            );

            // You can navigate to different screens based on the menu item
            if (menuItems[index]['title'] == 'Logout') {
              BlocProvider.of<AuthBloc>(context).add(LogOut());
            }
            if (menuItems[index]['title'] == 'My Profile') {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyProfilePage()));
            }
            // Add more conditions for other menu items
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(
                menuItems[index]['icon'],
                color: Colors.black54,
                size: 30,
              ),
              title: Text(
                menuItems[index]['title'],
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.grey,
                size: 24,
              ),
            ),
          ),
        );
      },
    );
  }
}
