import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Screens/auth_screen.dart';
import 'package:shop_app/Screens/cart_screen.dart';
import 'package:shop_app/Screens/edit_product_screen.dart';
import 'package:shop_app/Screens/orders_screen.dart';
import 'package:shop_app/Screens/product_detail_screen.dart';
import 'package:shop_app/Screens/user_products_screen.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import './Screens/products_overview_screen.dart';
import './providers/product_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => Auth())),
        ChangeNotifierProxyProvider<Auth, products>(
          create: (context) => products('', '', []),
          update: ((context, auth, previous) =>
              products(auth.token, auth.userId, previous!.items)),
        ),
        ChangeNotifierProvider(create: ((context) => cart())),
        ChangeNotifierProxyProvider<Auth, orders>(
          create: (context) => orders('', []),
          update: ((context, auth, previous) =>
              orders(auth.token, previous!.order)),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            // ignore: deprecated_member_use
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          initialRoute: '/auth',
          routes: {
            AuthScreen.routeName: ((context) => AuthScreen()),
            ProductOverview.routename: ((context) => ProductOverview()),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            cartScreen.routename: (context) => cartScreen(),
            ordersScreen.routename: (context) => ordersScreen(),
            userproductScreen.routename: (context) => userproductScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
