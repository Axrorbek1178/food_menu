import 'package:flutter/material.dart';

enum AuthMode {}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const routeName = "/auth";

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void switchAuthMode() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Form(
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Image.asset('assets/images/logo.png', fit: BoxFit.cover),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Email manzil"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Parol"),
                ),
                const SizedBox(height: 60.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.zero,
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "KIRISH",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Ro'yxatdan o'tish",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
