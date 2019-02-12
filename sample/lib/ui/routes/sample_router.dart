import 'package:fluro/fluro.dart';
import 'package:flutter_politburo/ui/routes/app_router.dart';

class SampleRouter extends AppRouter {
  static final SampleRouter _singleton = SampleRouter._internal();

  SampleRouter._internal() : super(new Router());

  factory SampleRouter() => _singleton;

  @override
  Map<String, Handler> routeMap() {
    return {
      "/": incubatingHandler,
      "/intro": incubatingHandler,
      "/auth": incubatingHandler,
      "/browse": incubatingHandler,
      "/details": incubatingHandler,
      "/downloads": incubatingHandler,
      "/playback": incubatingHandler,
      "/settings": incubatingHandler
    };
  }
}
