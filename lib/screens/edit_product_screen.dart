import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});
  static const routeName = "/edit-product";
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.save))],
        title: const Text("Mahsulot qo'shish"),
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(decoration: InputDecoration(labelText: "Nomi")),
            ],
          ),
        ),
      ),
    );
  }
}
