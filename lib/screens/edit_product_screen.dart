import 'package:flutter/material.dart';
import 'package:food_menu/models/product.dart';
import 'package:food_menu/providers/products.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});
  static const routeName = "/edit-product";
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _form = GlobalKey<FormState>();
  final _imageForm = GlobalKey<FormState>();
  // final _priceFocus = FocusNode();
  var _product = Product(
    id: "",
    title: "",
    description: "",
    price: 0.0,
    imageUrl: "",
  );

  var _hasImage = true;
  var _init = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      final productId = ModalRoute.of(context)!.settings.arguments;
      print(productId);
      if (productId != null) {
        //.. mahsulotni eski ma'lumotini olish
        final _editingProduct = Provider.of<Products>(
          context,
        ).findById(productId as String);
        _product = _editingProduct;
        print(_product);
      }
    }
    _init = false;
  }

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Rasm URL-ni kiriting!"),
          content: Form(
            key: _imageForm,
            child: TextFormField(
              initialValue: _product.imageUrl,
              decoration: const InputDecoration(
                labelText: "Rasm URL",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Iltimos rasm URL kiriting.";
                } else if (!value.startsWith("http")) {
                  return "Iltimos, to'g'ri rasm URL kiriting.";
                }
                return null;
              },
              onSaved: (newValue) {
                _product = Product(
                  id: "",
                  title: _product.title,
                  description: _product.description,
                  price: _product.price,
                  imageUrl: newValue!,
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("BEKOR QILISH"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: _saveFormImage,
              child: const Text(
                "SAQLASH",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _saveFormImage() {
    final isValid = _imageForm.currentState!.validate();
    if (isValid) {
      _imageForm.currentState!.save();
      setState(() {
        _hasImage = true;
      });
      Navigator.of(context).pop();
    }
  }

  void _saveForm() {
    FocusScope.of(context).unfocus();
    final isValid = _form.currentState!.validate();
    setState(() {
      _hasImage = _product.imageUrl.isNotEmpty;
    });
    if (isValid && _hasImage) {
      _form.currentState!.save();
      Provider.of<Products>(context, listen: false).addProduct(_product);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save)),
        ],
        title: const Text("Mahsulot qo'shish"),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: _product.title,
                  decoration: InputDecoration(
                    labelText: "Nomi",
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  // onFieldSubmitted: (_) {
                  //   FocusScope.of(context).requestFocus(_priceFocus);
                  // },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Iltimos mahsulot nomini kiriting.";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _product = Product(
                      id: "",
                      title: newValue!,
                      description: _product.description,
                      price: _product.price,
                      imageUrl: _product.imageUrl,
                    );
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: _product.price.toStringAsFixed(2),
                  decoration: InputDecoration(
                    labelText: "Narxi",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  // focusNode: _priceFocus,
                  onSaved: (newValue) {
                    _product = Product(
                      id: "",
                      title: _product.title,
                      description: _product.description,
                      price: double.parse(newValue!),
                      imageUrl: _product.imageUrl,
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Iltimos mahsulot narxini kiriting.";
                    } else if (double.tryParse(value) == null) {
                      return "Iltimos, to'g'ri narx kiriting";
                    } else if (double.parse(value) < 1) {
                      return "Mahsulot narxi 0 dan katta bo'lishi kerak";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: _product.description,
                  decoration: InputDecoration(
                    labelText: "Qo'shimcha ma'lumot",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Iltimos mahsulot ta'rifini kiriting.";
                    } else if (value.length < 10) {
                      return "Iltimos, batafsil ma'lumot kiriting.";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _product = Product(
                      id: "",
                      title: _product.title,
                      description: newValue!,
                      price: _product.price,
                      imageUrl: _product.imageUrl,
                    );
                  },
                ),
                const SizedBox(height: 10),
                Card(
                  margin: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(
                      color: _hasImage ? Colors.grey : Colors.red,
                    ),
                  ),
                  child: InkWell(
                    onTap: () => _showImageDialog(context),
                    splashColor: Theme.of(context).primaryColor.withAlpha(70),
                    highlightColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      alignment: Alignment.center,
                      height: 180,
                      width: double.infinity,
                      child: _product.imageUrl.isEmpty
                          ? Text(
                              "Asosiy Rasm URLni kiriting",
                              style: TextStyle(
                                color: _hasImage ? Colors.black : Colors.red,
                              ),
                            )
                          : Image.network(
                              width: double.infinity,
                              _product.imageUrl,
                              fit: BoxFit.cover,
                            ),
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
