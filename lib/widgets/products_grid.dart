import 'package:flutter/material.dart';
import '../providers/product_provider.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';

class products_grid extends StatelessWidget {
  final bool showFavs;
  products_grid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<products>(context);
    final product = showFavs ? productData.favoriteItems : productData.items;
    return GridView.builder(
        itemCount: product.length,
        padding: const EdgeInsets.all(10),
        // ignore: prefer_const_constructors
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: ((context, index) => ChangeNotifierProvider.value(
              value: product[index],
              child: ProductItem(
                  // product[index].id, product[index].title, product[index].imageUrl),
                  // )),
                  ),
            )));
  }
}
