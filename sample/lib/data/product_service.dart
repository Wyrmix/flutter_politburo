import 'package:sample/data/models/product.dart';

abstract class ProductService {
  Future<List<Product>> getProducts();
}