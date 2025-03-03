part of 'routes.dart';

class WorkflowRoutes extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const WorkFlowList());
    r.child('/detail', child: (context) {
      final args = Modular.args.data as Workflow;
      return WorkflowDetail(workflow: args);
    });
    r.child('/stage', child: (context) {
      final args = Modular.args.data as Staging;
      return ProspectAction(staging: args);
    });
    r.child('/maps', child: (context) {
      final args = Modular.args.data as Map<String, dynamic>;
      final lat = args['lat'] as double?;
      final lng = args['lng'] as double?;
      final onTap = args['onTap'];
      final isSelecting = args['isSelecting'] as bool?;
      return MapScreen(
        lat: lat,
        lng: lng,
        onTap: onTap,
        isSelecting: isSelecting ?? false,
      );
    });
  }
}
