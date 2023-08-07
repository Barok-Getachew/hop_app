import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../providers/orders.dart' show orders;
import '../widgets/order_items.dart';

class ordersScreen extends StatefulWidget {
  static const String routename = 'order-screen';

  @override
  State<ordersScreen> createState() => _ordersScreenState();
}

class _ordersScreenState extends State<ordersScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<orders>(context, listen: false).fetchAndSetOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: appDrawer(),
        body: ListView.builder(
            itemCount: orderData.order.length,
            itemBuilder: ((context, index) =>
                ordersItem(order: orderData.order[index]))));
  }
}
