import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../packages.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  const UserProductItem(this.product);

  void deleteProduct(BuildContext context) async {
    try {
      await Provider.of<Products>(context, listen: false)
          .deleteProduct(product.id);
    } catch (onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Product deleted'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // FIXME: doesn't work
            Provider.of<Products>(context).restoreProduct(product.id);
          },
        ),
      ));
    }

    Navigator.pop(context);
  }

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
              onPressed: () => showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Error Alert!'),
                  content: const Text('Do you want to delete the product?'),
                  actions: [
                    TextButton(
                      onPressed: () => deleteProduct(context),
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('No'),
                    ),
                  ],
                ),
              ),
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
