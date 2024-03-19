import 'package:flutter/material.dart';
import 'package:foodies/screens/LoginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool hidePassword = true;
  bool hideRePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Enter Your Details Here',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      floatingLabelBehavior: FloatingLabelBehavior.always),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      floatingLabelBehavior: FloatingLabelBehavior.always),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone No.',
                      floatingLabelBehavior: FloatingLabelBehavior.always),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(hidePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                    obscureText: hideRePassword,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Re-enter Password',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hideRePassword = !hideRePassword;
                            });
                          },
                          icon: Icon(hideRePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                        ))),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("By signing up you accept our "),
                  InkWell(
                    onTap: () {
                      // Handle terms of use tap
                    },
                    child: const Text(
                      "terms of use",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 199, 59),
                      ),
                    ),
                  ),
                  const Text(" and "),
                ],
              ),
              InkWell(
                onTap: () {
                  // Handle privacy policy tap
                },
                child: const Text(
                  "privacy policy",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 199, 59),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 199, 59),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 255, 199, 59),
                    ),
                    child: const Text('Sign In'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
