import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../packages.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  const UserProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(EditProductScreen.routeName, arguments: product),
              icon: Icon(Icons.edit),
            ),
            IconButton(
              // FIXME: delete button doesn't work
              onPressed: () => Provider.of<Products>(context, listen: false)
                  .removeProduct(product.id),
              icon: Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
