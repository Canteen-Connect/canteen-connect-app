import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:foodies/auth/presentation/bloc/password/password_bloc.dart';
import 'package:foodies/auth/presentation/screens/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  void signupUser() async {
    context.read<AuthBloc>().add(SignUpWithEmailAndPassword(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          address: _addressController.text.trim(),
          password: _passwordController.text.trim(),
        ));
  }

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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Enter Your Details Here',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      floatingLabelBehavior: FloatingLabelBehavior.always),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      floatingLabelBehavior: FloatingLabelBehavior.always),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone No.',
                      floatingLabelBehavior: FloatingLabelBehavior.always),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                      floatingLabelBehavior: FloatingLabelBehavior.always),
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<PasswordBloc, PasswordState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: state.hideSignupPassword,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Password',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: IconButton(
                          onPressed: () {
                            context
                                .read<PasswordBloc>()
                                .add(ToggleSignupPasswordVisibility());
                          },
                          icon: Icon(state.hideSignupPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<PasswordBloc, PasswordState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                        controller: _rePasswordController,
                        obscureText: state.hideConfirmPassword,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Re-enter Password',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: IconButton(
                              onPressed: () {
                                context
                                    .read<PasswordBloc>()
                                    .add(ToggleConfirmPasswordVisibility());
                              },
                              icon: Icon(state.hideConfirmPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                            ))),
                  );
                },
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
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    ));
                  } else if (state is AuthSignUpSuccess) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 70,
                      child: ElevatedButton(
                        onPressed: signupUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 199, 59),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: (state is AuthLoading)
                            ? const CircularProgressIndicator(
                                color: Color.fromARGB(255, 255, 255, 255),
                              )
                            : const Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginPage()));
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
