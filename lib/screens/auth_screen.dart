import 'package:flutter/material.dart';
import 'package:food_menu/services/http_exception.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';

enum AuthMode { Register, Login }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const routeName = "/auth";

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  final _passwordController = TextEditingController();
  var _loading = false;
  Map<String, String> _authData = {'email': '', 'password': ''};

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      //save form
      _formKey.currentState!.save();

      setState(() {
        _loading = true;
      });
      try {
        if (_authMode == AuthMode.Login) {
          //.. login user
          await Provider.of<Auth>(
            context,
            listen: false,
          ).signIn(_authData['email']!, _authData['password']!);
        } else {
          //register user
          await Provider.of<Auth>(
            context,
            listen: false,
          ).signUp(_authData['email']!, _authData['password']!);
        }
      } on HttpException catch (error) {
        var errorMessage = "Xatolik sodir bo'ldi";
        print(error);
      } catch (e) {
        var errorMessage =
            "Kechirasiz xatolik sodir bo'ldi. Qaytadan o'rinib ko'ring";
      }
      setState(() {
        _loading = false;
      });
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Register;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('assets/images/logo.png', fit: BoxFit.cover),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Email manzil"),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return "Iltimos, email manzil kiriting!";
                    } else if (!email.contains('@')) {
                      return "Iltimos, to'g'ri email kiriting";
                    }
                  },
                  onSaved: (email) {
                    _authData['email'] = email!;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Parol"),
                  controller: _passwordController,
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return "Iltimos, to'g'ri parol kiriting";
                    } else if (password.length < 6) {
                      return "Parol juda oson";
                    }
                  },
                  onSaved: (password) {
                    _authData['password'] = password!;
                  },
                ),
                if (_authMode == AuthMode.Register)
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Parolni tasdiqlang",
                        ),
                        obscureText: true,
                        validator: (confirmedPassword) {
                          if (_passwordController.text != confirmedPassword) {
                            return "Parollar bir biriga mos kelmadi!";
                          }
                        },
                      ),
                    ],
                  ),
                const SizedBox(height: 60.0),
                _loading
                    ? const CircularProgressIndicator.adaptive()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.zero,
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: _submit,
                        child: Text(
                          _authMode == AuthMode.Login
                              ? "KIRISH"
                              : "RO'YXATDAN O'TISH",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(
                    _authMode == AuthMode.Login
                        ? "Ro'yxatdan o'tish"
                        : "Kirish",
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
