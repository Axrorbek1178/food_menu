import 'package:flutter/material.dart';
import 'package:food_menu/providers/networ_provider.dart';
import 'package:provider/provider.dart';

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 100, color: Colors.red),
              SizedBox(height: 30),
              Text(
                'Internet aloqasi yo\'q',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Internetingizni tekshiring va qayta urinib ko\'ring',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  final networkProvider = Provider.of<NetworkProvider>(
                    context,
                    listen: false,
                  );

                  bool connected = await networkProvider.checkConnection();

                  if (!connected) {
                    // Internet hali yo'q bo'lsa
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Internet hali mavjud emas'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  // Agar internet bo'lsa, avtomatik HomeScreen ga o'tadi
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.refresh, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Qayta urinish',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Offline rejimda ishlash (agar caching qilgan bo'lsangiz)
                  // Yoki Settings ga o'tish
                },
                child: Text(
                  'Offline rejimda davom etish',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
