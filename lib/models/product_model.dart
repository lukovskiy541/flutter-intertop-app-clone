import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/category_model.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> images;
  final Category category;
  final SubCategory subCategory;
  final List<String> availableSizes;
  final List<String> availableColors;
  final int bonusPoints;
  final int bonusPointsForSubscribers;
  final String brand;
  final String seller;
  final bool isFavorite;
  final int stock;
  final Gender gender;
  final ProductType productType;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.category,
    required this.subCategory,
    required this.availableSizes,
    required this.availableColors,
    required this.bonusPoints,
    required this.bonusPointsForSubscribers,
    required this.brand,
    required this.seller,
    this.isFavorite = false,
    required this.gender,
    required this.productType,
    this.stock = 0,
  });

  factory Product.fromFirestore(dynamic doc) {
    Map<String, dynamic> data;
    String id;

    if (doc is DocumentSnapshot) {
      data = doc.data() as Map<String, dynamic>;
      id = doc.id;
    } else if (doc is Map<String, dynamic>) {
      data = doc;
      id = data['id'] ?? '';
    } else {
      throw ArgumentError(
          'Invalid input type for Product.fromFirestore. Expected DocumentSnapshot or Map<String, dynamic>.');
    }

    Category category = data['category'] is Map<String, dynamic>
        ? Category.fromJson(data['category'])
        : Category.fromFirestore(data['category']);

    SubCategory subCategory = data['subCategory'] is Map<String, dynamic>
        ? SubCategory.fromJson(data['subCategory'])
        : SubCategory.fromFirestore(data['subCategory']);

    Gender gender = data['gender'] is Map<String, dynamic>
        ? Gender.fromJson(data['gender'])
        : Gender.fromFirestore(data['gender']);

    ProductType productType = data['productType'] is Map<String, dynamic>
        ? ProductType.fromJson(data['productType'])
        : ProductType.fromFirestore(data['productType']);

    return Product(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      images: List<String>.from(data['images'] ?? []),
      category: category,
      subCategory: subCategory,
      availableSizes: List<String>.from(data['availableSizes'] ?? []),
      availableColors: List<String>.from(data['availableColors'] ?? []),
      bonusPoints: data['bonusPoints'] ?? 0,
      bonusPointsForSubscribers: data['bonusPointsForSubscribers'] ?? 0,
      brand: data['brand'] ?? '',
      seller: data['seller'] ?? '',
      isFavorite: data['isFavorite'] ?? false,
      stock: data['stock'] ?? 0,
      gender: gender,
      productType: productType,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'images': images,
      'category': category.toJson(),
      'subCategory': subCategory.toJson(),
      'gender': gender.toJson(),
      'productType': productType.toJson(),
      'availableSizes': availableSizes,
      'availableColors': availableColors,
      'bonusPoints': bonusPoints,
      'bonusPointsForSubscribers': bonusPointsForSubscribers,
      'brand': brand,
      'seller': seller,
      'isFavorite': isFavorite,
      'stock': stock,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'images': images,
      'category': category.toJson(),
      'subCategory': subCategory.toJson(),
      'gender': gender.toJson(),
      'productType': productType.toJson(),
      'availableSizes': availableSizes,
      'availableColors': availableColors,
      'bonusPoints': bonusPoints,
      'bonusPointsForSubscribers': bonusPointsForSubscribers,
      'brand': brand,
      'seller': seller,
      'isFavorite': isFavorite,
      'stock': stock,
    };
  }

  
  

  factory Product.fromJson(Map<String, dynamic> json) {
    Category category = Category.fromJson(json['category']);
    SubCategory subCategory = SubCategory.fromJson(json['subCategory']);
    Gender gender = Gender.fromJson(json['gender']);
    ProductType productType = ProductType.fromJson(json['productType']);
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      images: List<String>.from(json['images']),
      category: category,
      subCategory: subCategory,
      gender: gender,
      productType: productType,
      availableSizes: List<String>.from(json['availableSizes']),
      availableColors: List<String>.from(json['availableColors']),
      bonusPoints: json['bonusPoints'],
      bonusPointsForSubscribers: json['bonusPointsForSubscribers'],
      brand: json['brand'],
      seller: json['seller'],
      isFavorite: json['isFavorite'] ?? false,
      stock: json['stock'] ?? 0,
    );
  }
}
