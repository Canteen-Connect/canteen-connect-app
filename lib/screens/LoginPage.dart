import 'package:flutter/material.dart';
import 'package:foodies/screens/SignUp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 250,
              width: 410,
              child: Image.asset(
                fit: BoxFit.cover,
                "assets/foodies_signin.png",
              ),
            ),
            const SizedBox(height: 50),
            const Text('Sign In',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                obscureText: hidePassword,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(hidePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    )),
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
                    'Sign In',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 255, 199, 59),
                  ),
                  child: const Text('Sign Up'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
