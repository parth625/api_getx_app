import 'dart:developer';

import 'package:api_app/models/product.dart';
import 'package:api_app/services/api_services.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  final RxList<Product> _products = <Product>[].obs;
  final RxBool _isLoading = false.obs;

  List<Product> get products => _products;

  bool get isLoading => _isLoading.value;

  Future<void> fetchProducts() async {
    try{
      _isLoading.value = true;

      _products.value = await ApiServices().fetchProducts();

      _isLoading.value = false;

    } on DioException catch(e){
        log('Error: ${e.response?.statusMessage}');
    }
  }
}