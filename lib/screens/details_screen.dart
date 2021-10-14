import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../packages.dart';

class DetailsScreen extends StatelessWidget {
  static const String routeName = '/details';
  final String productId;

  const DetailsScreen(this.productId);

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);
    final product = Provider.of<Products>(context).findById(productId);
    // final product = Provider.of<Product>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(product.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                child: Hero(
                  tag: product.id,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 15),
                  const Text(
                    'Buy at:',
                    style: TextStyle(
                      fontSize: 21,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '${product.price} \$',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                product.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
              const SizedBox(height: 10),
              const Divider(
                thickness: 1.5,
                indent: 15,
                endIndent: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                onPressed: () {},
                child: const Text('Add to Cart!'),
              ),
            ],
          ),
        )
        // FittedBox(
        //   // height: MediaQuery.of(context).size.height,
        //   // width: double.infinity,
        //   fit: BoxFit.cover,
        //   child: Container(
        //     margin: const EdgeInsets.all(15),
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.circular(10),
        //       child: FittedBox(
        //         fit: BoxFit.cover,
        //         child: Center(
        //           // borderOnForeground: false,
        //           child: Hero(
        //             tag: product.id,
        //             child: Image.network(product.imageUrl),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
