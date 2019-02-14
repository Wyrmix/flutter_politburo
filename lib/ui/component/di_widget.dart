import 'package:flutter/widgets.dart' hide Container;
import 'package:dioc/dioc.dart';

/// Widget that provides its children with a [Container] to locate all of its dependencies
class ContainerProvider extends InheritedWidget {
  final Container container;

  ContainerProvider(this.container, {
    Key key,
    Widget child
  }): super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static Container of(BuildContext context) => (context.inheritFromWidgetOfExactType(ContainerProvider) as ContainerProvider).container;
}

mixin ContainerConsumer on State {
  Container get container {
    return ContainerProvider.of(super.context);
  }
}
