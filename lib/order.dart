import 'dart:convert';

class Order {
  final String orderItemImageUrl;
  final String orderItemName;
  final String orderItemDescription;
  final int orderItemPrice;
  final String orderId;
  final String orderDate;
  final bool hasOrderReachedStage2;
  final String? orderDispatchLocation;
  final String? orderDispatchedDate;
  final bool hasOrderReachedStage3;
  final String? orderDeliveredLocation;
  const Order(
      {required this.orderItemImageUrl,
      required this.orderItemName,
      required this.orderItemDescription,
      required this.orderItemPrice,
      required this.orderId,
      required this.orderDate,
      required this.hasOrderReachedStage2,
      required this.orderDispatchLocation,
      required this.orderDispatchedDate,
      required this.hasOrderReachedStage3,
      required this.orderDeliveredLocation});

  factory Order.fromJson(Map<String, dynamic> json) {
    var tempOrderJson = json["orderStatus"];
    List<dynamic> orderJson =
        tempOrderJson != null ? List.from(tempOrderJson) : List.empty();
    return Order(
        orderItemImageUrl: json["orderItemImageUrl"] as String,
        orderItemName: json["orderItemName"] as String,
        orderItemDescription: json["orderItemDescription"] as String,
        orderItemPrice: int.parse((json["orderItemPrice"] as String)),
        orderId: json["orderId"] as String,
        orderDate: orderJson[0]["date"],
        hasOrderReachedStage2: orderJson.length >= 2,
        orderDispatchLocation:
            orderJson.length >= 2 ? (orderJson[1]["address"] as String?) : null,
        orderDispatchedDate:
            orderJson.length >= 2 ? (orderJson[1]["date"] as String?) : null,
        hasOrderReachedStage3: orderJson.length == 3,
        orderDeliveredLocation: orderJson.length >= 3
            ? (orderJson[2]["address"] as String?)
            : null);
  }
}
