import 'package:crm_track/cubit/task/task_cubit.dart';
import 'package:crm_track/ui/pages/agenda.dart';
import 'package:crm_track/ui/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => TaskCubit()),
        ],
        child: AgendaPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
