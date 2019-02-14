import 'package:dioc/dioc.dart';
import 'package:flutter/material.dart' hide Container;
import 'package:flutter_politburo/di/env.dart';
import 'package:flutter_politburo/ui/component/debug_drawer.dart';

abstract class ObjectGraph {
  Env env;

  static ObjectGraph graph;

  Container container = Container();

  Drawer get debugDrawer {
    final drawer = ObjectGraph.graph.container<DebugDrawer>();
    return drawer != null ? Drawer(child: drawer) : null;
  }

  Future<Container> build(Env config);

  Future<Container> registerCommonDependencies(Container container);

  Future<Container> registerDevDependencies(Container container);

  Future<Container> registerProdDependencies(Container container);

  Future<Container> registerMockDependencies(Container container);

  Future<Container> registerTestDependencies(Container container);
}

/// Base class implementing [ObjectGraph] with sensible defaults per environment.
///
/// Subclasses should override [registerCommonDependencies], [registerDevDependencies],
/// [registerProdDependencies], [registerMockDependencies], [registerTestDependencies]
/// to bind app specific dependencies into the graph.
/// Please note that this class does NOT bind anything into the graph itself.
///
/// [build] creates a cached instance of the graph for a given [Env] and binds
/// dependencies by chaining the calls as follows:
///
/// - [Env.dev]
/// -- [registerCommonDependencies]
/// -- [registerDevDependencies]
/// -- [registerProdDependencies]
/// - [Env.prod]
/// -- [registerCommonDependencies]
/// -- [registerProdDependencies]
/// - [Env.mock]
/// -- [registerMockDependencies]
/// - [Env.test]
/// -- [registerTestDependencies]
///
class DefaultObjectGraph extends ObjectGraph {

  @override
  Future<Container> registerDevDependencies(Container container) async =>
      container;

  @override
  Future<Container> registerCommonDependencies(Container container) async =>
      container;

  @override
  Future<Container> registerTestDependencies(Container container) async =>
      container;

  @override
  Future<Container> registerMockDependencies(Container container) async =>
      container;

  @override
  Future<Container> registerProdDependencies(Container container) async =>
      container;

  @override
  Future<Container> build(Env env) async {
    if (env == ObjectGraph.graph?.env) {
      return ObjectGraph.graph.container;
    } else {
      ObjectGraph.graph = DefaultObjectGraph();
      ObjectGraph.graph.container = this.container;
      ObjectGraph.graph.env = env;

      var con = ObjectGraph.graph.container;
      con.reset();
      switch (env) {
        case Env.dev:
          await registerCommonDependencies(con);
          await registerDevDependencies(con);
          await registerProdDependencies(con);
          break;
        case Env.prod:
          await registerCommonDependencies(con);
          await registerProdDependencies(con);
          break;
        case Env.test:
          registerTestDependencies(con);
          break;
        case Env.mock:
          registerMockDependencies(con);
          break;
      }
      return con;
    }
  }
}
