import 'dart:math';

import 'package:sample/data/models/product.dart';
import 'package:sample/data/product_service.dart';
import 'package:faker/faker.dart';

class MockProductService extends ProductService {
  @override
  Future<List<Product>> getProducts() async {
    var products = [];
    var faker = Faker();

    for (var i = 0; i < 100; i++) {
      products.add(Product("mockItem [${faker.food.dish()}]",
          "https://picsum.photos/200/?random", Random().nextDouble()));
    }

    return products;
  }
}
