import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../noti_service.dart';
import 'package:http/http.dart' as http;
import '../services/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _list = [
    // Product(
    //   id: 'p1',
    //   title: 'Macbook Pro',
    //   description:
    //       """MacBook Pro Apple kompaniyasining professional darajadagi noutbuklar seriyasi bo'lib, asosan kreativ mutaxassislar (dizaynerlar, videomontajchilar, dasturchilar, musiqachilar), olimlar va kuchli hisoblash quvvatiga ehtiyoj duygan foydalanuvchilar uchun mo'ljallangan.MacBook Pro - bu eng yaxshi ishlash, ajoyib ekran va uzoq batareya muddatini talab qiladigan professional foydalanuvchilar uchun eng yaxshi tanlovdir. Agar siz oddiy ofis dasturlari, internet va filmlar uchun noutbuk qidirsangiz, MacBook Air yoki boshqa brendlarning noutbuklari yanada maqbul variant bo'lishi mumkin""",
    //   price: 3.99,
    //   imageUrl:
    //       'https://images.unsplash.com/photo-1592919933511-ea9d487c85e4?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Airpods',
    //   description:
    //       """AirPods - Apple kompaniyasining simsiz quloqchinlari boʻlib, iPhone, iPad va Mac
    //    bilan bevosita va beqiyos integratsiyasi bilan mashhur. AirPods (2-avlod va 3-avlod),Standart model: Eng oddiy va kop tarqalgan versiya.Dizayn: Klassik "oqsimon" shakl. 3-avlod AirPods Pro ga oxshash qisqaroq, ammo silikon uchlari yoʻq.Xususiyatlar: Avtomatik ulanish, quloqdan olganda pauza, ikki marta bosish orqali boshqarish. 3-avlodda Fazali
    //    Stereo va maksimum tebranishli siqish (EQ) mavjud.Batareya: Taxminan 5 soat tinglash, zaryadlash qutisi bilan umumiy 24 soat.""",
    //   price: 2.49,
    //   imageUrl:
    //       'https://images.unsplash.com/photo-1603351154351-5e2d0600bb77?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Iphone 17 Pro',
    //   description:
    //       """Chiqish sanasi: Taxminan 2025-yil sentyabr oyida Apple tadbirida e'lon qilinishi kutilmoqda.2. Dizayn va ekran: Material: Titandan yasalgan ramka (iPhone 15 Pro seriyasiga o'xshash).O'lcham: 6,1 dyuym va 6,7 dyuymli Pro modellari.Ekran texnologiyasi: ProMotion teknologiyali Super Retina XDR OLED displey.Yangi imkoniyat: Har doim yoqilgan displey (Always-On Display) yangilanishlari.""",
    //   price: 17000,
    //   imageUrl:
    //       'https://images.unsplash.com/photo-1759588073186-1d4ac7e33623?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    // ),
  ];
  String? _authToken;
  String? _userId;

  void setParams(String authToken, String userId) {
    _authToken = authToken;
    _userId = userId;
  }

  List<Product> get list {
    return [..._list];
  }

  List<Product> get favorites {
    return _list.where((product) => product.isFavorite).toList();
  }

  Future<void> getProductsFromFirebase() async {
    final url = Uri.parse(
      'https://fir-app-7c5b7-default-rtdb.firebaseio.com/products.json?auth=$_authToken&orderBy="creatorId"&equalTo="$_userId"',
    );
    try {
      final response = await http.get(url);
      if (jsonDecode(response.body) != null) {
        final favoriteUrl = Uri.parse(
          'https://fir-app-7c5b7-default-rtdb.firebaseio.com/userFavorites/$_userId.json?auth=$_authToken',
        );
        final favoriteResponse = await http.get(favoriteUrl);
        final favoriteData = jsonDecode(favoriteResponse.body);

        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List<Product> loadedProducts = [];
        data.forEach((productId, productData) {
          loadedProducts.add(
            Product(
              id: productId,
              title: productData['title'],
              description: productData['description'],
              price: productData['price'],
              imageUrl: productData['imageUrl'],
              isFavorite: favoriteData == null
                  ? false
                  : favoriteData[productId] ?? false,
            ),
          );
        });
        _list = loadedProducts;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
      "https://fir-app-7c5b7-default-rtdb.firebaseio.com/products.json?auth=$_authToken",
    );

    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'creatorId': _userId,
        }),
      );
      final name = (jsonDecode(response.body) as Map<String, dynamic>)['name'];
      final newProduct = Product(
        id: name,
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _list.add(newProduct);
      NotiService().showNotification(
        title: "YANGI MAHSULOT QO'SHILDI",
        body: "${product.title} nomli yangi maxsulot qo'shdingiz",
      );
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(Product updatedProduct) async {
    final productIndex = _list.indexWhere(
      (product) => product.id == updatedProduct.id,
    );
    if (productIndex >= 0) {
      final url = Uri.parse(
        "https://fir-app-7c5b7-default-rtdb.firebaseio.com/products/${updatedProduct.id}.json?auth=$_authToken",
      );
      try {
        await http.patch(
          url,
          body: jsonEncode({
            'title': updatedProduct.title,
            'description': updatedProduct.description,
            'price': updatedProduct.price,
            'imageUrl': updatedProduct.imageUrl,
          }),
        );
        _list[productIndex] = updatedProduct;
        notifyListeners();
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
      "https://fir-app-7c5b7-default-rtdb.firebaseio.com/products/$id.json?auth=$_authToken",
    );
    try {
      var deletingProduct = _list.firstWhere((product) => product.id == id);
      final productIndex = _list.indexWhere((product) => product.id == id);
      _list.removeWhere((product) => product.id == id);
      final response = await http.delete(url);
      notifyListeners();
      if (response.statusCode >= 400) {
        _list.insert(productIndex, deletingProduct);
        notifyListeners();
        throw HttpException("Kechirasiz, o'chirishda xatolik");
      }
    } catch (e) {
      rethrow;
    }
  }

  Product findById(String productId) {
    return _list.firstWhere((product) => product.id == productId);
  }
}
