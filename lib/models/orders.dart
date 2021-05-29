class Orders {
  final int id;
  final String productPrice,
      productQuantity,
      fName,
      lName,
      userMobile,
      userAddress,
      city,
      region,
      paymentMethod,
      orderStatus,
      orderDeliverd;
  final List orderDetails;

  Orders({
    this.id,
    this.productPrice,
    this.productQuantity,
    this.fName,
    this.lName,
    this.userMobile,
    this.userAddress,
    this.city,
    this.region,
    this.paymentMethod,
    this.orderStatus,
    this.orderDeliverd,
    this.orderDetails,
  });
  factory Orders.fromJson(Map json) {
    return Orders(
      id: json['id'],
      city: json['city'],
      fName: json['user_f_name'],
      lName: json['user_l_name'],
      orderDeliverd: json['order_delivered'],
      orderDetails: json['OrderDetails'],
      orderStatus: json['order_status'],
      productPrice: json['product_price'].toString(),
      paymentMethod: json['payment_method'],
      productQuantity: json['product_quantity'].toString(),
      region: json['region'],
      userAddress: json['user_address'],
      userMobile: json['user_mobile'],
    );
  }
}

class OrderDetails {
  final int id;
  final String orderId,
      productId,
      shopId,
      storeId,
      type,
      productPrice,
      productName,
      productQuantity;

  OrderDetails({
    this.id,
    this.orderId,
    this.productId,
    this.shopId,
    this.storeId,
    this.type,
    this.productPrice,
    this.productName,
    this.productQuantity,
  });
  factory OrderDetails.fromJson(Map json) {
    return OrderDetails(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      productName: json['product_name'],
      productPrice: json['product_price'],
      productQuantity: json['product_quantity'],
      shopId: json['shop_id'],
      storeId: json['store_id'],
      type: json['type'],
    );
  }
}
