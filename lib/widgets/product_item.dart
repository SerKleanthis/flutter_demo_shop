import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../packages.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final productData = Provider.of<Products>(context);
    // final product = productData.findById(productId);

    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    final token = Provider.of<Auth>(context).getToken;
    final userId = Provider.of<Auth>(context).getUserId;
    return ChangeNotifierProvider.value(
      value: product,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: ChangeNotifierProvider.value(
            value: product,
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => DetailsScreen(product.id)),
              ),
              child: Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          footer: GridTileBar(
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.black45,
            leading: IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                product.toggleFavoriteStatus(token!, userId!);
              },
            ),
            trailing: IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  cart.addItem(DateTime.now().toString(), product.id,
                      product.title, product.price);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${product.title} added to cart!'),
                    duration: const Duration(seconds: 1),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () => cart.removeSingleItem(product.id),
                    ),
                  ));
                }),
          ),
        ),
      ),
    );
  }
}
