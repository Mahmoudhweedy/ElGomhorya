class Product {
  final String name,
      description,
      price,
      offer,
      quantity,
      // categoryId,
      userId,
      sliderId,
      longDescription,
      image;
  final int id;
  final List extraQuantity;
  int counter;
  final Duration createdAt, updatedAt;

  Product({
    this.name,
    this.counter,
    this.description,
    this.longDescription,
    this.image,
    this.id,
    this.price,
    this.offer,
    this.quantity,
    // this.categoryId,
    this.userId,
    this.sliderId,
    this.extraQuantity,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map json) {
    return Product(
      // categoryId: json['category_id'],
      counter: json['counter'] == null ? 0 : int.parse(json['counter']),
      description: json['desc'],
      id: json['id'],
      image: json['image'],
      name: json['name'],
      longDescription: json['long_desc'],

      // offer: json['offer'].toString() ?? '0',
      price: json['price'],
      quantity: json['quantity'].toString(),
      sliderId: json['slider_id'].toString(),
      userId: json['user_id'].toString(),
      extraQuantity: json["extraQuantity"],
    );
  }
}
