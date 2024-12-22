class Product {
  final String name;
  final String category;
  final double price;
  final String expiredDate;
  final String barcode;
  final String soldBy;
  final String unit;
  final int stock; // Store stock as an integer
  final String location; // Store location as a string
  final String dateImported;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.expiredDate,
    required this.barcode,
    required this.soldBy,
    required this.unit,
    required this.stock,
    required this.location,
    required this.dateImported,
  });

  // Method to create a copy of the product with updated fields
  Product copyWith({
    String? name,
    String? category,
    double? price,
    String? expiredDate,
    String? barcode,
    String? soldBy,
    String? unit,
    int? stock,
    String? location,
    String? dateImported,
  }) {
    return Product(
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      expiredDate: expiredDate ?? this.expiredDate,
      barcode: barcode ?? this.barcode,
      soldBy: soldBy ?? this.soldBy,
      unit: unit ?? this.unit,
      stock: stock ?? this.stock,
      location: location ?? this.location,
      dateImported: dateImported ?? this.dateImported,
    );
  }

  // Factory method to create a Product from a JSON object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['product_name'] as String,
      category: json['category_id'] as String,
      price: (json['unit_price'] as num).toDouble(),
      expiredDate: json['expired_date'] as String,
      barcode: json['product_id'] as String,
      soldBy: json['supplier_id'] as String,
      unit: json['unit'] as String,
      stock: json['stock'] as int,
      location: json['location'] as String,
      dateImported: json['date_imported'] as String,
    );
  }

  // Method to convert a Product to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'expiredDate': expiredDate,
      'barcode': barcode,
      'soldBy': soldBy,
      'unit': unit,
      'stock': stock,
      'location': location,
      'dateImported': dateImported,
    };
  }
}
