import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../packages.dart';

class DetailsScreen extends StatelessWidget {
  static const String routeName = '/details';
  final String productId;

  const DetailsScreen(this.productId);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context).findById(productId);
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: deviceHeight * 0.3,
          // bottom: ,
          // centerTitle: true,
          // collapsedHeight: deviceHeight * 0.2,
          // forceElevated: true,
          // snap: true,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              product.title,
              style: TextStyle(color: Colors.black),
            ),
            background: Hero(
              tag: product.id,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          elevation: 5,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.4,
              //   width: double.infinity,
              //   child: ,
              // ),
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
              SizedBox(
                height: 800,
              )
            ],
          ),
        ),
      ],
    ));
  }
}
