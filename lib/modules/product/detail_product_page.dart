import 'package:flutter/material.dart';

import '../home/models/product_model.dart';

class DetailProductPage extends StatelessWidget {
  final Product product;
  const DetailProductPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? ""),
      ),
      body: Container(
        margin: EdgeInsets.all(
          20,
        ),
        padding: EdgeInsets.all(
          14,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 3,
                color: Colors.black.withOpacity(0.08))
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.maxFinite,
                height: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.image ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                product.title ?? "",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Rating ${product.rating?.rate ?? "-"}/${product.rating?.count ?? "-"}",
                style: TextStyle(color: Colors.orange),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Category : ${product.category ?? "-"}",
                style: TextStyle(color: Colors.grey[400]),
              ),
              SizedBox(
                height: 14,
              ),
              Text("Description"),
              SizedBox(
                height: 5,
              ),
              Text(
                product.description ?? "-",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
