// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:crm_track/cubit/task/task_cubit.dart';
import 'package:crm_track/helpers/helpers.dart';
import 'package:crm_track/ui/widgets/appbar.dart';
import 'package:crm_track/ui/pages/home/widgets/home_menu.dart';
import 'package:crm_track/ui/pages/home/widgets/home_task_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_modular/flutter_modular.dart';

import '../../widgets/workflow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            spacerHeight(20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: HomeAppbar(),
            ),
            spacerHeight(16),
            SizedBox(
              height: 130,
              child: PageView.builder(
                controller: _pageController,
                itemCount: 3,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return WorkflowWidget();
                },
              ),
            ),
            spacerHeight(8),

            ///workflow indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => AnimatedContainer(
                  duration: Duration(microseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  height: 6,
                  width: _selectedIndex == index ? 24 : 6,
                  decoration: BoxDecoration(
                    color: _selectedIndex == index
                        ? Colors.red
                        : Color.fromRGBO(217, 217, 217, 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),

            ///menu
            Container(
              margin: EdgeInsets.only(top: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CardMenu(
                        onTap: () => Modular.to.pushNamed('/marketing-toolkit'),
                        icon: Image.asset('assets/icon/tools.png'),
                        title: 'Marketing\nToolkit'),
                    CardMenu(
                        icon: Image.asset('assets/icon/lightbulb.png'),
                        title: 'Opportunity\nManagement'),
                    CardMenu(
                        icon: Image.asset('assets/icon/funnel.png'),
                        title: 'Funnel\nSummary'),
                    CardMenu(
                        onTap: () => Modular.to.pushNamed('/list-activity'),
                        icon: Image.asset('assets/icon/activity.png'),
                        title: 'List\nActivity'),
                    CardMenu(
                      icon: Image.asset('assets/icon/file-person.png'),
                      title: 'Contact\nManagement',
                    ),
                  ],
                ),
              ),
            ),
            spacerHeight(16),
            Expanded(
              child: BlocProvider(
                create: (context) => TaskCubit(),
                child: HomeTaskListWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
