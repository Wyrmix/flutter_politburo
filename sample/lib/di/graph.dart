import 'package:dioc/dioc.dart';
import 'package:flutter_politburo/di/env.dart';
import 'package:flutter_politburo/di/graph.dart';
import 'package:flutter_politburo/ui/component/debug_drawer.dart';
import 'package:flutter_politburo/ui/routes/app_router.dart';
import 'package:sample/data/db/product_service.dart';
import 'package:sample/data/mock/product_service.dart';
import 'package:sample/data/network/product_service.dart';
import 'package:sample/data/product_service.dart';
import 'package:sample/ui/routes/sample_router.dart';

class SampleGraph extends DefaultObjectGraph {

  @override
  Future<Container> registerCommonDependencies(Container container) async {
    return container;
  }

  @override
  Future<Container> registerDevDependencies(Container container) async {
    final routeMap = SampleRouter().routeMap();
    final router = SampleRouter().router;
    final routesSection = RouteEntrySection(routeMap, router);
    container.register<DebugDrawer>((c) => DebugDrawer([routesSection]));
    container.register<ProductService>((c) => NetworkProductService());
    return container;
  }

  @override
  Future<Container> registerProdDependencies(Container container) async {
    container.register<ProductService>((c) => DbProductService());
    return container;
  }

  @override
  Future<Container> registerMockDependencies(Container container) async {
    container.register<ProductService>((c) => MockProductService());

    return container;
  }

  @override
  Future<Container> registerTestDependencies(Container container) async {
    return container;
  }
}
