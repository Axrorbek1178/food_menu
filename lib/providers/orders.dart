// import 'dart:convert';

// import 'package:flutter/material.dart';
// import '../models/cart_item.dart';
// import '../models/order.dart';
// import 'package:http/http.dart' as http;

// class Orders with ChangeNotifier {
//   List<Order> _items = [];

//   List<Order> get items {
//     return [..._items];
//   }

//   Future<void> getOrdersFromFirebase() async {
//     final url = Uri.parse(
//       "https://fir-app-7c5b7-default-rtdb.firebaseio.com/orders.json",
//     );
//     try {
//       final response = await http.get(url);
//       if (jsonDecode(response.body) == null) {
//         return;
//       }
//       final data = jsonDecode(response.body) as Map<String, dynamic>;
//       List<Order> loadedOrders = [];
//       data.forEach((orderId, order) {
//         loadedOrders.insert(
//           0,
//           Order(
//             id: orderId,
//             totalPrice: order['totalPrice'],
//             date: DateTime.parse(order['date']),
//             products: (order['products'] as List<dynamic>)
//                 .map(
//                   (product) => CartItem(
//                     id: product['id'],
//                     title: product['title'],
//                     quantity: product['quantity'],
//                     price: product['price'],
//                     image: product['image'],
//                   ),
//                 )
//                 .toList(),
//           ),
//         );
//       });
//       _items = loadedOrders;
//       notifyListeners();
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> addToOrder(List<CartItem> products, double totalPrice) async {
//     final url = Uri.parse(
//       "https://fir-app-7c5b7-default-rtdb.firebaseio.com/orders.json",
//     );
//     try {
//       final response = await http.post(
//         url,
//         body: jsonEncode({
//           'totalPrice': totalPrice,
//           'date': DateTime.now().toIso8601String(),
//           'products': products
//               .map(
//                 (product) => {
//                   'id': product.id,
//                   'title': product.title,
//                   'quantity': product.quantity,
//                   'price': product.price,
//                   'image': product.image,
//                 },
//               )
//               .toList(),
//         }),
//       );
//       _items.insert(
//         0,
//         Order(
//           id: jsonDecode(response.body)['name'],
//           totalPrice: totalPrice,
//           date: DateTime.now(),
//           products: products,
//         ),
//       );
//       notifyListeners();
//     } catch (e) {
//       rethrow;
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/order.dart';
import 'package:http/http.dart' as http;

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  Future<void> getOrdersFromFirebase() async {
    final url = Uri.parse(
      "https://fir-app-7c5b7-default-rtdb.firebaseio.com/orders.json",
    );
    try {
      final response = await http.get(url);

      // **1. Response body bo'sh bo'lishi mumkinligini tekshirish**
      if (response.body == null || response.body.isEmpty) {
        _items = [];
        notifyListeners();
        return;
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      // **2. Data bo'sh yoki null bo'lishi mumkin**
      if (data.isEmpty) {
        _items = [];
        notifyListeners();
        return;
      }

      List<Order> loadedOrders = [];

      data.forEach((orderId, order) {
        // **3. Har bir order null bo'lishi mumkin**
        if (order == null) return;

        // **4. Products maydoni null yoki bo'sh bo'lishi mumkin**
        List<dynamic> productsData = [];

        if (order['products'] != null && order['products'] is List) {
          productsData = order['products'] as List<dynamic>;
        }

        loadedOrders.insert(
          0,
          Order(
            id: orderId,
            totalPrice: order['totalPrice']?.toDouble() ?? 0.0,
            date: DateTime.tryParse(order['date'] ?? '') ?? DateTime.now(),
            products: productsData
                .map(
                  (product) => CartItem(
                    id: product['id'] ?? '',
                    title: product['title'] ?? '',
                    quantity: product['quantity']?.toInt() ?? 0,
                    price: product['price']?.toDouble() ?? 0.0,
                    image: product['image'] ?? '',
                  ),
                )
                .toList(),
          ),
        );
      });

      _items = loadedOrders;
      notifyListeners();
    } catch (e) {
      print('Error fetching orders: $e');
      // Re-throw o'rniga bo'sh list qaytaring yoki xatoni hal qiling
      _items = [];
      notifyListeners();
      // Agar siz xatoni yuqoriga o'tkazmoqchi bo'lsangiz:
      // rethrow;
    }
  }

  Future<void> addToOrder(List<CartItem> products, double totalPrice) async {
    final url = Uri.parse(
      "https://fir-app-7c5b7-default-rtdb.firebaseio.com/orders.json",
    );
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'totalPrice': totalPrice,
          'date': DateTime.now().toIso8601String(),
          'products': products
              .map(
                (product) => {
                  'id': product.id,
                  'title': product.title,
                  'quantity': product.quantity,
                  'price': product.price,
                  'image': product.image,
                },
              )
              .toList(),
        }),
      );

      final responseData = jsonDecode(response.body);

      _items.insert(
        0,
        Order(
          id:
              responseData['name'] ??
              DateTime.now().millisecondsSinceEpoch.toString(),
          totalPrice: totalPrice,
          date: DateTime.now(),
          products: products,
        ),
      );
      notifyListeners();
    } catch (e) {
      print('Error adding order: $e');
      rethrow;
    }
  }
}
