import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_politburo/di/env.dart';
import 'package:flutter_politburo/ui/component/di_widget.dart';
import 'package:flutter_politburo/flutter_politburo.dart';
import 'package:sample/di/graph.dart';
import 'package:sample/ui/screens/account.dart';

void main() async {
  Fimber.plantTree(DebugTree(printTimeType: DebugTree.TIME_ELAPSED));
  Stopwatch stopwatch = new Stopwatch();
  Fimber.i("Creating object graph before app run");
  stopwatch.start();
  Env env = isInDebugMode ? Env.dev : Env.prod;
  final graph = await SampleGraph().build(env);
  stopwatch.stop();
  Fimber.i("Completed object graph creation in ${stopwatch.elapsedMilliseconds} ms");
  Fimber.i("Graph [$graph]");
  runApp(ContainerProvider(graph, child: MaterialApp(home: ProfileForm(),)));
}
