class Categories {
  final int id;
  final String name, image;
  final List products;

  Categories({
    this.id,
    this.name,
    this.image,
    this.products,
  });
  factory Categories.fromJson(Map json) {
    return Categories(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      products: json['Products'],
    );
  }
}
