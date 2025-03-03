import 'package:crm_track/ui/pages/agenda/agenda.dart';
import 'package:crm_track/ui/pages/home/home_screen.dart';
import 'package:crm_track/ui/pages/profile_screen.dart';
import 'package:crm_track/ui/pages/task/task_list.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const Agenda(),
    const HomeScreen(),
    const TaskListPage(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: Text(_index.toString()),
      // ),
      body: screens[_index],
      bottomNavigationBar: Container(
        height: 84,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 8.9,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: 84,
              width: double.infinity,
              // padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.grey.withOpacity(0.5),
              //       spreadRadius: 1,
              //       blurRadius: 7,
              //       offset: const Offset(0, 3),
              //     ),
              //   ],
              // ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customIconButton('assets/icon/house-door.png', 'Home', 0,
                      _index, () => onTap(0)),
                  customIconButton('assets/icon/calendar-range.png', 'Agenda',
                      1, _index, () => onTap(1)),
                  const SizedBox(width: 40),
                  customIconButton('assets/icon/list-task.png', 'Task', 3,
                      _index, () => onTap(3)),
                  customIconButton('assets/icon/person.png', 'Profile', 4,
                      _index, () => onTap(4)),
                ],
              ),
            ),
            Positioned(
              bottom: 5,
              child: GestureDetector(
                onTap: () => onTap(2),
                child: Container(
                  height: 56,
                  width: 56,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD4292C),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTap(int index) {
    setState(() {
      _index = index;
    });
  }
}

Widget customIconButton(String assetPath, String text, int index,
    int selectedIndex, VoidCallback onTap) {
  bool isSelected = index == selectedIndex;
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            isSelected ? const Color(0xFFD4292C) : Colors.grey,
            BlendMode.srcIn,
          ),
          child: Image.asset(
            assetPath,
            height: 24,
            width: 24,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: isSelected ? const Color(0xFFD4292C) : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
            fontSize: 10,
          ),
        ),
      ],
    ),
  );
}
