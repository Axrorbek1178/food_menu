import 'package:flutter/material.dart';
import 'package:food_menu/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _list = [
    Product(
      id: 'p1',
      title: 'Macbook Pro',
      description: 'Macbook Pro 2026',
      price: 3.99,
      imageUrl:
          'https://images.unsplash.com/photo-1592919933511-ea9d487c85e4?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    Product(
      id: 'p2',
      title: 'Airpods',
      description: 'Apple Airpods',
      price: 2.49,
      imageUrl:
          'https://images.unsplash.com/photo-1603351154351-5e2d0600bb77?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    Product(
      id: 'p3',
      title: 'Iphone 17 Pro',
      description: 'Iphone 17 Pro',
      price: 17000,
      imageUrl:
          'https://images.unsplash.com/photo-1759588073186-1d4ac7e33623?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
  ];

  var _showOnlyFavorites = false;

  List<Product> get list {
    if (_showOnlyFavorites) {
      return _list.where((product) => product.isFavorite).toList();
    }
    return [..._list];
  }

  void showAll() {
    _showOnlyFavorites = false;
    notifyListeners();
  }

  void showFavorites() {
    _showOnlyFavorites = true;
    notifyListeners();
  }

  void addProduct() {
    notifyListeners();
  }

  Product findById(String productId) {
    return _list.firstWhere((product) => product.id == productId);
  }
}
