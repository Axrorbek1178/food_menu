import 'package:flutter/material.dart';
import 'package:food_menu/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _list = [
    Product(
      id: 'p1',
      title: 'Macbook Pro',
      description:
          """MacBook Pro Apple kompaniyasining professional darajadagi noutbuklar seriyasi bo'lib, asosan kreativ mutaxassislar (dizaynerlar, videomontajchilar, dasturchilar, musiqachilar), olimlar va kuchli hisoblash quvvatiga ehtiyoj duygan foydalanuvchilar uchun mo'ljallangan.MacBook Pro - bu eng yaxshi ishlash, ajoyib ekran va uzoq batareya muddatini talab qiladigan professional foydalanuvchilar uchun eng yaxshi tanlovdir. Agar siz oddiy ofis dasturlari, internet va filmlar uchun noutbuk qidirsangiz, MacBook Air yoki boshqa brendlarning noutbuklari yanada maqbul variant bo'lishi mumkin""",
      price: 3.99,
      imageUrl:
          'https://images.unsplash.com/photo-1592919933511-ea9d487c85e4?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    Product(
      id: 'p2',
      title: 'Airpods',
      description:
          """AirPods - Apple kompaniyasining simsiz quloqchinlari boʻlib, iPhone, iPad va Mac
       bilan bevosita va beqiyos integratsiyasi bilan mashhur. AirPods (2-avlod va 3-avlod),Standart model: Eng oddiy va kop tarqalgan versiya.Dizayn: Klassik "oqsimon" shakl. 3-avlod AirPods Pro ga oxshash qisqaroq, ammo silikon uchlari yoʻq.Xususiyatlar: Avtomatik ulanish, quloqdan olganda pauza, ikki marta bosish orqali boshqarish. 3-avlodda Fazali 
       Stereo va maksimum tebranishli siqish (EQ) mavjud.Batareya: Taxminan 5 soat tinglash, zaryadlash qutisi bilan umumiy 24 soat.""",
      price: 2.49,
      imageUrl:
          'https://images.unsplash.com/photo-1603351154351-5e2d0600bb77?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    Product(
      id: 'p3',
      title: 'Iphone 17 Pro',
      description:
          """Chiqish sanasi: Taxminan 2025-yil sentyabr oyida Apple tadbirida e'lon qilinishi kutilmoqda.2. Dizayn va ekran: Material: Titandan yasalgan ramka (iPhone 15 Pro seriyasiga o'xshash).O'lcham: 6,1 dyuym va 6,7 dyuymli Pro modellari.Ekran texnologiyasi: ProMotion teknologiyali Super Retina XDR OLED displey.Yangi imkoniyat: Har doim yoqilgan displey (Always-On Display) yangilanishlari.""",
      price: 17000,
      imageUrl:
          'https://images.unsplash.com/photo-1759588073186-1d4ac7e33623?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
  ];

  List<Product> get list {
    return [..._list];
  }

  List<Product> get favorites {
    return _list.where((product) => product.isFavorite).toList();
  }

  void addProduct() {
    //_list.add(value);
    notifyListeners();
  }

  Product findById(String productId) {
    return _list.firstWhere((product) => product.id == productId);
  }
}
