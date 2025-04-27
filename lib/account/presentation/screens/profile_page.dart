import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodies/auth/presentation/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  bool _isEditing = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final String _countryCode = "+91";

  @override
  void initState() {
    _fetchProfileData();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _fetchProfileData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Users user = Users.fromJson(jsonDecode(prefs.getString('user')!));
      setState(() {
        _nameController.text = user.name;
        _emailController.text = user.email;
        _phoneController.text = user.contact;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch profile data')),
      );
    }
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController currentPassController = TextEditingController();
        TextEditingController newPassController = TextEditingController();
        TextEditingController confirmPassController = TextEditingController();

        return AlertDialog(
          title: const Text('Change Password'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: currentPassController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: newPassController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: confirmPassController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Implement password change logic
                if (newPassController.text == confirmPassController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password changed successfully')),
                  );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Passwords do not match')),
                  );
                }
              },
              child: const Text('Change Password', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_isEditing) {
                // Save logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile updated successfully')),
                );
              }
              _toggleEditMode();
            },
            child: Text(
              _isEditing ? 'Save' : 'Edit',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email field (non-editable)
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                style: const TextStyle(color: Colors.black, fontSize: 20),
                controller: _emailController,
                enabled: false,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.black, fontSize: 15),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  prefixIcon: Icon(Icons.email_outlined, color: Colors.black),
                  labelText: 'Email ID',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),

            // Phone Code and Number (non-editable)
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                style: const TextStyle(color: Colors.black, fontSize: 20),
                controller: _phoneController,
                enabled: false,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.black, fontSize: 15),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  prefixIcon: Icon(Icons.phone, color: Colors.black),
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),

            // Name field - single field instead of first and last name
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                style: const TextStyle(color: Colors.black, fontSize: 20),
                controller: _nameController,
                enabled: _isEditing,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.black, fontSize: 15),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),

            // Change Password (replacing Delete Account)
            Center(
              child: TextButton(
                onPressed: _showChangePasswordDialog,
                child: const Text(
                  'Change Password',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
