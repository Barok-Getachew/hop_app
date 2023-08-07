import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import '../providers/cart.dart';
import '../widgets/cart_items.dart' as ci;

class cartScreen extends StatelessWidget {
  static const String routename = 'card-screen';

  @override
  Widget build(BuildContext context) {
    final cartTotal = Provider.of<cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text('your cart')),
      body: Column(children: [
        Card(
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(
                      '\$${cartTotal.totalAmount.toString()}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                      onPressed: () {
                        Provider.of<orders>(context, listen: false).addOrder(
                          cartTotal.items.values.toList(),
                          cartTotal.totalAmount,
                        );
                        cartTotal.clear();
                      },
                      child: Text(
                        'ORDER NOW!',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ))
                ]),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: ListView.builder(
                itemCount: cartTotal.items.length,
                itemBuilder: (context, index) => ci.cartItems(
                      cartTotal.items.values.toList()[index].id,
                      cartTotal.items.values.toList()[index].price,
                      cartTotal.items.values.toList()[index].quantity,
                      cartTotal.items.values.toList()[index].title,
                      cartTotal.items.keys.toList()[index],
                    )))
      ]),
    );
  }
}
