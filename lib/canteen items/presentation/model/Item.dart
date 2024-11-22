// ignore_for_file: public_member_api_docs, sort_constructors_first
class Item {
  String id;
  String name;
  String description;
  String price;
  String category;
  String cookingTime;
  String vendor;
  String photo;
  String quantity;
  bool isAvailable;
  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.cookingTime,
    required this.vendor,
    required this.photo,
    required this.quantity,
    required this.isAvailable,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'cookingTime': cookingTime,
      'vendor': vendor,
      'photo': photo,
      'quantity': quantity,
      'isAvailable': isAvailable,
    };
  }

  static Item fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      cookingTime: json['cookingTime'],
      vendor: json['vendor'],
      photo: json['photo'],
      quantity: json['quantity'],
      isAvailable: json['isAvailable'],
    );
  }
}
