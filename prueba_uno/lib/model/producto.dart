class Product {
  int selected;
  int id;
  String name;
  String image;
  int price;
  int quantity;
  bool promotion;
  List<int> match;

  Product(
    this.selected,
    this.id,
    this.name,
    this.image,
    this.price,
    this.quantity,
    this.promotion,
    this.match,
  );

  Product clone() {
    return Product(
        selected, id, name, image, price, quantity, promotion, match);
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      map['selected'] != null ? map['selected'] as int : 0,
      map['id'] != null ? map['id'] as int : -1,
      map['name'] != null ? map['name'] as String : "",
      map['image'] != null ? map['image'] as String : "",
      map['price'] != null ? map['price'] as int : 0,
      map['quantityInCart'] != null ? map['quantityInCart'] as int : 0,
      map['promotion'] != null ? map['promotion'] as bool : false,
      map['match'] != null ? (map['match'] as List).cast<int>() : List.empty(),
    );
  }
}
