import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Screens/orders_screen.dart';
import 'package:shop_app/Screens/products_overview_screen.dart';
import 'package:shop_app/Screens/user_products_screen.dart';
import 'package:shop_app/providers/auth.dart';

class appDrawer extends StatelessWidget {
  const appDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(title: Text('Hello Friend!'), automaticallyImplyLeading: false),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('orders'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(ordersScreen.routename);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('shop'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        ListTile(
          leading: Icon(Icons.edit_outlined),
          title: Text('Manage product'),
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed(userproductScreen.routename);
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () {
            Navigator.of(context).pop();
            //     .pushReplacementNamed(userproductScreen.routename);
            Provider.of<Auth>(context, listen: false).logOut();
          },
        ),
      ]),
    );
  }
}
