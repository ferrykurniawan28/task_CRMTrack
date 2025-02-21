import 'package:crm_track/ui/pages/authentication/login.dart';
import 'package:crm_track/ui/pages/main_screen.dart';
import 'package:crm_track/ui/pages/notification.dart';
import 'package:crm_track/ui/pages/splash_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'auth_routes.dart';

class MainRoutes extends Module {
  @override
  void routes(RouteManager r) {
    // r.child('/splash', child: (_) => const SplashScreen());
    r.child('/home', child: (_) => const MainScreen());
    r.child('/notification-center', child: (_) => const NotificationCenter());
    r.module('/auth', module: AuthRoutes());
  }
}
