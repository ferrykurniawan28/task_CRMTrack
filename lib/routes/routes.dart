import 'package:crm_track/models/task_detail.dart';
import 'package:crm_track/ui/pages/agenda/agenda.dart';
import 'package:crm_track/ui/pages/authentication/login.dart';
import 'package:crm_track/ui/pages/main_screen.dart';
import 'package:crm_track/ui/pages/notification.dart';
import 'package:crm_track/ui/pages/splash_screen.dart';
import 'package:crm_track/ui/pages/task/task_detail.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'auth_routes.dart';

class MainRoutes extends Module {
  @override
  void routes(RouteManager r) {
    // r.child('/splash', child: (_) => const SplashScreen());
    r.child('/home', child: (_) => const MainScreen());
    r.child('/notification-center', child: (_) => const NotificationCenter());
    r.child('/task/detail', child: (context) {
      final args = Modular.args.data as TaskDetail;
      return TaskListDetail(task: args);
    });
    r.child('/agenda', child: (_) => const Agenda());

    r.module('/auth', module: AuthRoutes());
  }
}
