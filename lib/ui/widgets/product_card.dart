import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Image.network(widget.product.image ?? '',
            width: 50, height: 50, fit: BoxFit.cover),
        title: Text(widget.product.title ?? 'No Title'),
        subtitle: Text("\$${widget.product.price ?? 0.0}"),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: Colors.amber),
            Text("${widget.product.rating?.rate ?? 0.0}"),
          ],
        ),
      ),
    );
  }
}
