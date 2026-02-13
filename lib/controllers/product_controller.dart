import 'dart:developer';

import 'package:api_app/models/product.dart';
import 'package:api_app/services/api_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final RxList<Product> _products = <Product>[].obs;
  final RxBool _isLoading = false.obs;

  List<Product> get products => _products;

  bool get isLoading => _isLoading.value;

  Future<void> fetchProducts() async {
    try {
      _isLoading.value = true;

      _products.value = await ApiServices().fetchProducts();

      _isLoading.value = false;
    } on DioException catch (e) {
      log('Error: ${e.response?.statusMessage}');
    }
  }

  /// Add a product
  Future<void> addProduct(Product prd) async {
    try {
      _isLoading.value = true;

      Product data = await ApiServices().addProduct(prd);

      _products.insert(0, prd);

      Get.snackbar(
        "Success",
        "The product ${data.title} added",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
      );

      _isLoading.value = false;
    } on DioException catch (e) {
      log('Error: ${e.message}');
    }
  }

  /// Update product's name
  Future<void> updateProductName(String title, int id) async {
    try {

      Product updatedProduct = await ApiServices().updateProductName(title, id);

      int index = _products.indexWhere((item) => item.id == updatedProduct.id);

      // log('Index: $index');
      if (index != -1) {
        _products[index] = updatedProduct;
      }
    } on DioException catch (e) {
      log('Error Updating: ${e.message}');
    }
  }

  /// Update whole product
  Future<void> updateProduct(Product updatedProduct, int id) async {
    try {

      Product updated = await ApiServices().updateProduct(updatedProduct, id);

      int index = _products.indexWhere((p) => p.id == updatedProduct.id);

      log("$index, ${updatedProduct.id}");

      if (index != -1) {
        _products[index] = updatedProduct;
      }
    } on DioException catch (e) {
      log('Error updating: ${e.message}');
    }
  }

  /// Delete a product
  Future<bool> deleteProduct(int id) async{
    try{
      bool isDeleted = await ApiServices().deleteProduct(id);

      if(isDeleted){
        int index = _products.indexWhere((p) => p.id == id);

        log('Index: $index');
        if(index != -1){
          _products.removeAt(index);
        }

        return true;
      }
    }on DioException catch(e){
      log('Error deleting: ${e.message}');
    }
    return false;
  }
}
