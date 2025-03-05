import 'package:crm_track/models/task_detail.dart';
import 'package:crm_track/models/opportunity_model.dart';
import 'package:crm_track/ui/pages/add_task.dart';
import 'package:crm_track/ui/pages/agenda/agenda.dart';
import 'package:crm_track/models/opportunity_model.dart';
import 'package:crm_track/ui/pages/authentication/login.dart';
import 'package:crm_track/ui/pages/list_activity.dart';
import 'package:crm_track/ui/pages/main_screen.dart';
import 'package:crm_track/ui/pages/marketing_toolkit_screen.dart';
import 'package:crm_track/ui/pages/notification.dart';
import 'package:crm_track/ui/pages/opportunity-management/opportunity_add.dart';
import 'package:crm_track/ui/pages/opportunity-management/opportunity_detail.dart';
import 'package:crm_track/ui/pages/opportunity-management/opportunity_list.dart';
import 'package:crm_track/ui/pages/splash_screen.dart';
import 'package:crm_track/ui/pages/task/task_detail.dart';
import 'package:crm_track/ui/pages/work-flow/map.dart';
import 'package:crm_track/ui/pages/work-flow/prospect_action.dart';
import 'package:crm_track/ui/pages/work-flow/work_flow_list.dart';
import 'package:crm_track/ui/pages/work-flow/workflow_detail.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../models/models.dart';

part 'auth_routes.dart';
part 'workflow_routes.dart';
part 'opportunity_management.dart';

class MainRoutes extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/splash', child: (_) => const SplashScreen());
    r.child('/home', child: (_) => const MainScreen());
    r.child('/notification-center', child: (_) => const NotificationCenter());
    r.child('/task/detail', child: (context) {
      final args = Modular.args.data as TaskDetail;
      return TaskListDetail(task: args);
    });
    r.child('/agenda', child: (_) => const Agenda());
    r.child('/marketing-toolkit', child: (_) => const MarketingToolkitScreen());
    r.child('/list-activity', child: (_) => const ListActivityScreen());
    r.module('/workflow', module: WorkflowRoutes());
    r.child('/agenda', child: (_) => const Agenda());
    r.child('/add', child: (_) => const AddTaskPage());

    r.module('/auth', module: AuthRoutes());
    r.module('/opportunity-management', module: OpportunityManagementRoutes());
  }
}
