

class Sliders {
  final String image, productId, type;
  final int id;
  final List  product;

  Sliders({
    this.image,
    this.productId,
    this.type,
    this.id,
    this.product,
  });

  factory Sliders.fromJson(Map json) {
    return Sliders(
      id: json['id'],
      image: json['image'],
      product: json['product'],
      productId: json['product_id'],
      type: json['type'],
    );
  }
}
