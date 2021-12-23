import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:order_trackr/order.dart';
import 'package:order_trackr/order_details.dart';
import 'package:order_trackr/order_json.dart';
import 'package:order_trackr/rating_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const OrderTrackr());
}

class OrderTrackr extends StatefulWidget {
  const OrderTrackr({Key? key}) : super(key: key);

  @override
  State<OrderTrackr> createState() => _OrderTrackrState();
}

class _OrderTrackrState extends State<OrderTrackr> {
  late Order order;
  @override
  void initState() {
    var json = jsonDecode(jsonStringStage3);
    order = Order.fromJson(json);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RatingModel(),
      child: MaterialApp(
        home: OrderDetails(
          onBackPressed: () {},
          onReturnOrder: () {},
          order: order,
        ),
      ),
    );
  }
}
