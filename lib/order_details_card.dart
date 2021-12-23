import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:order_trackr/order.dart';
import 'package:order_trackr/rating_model.dart';
import 'package:order_trackr/review_screen.dart';
import 'package:order_trackr/size_provider.dart';
import 'package:provider/provider.dart';

class OrderDetailsCard extends StatelessWidget {
  final Function() onReturnOrder;
  final Order order;
  const OrderDetailsCard({
    Key? key,
    required this.onReturnOrder,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var decimalFormatter =
        NumberFormat.currency(locale: "HI", symbol: "₹", decimalDigits: 0);
    return Column(
      children: [
        SizedBox(
          height: getProportionalHeight(70),
        ),
        Row(
          children: [
            Container(
              width: getProportionalWidth(220),
              height: getProportionalHeight(220),
              margin:
                  EdgeInsets.symmetric(horizontal: getProportionalWidth(20)),
              child: Image.network(order.orderItemImageUrl),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: getProportionalHeight(220),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(),
                      Text(
                        order.orderItemName,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      Text(
                        order.orderItemDescription,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      SizedBox(
                        height: getProportionalHeight(32),
                      ),
                      Text(
                        decimalFormatter.format(order.orderItemPrice),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionalHeight(36)),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: getProportionalHeight(45),
        ),
        Text(
          "Rate Us",
          style: TextStyle(
              color: Colors.grey.shade800, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: getProportionalHeight(20)),
        RatingStarField(),
        SizedBox(height: getProportionalHeight(24)),
        SizedBox(
          height: getProportionalHeight(22),
          child: TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      insetPadding: EdgeInsets.symmetric(
                          horizontal: getProportionalWidth(32)),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(getProportionalHeight(32))),
                      child: Container(
                        child: ReviewScreen(),
                      ),
                    );
                  });
            },
            child: const Text(
              "Write A Review",
              style: TextStyle(height: 0),
            ),
          ),
        ),
        SizedBox(
          height: getProportionalHeight(60),
        ),
        Container(
          margin: EdgeInsets.only(left: getProportionalWidth(52)),
          width: double.infinity,
          child: Text(
            "Order ID: #${order.orderId}",
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: getProportionalWidth(100), top: getProportionalHeight(30)),
          width: double.infinity,
          height: getProportionalHeight(400),
          child: OrderStatus(
            hasReachedStage2: order.hasOrderReachedStage2,
            hasReachedStage3: order.hasOrderReachedStage3,
            orderPlacedDate: order.orderDate,
            orderDispatchDate: order.orderDispatchedDate,
            orderDispatchLocation: order.orderDispatchLocation,
            orderDeliveredAddress: order.orderDeliveredLocation,
          ),
        ),
        SizedBox(
          height: getProportionalHeight(48),
        ),
        Container(
          height: getProportionalHeight(64),
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: getProportionalWidth(64)),
          child: ClipRRect(
            child: ElevatedButton(
              child: Text("Return Order"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFEEEEEE)),
                  foregroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: onReturnOrder,
            ),
            borderRadius: BorderRadius.circular(getProportionalHeight(36)),
          ),
        ),
        SizedBox(
          height: getProportionalHeight(64),
        )
      ],
    );
  }
}

class RatingStar extends StatefulWidget {
  final bool filled;
  final Function() onPressed;
  const RatingStar({Key? key, this.filled = false, required this.onPressed})
      : super(key: key);

  @override
  _RatingStarState createState() => _RatingStarState();
}

class _RatingStarState extends State<RatingStar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getProportionalWidth(2)),
      child: IconButton(
        onPressed: widget.onPressed,
        icon: Icon(
            widget.filled ? Icons.star_rounded : Icons.star_border_rounded),
        color: widget.filled ? Colors.green : Colors.grey,
        iconSize: getProportionalHeight(50),
        padding: EdgeInsets.zero,
      ),
      height: getProportionalHeight(50),
      width: getProportionalHeight(50),
    );
  }
}

Offset _getPositions(GlobalKey _key) {
  final RenderBox renderBoxRed =
      _key.currentContext!.findRenderObject()! as RenderBox;
  var renderOffSet = renderBoxRed.localToGlobal(Offset.zero);
  print(renderOffSet);
  return renderOffSet;
}

class OrderStatus extends StatefulWidget {
  final bool hasReachedStage2;
  final bool hasReachedStage3;
  final String orderPlacedDate;
  final String? orderDispatchDate;
  final String? orderDispatchLocation;
  final String? orderDeliveredAddress;
  const OrderStatus({
    Key? key,
    required this.hasReachedStage2,
    required this.hasReachedStage3,
    required this.orderPlacedDate,
    this.orderDispatchDate,
    this.orderDeliveredAddress,
    this.orderDispatchLocation,
  }) : super(key: key);

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  double distance1 = 90;
  double distance2 = 90;
  bool barsVisible = false;

  GlobalKey _keyStage1 = GlobalKey();
  GlobalKey _keyStage2 = GlobalKey();
  GlobalKey _keyStage3 = GlobalKey();

