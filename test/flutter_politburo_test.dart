import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_politburo/flutter_politburo.dart';

void main() {
  test('tests are running in debug mode (assertions enabled)', () {
    final isDebug = isInDebugMode;
    expect(isDebug, true);
  });
}
