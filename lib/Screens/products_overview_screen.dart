import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import '../widgets/app_drawer.dart';
import '../Screens/cart_screen.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';

enum filterOptions { favorite, All }

// ignore: use_key_in_widget_constructors
class ProductOverview extends StatefulWidget {
  static const String routename = '/';
  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  bool _showOnlyfavorite = false;
  var _isInt = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInt) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<products>(context).fetchAndSetProducts().then((_) {
        _isLoading = false;
      });
    }
    _isInt = false;
    super.didChangeDependencies();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final Cart = Provider.of<cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('MyShop'), actions: [
        PopupMenuButton(
            onSelected: (filterOptions selectedValue) {
              setState(() {
                if (selectedValue == filterOptions.favorite) {
                  _showOnlyfavorite = true;
                } else {
                  _showOnlyfavorite = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
                  PopupMenuItem(
                    value: filterOptions.favorite,
                    child: Text('onlyFavorite'),
                  ),
                  PopupMenuItem(
                    value: filterOptions.All,
                    child: Text('more'),
                  ),
                ]),
        Badge(
          value: Cart.itemCount.toString(),
          child: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, cartScreen.routename);
            },
          ),
        ),
      ]),
      drawer: appDrawer(),
      body: _isLoading
          ? Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1),
                duration: const Duration(microseconds: 3500),
                builder: (context, value, _) => CircularProgressIndicator(
                  value: value,
                ),
              ),
            )
          : products_grid(_showOnlyfavorite),
    );
  }
}
