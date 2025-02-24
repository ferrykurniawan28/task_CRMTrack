part of 'routes.dart';

class AuthRoutes extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/splash', child: (_) => const SplashScreen());
    r.child('/login', child: (_) => const Login());
  }
}