  @override
  void didUpdateWidget(covariant OrderStatus oldWidget) {
    // TODO: implement didUpdateWidget
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        var offset1 = _getPositions(_keyStage1);
        var offset2 = _getPositions(_keyStage2);
        var offset3 = _getPositions(_keyStage3);
        var distanceA = offset2.dy - offset1.dy - getProportionalHeight(40);
        var distanceB = offset3.dy - offset2.dy - getProportionalHeight(32);
        distance1 = distanceA;
        distance2 = distanceB;
        barsVisible = true;
      });
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        var offset1 = _getPositions(_keyStage1);
        var offset2 = _getPositions(_keyStage2);
        var offset3 = _getPositions(_keyStage3);
        var distanceA = offset2.dy - offset1.dy - getProportionalHeight(40);
        var distanceB = offset3.dy - offset2.dy - getProportionalHeight(32);
        distance1 = distanceA;
        distance2 = distanceB;
        barsVisible = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        var offset1 = _getPositions(_keyStage1);
        var offset2 = _getPositions(_keyStage2);
        var offset3 = _getPositions(_keyStage3);
        var distanceA = offset2.dy - offset1.dy - getProportionalHeight(40);
        var distanceB = offset3.dy - offset2.dy - getProportionalHeight(32);
        distance1 = distanceA;
        distance2 = distanceB;
        barsVisible = true;
      });
    });
    return Stack(
      children: [
        Visibility(
          visible: barsVisible,
          child: Container(
            margin: EdgeInsets.only(left: getProportionalHeight(23)),
            child: Column(
              children: [
                SizedBox(
                  height: getProportionalHeight(46),
                ),
                Container(
                  width: 2,
                  height: distance1,
                  color: widget.hasReachedStage2
                      ? const Color(0xFF057afc)
                      : Colors.grey,
                ),
                SizedBox(
                  height: getProportionalHeight(36),
                ),
                Container(
                  width: 2,
                  height: distance2,
                  color: widget.hasReachedStage3
                      ? const Color(0xFF057afc)
                      : Colors.grey,
                ),
              ],
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OrderStatusWidget(
              icon: Icons.access_time_filled_rounded,
              hasStepReached: true,
              title: "Order Placed on",
              status: widget.orderPlacedDate,
              globalKey: _keyStage1,
            ),
            OrderStatusWidget(
              icon: Icons.map_outlined,
              hasStepReached: widget.hasReachedStage2,
              title: widget.hasReachedStage2 ? "Dispatched to" : "Dispatched",
              status: widget.hasReachedStage2
                  ? "${widget.orderDispatchLocation} on ${widget.orderDispatchDate}"
                  : "",
              globalKey: _keyStage2,
            ),
            OrderStatusWidget(
              icon: Icons.house_siding_rounded,
              hasStepReached: widget.hasReachedStage3,
              title: widget.hasReachedStage3 ? "Delivered to" : "Delivered",
              status: widget.hasReachedStage3 ? "Address: " : "",
              address:
                  widget.hasReachedStage3 ? widget.orderDeliveredAddress : null,
              globalKey: _keyStage3,
            )
          ],
        ),
      ],
    );
  }
}

class OrderStatusWidget extends StatefulWidget {
  final IconData icon;
  final String title;
  final String status;
  final GlobalKey globalKey;
  final bool hasStepReached;
  final String? address;
  const OrderStatusWidget({
    Key? key,
    required this.icon,
    this.title = "Title",
    this.status = "Status",
    this.hasStepReached = false,
    this.address,
    required this.globalKey,
  }) : super(key: key);

  @override
  _OrderStatusWidgetState createState() => _OrderStatusWidgetState();
}

class _OrderStatusWidgetState extends State<OrderStatusWidget> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        color: widget.hasStepReached ? Colors.black : Colors.grey.shade600);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: widget.globalKey,
      children: [
        Icon(
          widget.icon,
          size: getProportionalHeight(50),
          color: widget.hasStepReached
              ? const Color(0xFF057afc)
              : Colors.grey.shade400,
        ),
        SizedBox(
          width: getProportionalWidth(8),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: textStyle,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.status,
                  style: textStyle,
                ),
                widget.address != null
                    ? Text(widget.address.toString())
                    : const SizedBox()
              ],
            )
          ],
        )
      ],
    );
  }
}

class RatingStarField extends StatefulWidget {
  const RatingStarField({Key? key}) : super(key: key);

  @override
  _RatingStarFieldState createState() => _RatingStarFieldState();
}

class _RatingStarFieldState extends State<RatingStarField> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RatingModel>(builder: (context, model, _) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RatingStar(
            filled: model.numberOfStarsGiven >= 1,
            onPressed: () {
              model.setNumberOfStars(1);
            },
          ),
          RatingStar(
            filled: model.numberOfStarsGiven >= 2,
            onPressed: () {
              model.setNumberOfStars(2);
            },
          ),
          RatingStar(
            filled: model.numberOfStarsGiven >= 3,
            onPressed: () {
              model.setNumberOfStars(3);
            },
          ),
          RatingStar(
            filled: model.numberOfStarsGiven >= 4,
            onPressed: () {
              model.setNumberOfStars(4);
            },
          ),
          RatingStar(
            filled: model.numberOfStarsGiven >= 5,
            onPressed: () {
              model.setNumberOfStars(5);
            },
          ),
        ],
      );
    });
  }
}
