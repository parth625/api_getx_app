import 'package:api_app/controllers/product_controller.dart';
import 'package:api_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  List<Product> products = [];
  bool isLoading = false;

  final productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await productController.fetchProducts();
      //   setState(() {
      //     isLoading = true;
      //   });
      //   products = await ApiServices().fetchProducts();
      //
      //   setState(() {
      //     isLoading = false;
      //   });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products List')),
      body: Obx(
        () => productController.isLoading
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                itemCount: productController.products.length,

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  Product product = productController.products[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0,
                            blurRadius: 10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Image.network(product.images[0]),
                          Text(
                            product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              Text('\$${product.price}'),
                              Text('⭐${product.rating}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
