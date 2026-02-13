import 'package:api_app/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            /// Update Only name - patch
            ElevatedButton(
              onPressed: () async {
                await productController.updateProductName(
                  'Updated product',
                  widget.product.id,
                );

                Get.back();

                Get.snackbar(
                  "Success",
                  "The product name updated",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text(
                'Update Product Name',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),

            /// Update whole product
            ElevatedButton(
              onPressed: () async {
                Product updatedProduct = Product(
                  id: widget.product.id,
                  title: 'Updated product',
                  description:
                      'This is the updated product added using post method',
                  category: 'updated product',
                  price: 23,
                  discountPercentage: 15,
                  rating: 2.5,
                  brand: 'updated brand',
                  weight: 20,
                  availabilityStatus: 'true',
                  returnPolicy: '10 days return',
                  images: [
                    'https://media.istockphoto.com/id/1476081293/photo/newsletter-blog-news-website-update-announcement.jpg?s=612x612&w=0&k=20&c=m0-4bOZBkj1c8IdDvHzyohdlEVhRahJgL5q8ayLITFs=',
                  ],
                  thumbnail: '',
                );

                await productController.updateProduct(
                  updatedProduct,
                  widget.product.id,
                );

                Get.back();

                Get.snackbar(
                  "Success",
                  "The product updated",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text(
                'Update Product',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                bool isDeleted = await productController.deleteProduct(
                  widget.product.id,
                );

                if (isDeleted) {
                  Get.back();
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'Delete Product',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
