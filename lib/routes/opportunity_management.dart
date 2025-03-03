part of 'routes.dart';

class OpportunityManagementRoutes extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const OpportunityList());
    r.child('/add', child: (_) => const OpportunityAdd(), children: [
      // ChildRoute('/first-page', child: (context) {
      //   final args = Modular.args.data as Map<String, dynamic>;
      //   return ProjectOverview(
      //     opportunityNameController: args['opportunityNameController'],
      //     customerNameController: args['customerNameController'],
      //     opportunityType: args['opportunityType'],
      //     formKey: args['formKey'],
      //   );
      // }),
      // ChildRoute('/second-page', child: (_) => const ProjectDetail()),
    ]);
    r.child('/detail', child: (context) {
      final args = Modular.args.data as OpportunityModel;
      return OpportunityDetail(opportunity: args);
    });
  }
}
