import 'package:flutter/material.dart';
import 'package:shop_app/Screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';
import '../providers/product_provider.dart';
import 'package:provider/provider.dart';

class userproductScreen extends StatelessWidget {
  static const String routename = 'user-Product';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<products>(context);
    return Scaffold(
      appBar: AppBar(
        title: (Text('Your Products')),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: 'new');
              },
              icon: Icon(Icons.add))
        ],
      ),
      drawer: appDrawer(),
      body: RefreshIndicator(
        onRefresh: (() => _refreshProducts(context)),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: ((context, index) => Column(
                  children: [
                    userProductItem(
                      id: productData.items[index].id,
                      imageUrl: productData.items[index].imageUrl,
                      title: productData.items[index].title,
                    ),
                    Divider(),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
