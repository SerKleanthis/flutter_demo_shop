import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../packages.dart';

class CartItemWidget extends StatefulWidget {
  final CartItem cartItem;

  const CartItemWidget(this.cartItem);

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 15),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
      ),
      onDismissed: (d) {
        Provider.of<Cart>(context, listen: false)
            .removeItem(widget.cartItem.productId);
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: FittedBox(
              child: CircleAvatar(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('${widget.cartItem.price} \$')),
              ),
            ),
            title: Text(widget.cartItem.title),
            subtitle: Text('Total: ${widget.cartItem.quantity}'),
            trailing: Text('${widget.cartItem.quantity} x'),
          ),
        ),
      ),
    );
  }
}
