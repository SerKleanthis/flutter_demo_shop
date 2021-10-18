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
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(EditProductScreen.routeName, arguments: product),
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              // FIXME: delete button doesn't work
              onPressed: () {
                Provider.of<Products>(context, listen: false)
                    .deleteProduct(product.id);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${product.title} deleted'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      // FIXME: doesn't work
                      Provider.of<Products>(context).restoreProduct(product.id);
                    },
                  ),
                ));
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
