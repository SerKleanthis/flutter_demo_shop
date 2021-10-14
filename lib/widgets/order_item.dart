import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../packages.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem order;
  const OrderItemWidget(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          ListTile(
            title: Text('${order.amount}'),
            subtitle: Text(
              DateFormat('dd Mm yy hh:mm').format(order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
