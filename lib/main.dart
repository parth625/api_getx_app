import 'package:api_app/pages/files/image_pick_page.dart';
import 'package:api_app/pages/login_page.dart';
import 'package:api_app/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'API App',
      debugShowCheckedModeBanner: false,
      home: StorageServices.isLoggedIn() ? ImagePickPage() : LoginPage(),
    );
  }
}
