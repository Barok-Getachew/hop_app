import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Screens/edit_product_screen.dart';
import 'package:shop_app/providers/product_provider.dart';

class userProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String id;

  userProductItem(
      {required this.imageUrl, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              )),
          IconButton(
              onPressed: () async {
                try {
                  Provider.of<products>(context, listen: false)
                      .deleteProduct(id);
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('deleting failed!')));
                }
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              )),
        ]),
      ),
    );
  }
}
