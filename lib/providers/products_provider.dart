import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../dummy_data/dummy_data.dart';

class Products with ChangeNotifier {
  List<Product> _items = dummyProducts;

  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // } else {
    return [..._items];
    // }
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  // void showFavoritesOnly(){
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll(){
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _items.add(newProduct);
    notifyListeners();
  }

  updateProduct(String id, Product newData) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newData;
      notifyListeners();
    } else {
      print('No Product found');
    }
  }

  deleteProduct(String id){
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
