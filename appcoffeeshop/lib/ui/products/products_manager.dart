import 'package:appcoffeeshop/Utils.dart';
import 'package:appcoffeeshop/models/product_type.dart';
import 'package:appcoffeeshop/services/comment_service.dart';

import '../../models/product.dart';
import 'package:flutter/foundation.dart';
import '../../models/auth_token.dart';
import '../../services/favorite_service.dart';
import '../../services/products_service.dart';

class ProductsManager with ChangeNotifier {
  List<Product> _listOrigin = [];
  List<Product> _items = [];
  List<String> _comments = [];

  final ProductsService _productsService;
  final FavoriteService _favoriteService;
  final CommentService _commentService;

  ProductsManager([AuthToken? authToken])
      : _productsService = ProductsService(authToken),
        _favoriteService = FavoriteService(authToken),
        _commentService = CommentService(authToken);

  set authToken(AuthToken? authToken) {
    _productsService.authToken = authToken;
    _favoriteService.authToken = authToken;
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    _items.clear();
    _listOrigin.clear();
    _items = await _productsService.fetchProducts(filterByUser);
    _items.forEach((element) async {
      var number = await _favoriteService.fetchNumberFavorite(element);
      if (number > 0) element.isFavorite = true;
      element.numberFavorite = number;
    });
    _listOrigin.addAll(_items);
    notifyListeners();
  }

  Future<void> filterProducts(String type) async {
    _items.clear();
    _items.addAll(_listOrigin);
    if (type == ProductType.ALL.name) {
      notifyListeners();
      return;
    }
    var prodcts = <Product>[];
    for (var element in _items) {
      if (element.type == type) {
        prodcts.add(element);
      }
    }
    _items.clear();
    _items.addAll(prodcts);
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await _productsService.addProduct(product);
    if (newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      if (await _productsService.updateProduct(product)) {
        _items[index] = product;
        notifyListeners();
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    Product? existingProduct = _items[index];
    _items.removeAt(index);
    notifyListeners();
    if (index >= 0) {
      if (!await _productsService.deleteProduct(id)) {
        _items.insert(index, existingProduct);
        notifyListeners();
      }
    }
  }

  Future<void> fetchComment(String id) async {
    var dataComment = await _commentService.fetchComments(id);
    _comments.clear();
    _comments.addAll(dataComment);
    notifyListeners();
  }

  Future<void> addComment(Product product, String content) async {
    var idUser = await Utils.getUserid();
    await _commentService.addComment(
      product.id!,
      idUser,
      product.creatorId,
      content,
    );
    await fetchComment(product.id!);
  }

  Future<void> toggleFavoriteStatus(Product product) async {
    var isFavorite = await _favoriteService.saveFavoriteStatus(product);
    product.isFavorite = isFavorite;
    fetchFavorite(product);
  }

  Future<void> fetchFavorite(Product product) async {
    var number = await _favoriteService.fetchNumberFavorite(product);
    product.numberFavorite = number;
  }

  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }

  int get itemCountComment {
    return _comments.length;
  }

  List<String> get comments {
    return [..._comments];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
