import 'package:crm_track/cubit/opportunity-management/opportunity_management_cubit.dart';
import 'package:crm_track/helpers/helpers.dart';
import 'package:crm_track/models/opportunity_model.dart';
import 'package:crm_track/ui/widgets/task_list/task_list_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class OpportunityList extends StatefulWidget {
  const OpportunityList({super.key});

  @override
  State<OpportunityList> createState() => _OpportunityListState();
}

class _OpportunityListState extends State<OpportunityList> {
  List<String> categories = [
    'Qualification',
    'Meeting Scheduled',
    'Proposal',
    'Negotiation',
    'Closed',
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opportunity Management'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Modular.to.navigate('/home'),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          spacerHeight(16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 37,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      hintText: 'Search Data',
                      hintStyle: const TextStyle(
                        color: Color(0xFF899197),
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFF899197),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFFE6E6E6),
                        ),
                      ),
                    ),
                  ),
                ),
                spacerWidth(12),
                Container(
                  height: 34,
                  width: 34,
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: primaryColor,
                    ),
                  ),
                  child: Image.asset(
                    'assets/icon/calendar4-week.png',
                    width: 16,
                    height: 16,
                  ),
                )
              ],
            ),
          ),
          spacerHeight(16),
          FilterWidget(taskFilter: categories, onSelected: (int index) {}),
          spacerHeight(16),
          BlocBuilder<OpportunityManagementCubit, OpportunityManagementState>(
            builder: (context, state) {
              BlocProvider.of<OpportunityManagementCubit>(context)
                  .fetchOpportunity();
              if (state is OpportunityManagementLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is OpportunityManagementLoaded) {
                return ListView.builder(
                  itemCount: state.opportunities.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    final opportunity = state.opportunities[index];
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/opportunity-management/detail',
                        arguments: opportunity,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        margin: const EdgeInsets.only(bottom: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF959596),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(opportunity.customer.name),
                            spacerHeight(4),
                            Text(
                              opportunity.opprtunity,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                            ),
                            spacerHeight(4),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Image.asset('assets/icon/cash-coin.png'),
                                      spacerWidth(4),
                                      Text(
                                        NumberFormat.currency(
                                                locale: 'id',
                                                symbol: 'Rp',
                                                decimalDigits: 0)
                                            .format(opportunity.amount),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF01BAEF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/icon/bezier2.png',
                                        color: const Color(0xFF146C43),
                                      ),
                                      spacerWidth(4),
                                      Text(
                                        opportunityStageToString(
                                            opportunity.stage),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF146C43),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                    child: Text('Failed to load opportunities'));
              }
            },
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () => Modular.to.pushNamed('/opportunity-management/add'),
        child: Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
