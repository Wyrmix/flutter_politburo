library flutter_politburo;

/// Checks if the Dart VM is running with assertions enabled
///
/// These should only be enabled in debug runs of a flutter application and unit tests.
///
/// Can be used to check what [Env] a user is running in to enable things like the [DebugDrawer]
bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}