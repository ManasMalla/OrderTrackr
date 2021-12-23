import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:order_trackr/order.dart';
import 'package:order_trackr/order_details_card.dart';
import 'package:order_trackr/size_provider.dart';

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
      };
}

class OrderDetails extends StatefulWidget {
  final Function() onBackPressed;
  final Function() onReturnOrder;
  final Order order;
  const OrderDetails({
    Key? key,
    required this.onBackPressed,
    required this.onReturnOrder,
    required this.order,
  }) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    SizeProvider().init(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFe6f7ff),
            height: getProportionalHeight(180),
            padding: EdgeInsets.symmetric(
                horizontal: getProportionalWidth(48),
                vertical: getProportionalHeight(72)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: getProportionalHeight(36),
                  width: getProportionalHeight(36),
                  child: IconButton(
                    icon: const Icon(Icons.chevron_left_rounded),
                    onPressed: widget.onBackPressed,
                    iconSize: getProportionalHeight(36),
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(width: getProportionalWidth(75)),
                Text(
                  "Order Details",
                  style:
                      TextStyle(fontSize: getProportionalHeight(36), height: 1),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: getProportionalHeight(148)),
            height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(getProportionalHeight(32))),
            child: ScrollConfiguration(
              behavior: CustomScrollBehavior().copyWith(scrollbars: false),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: getProportionalHeight(1180),
                  child: OrderDetailsCard(
                    onReturnOrder: widget.onReturnOrder,
                    order: widget.order,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
