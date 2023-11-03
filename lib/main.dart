import 'package:figma_task/cubit/cubit.dart';
import 'package:figma_task/cubit/states.dart';
import 'package:figma_task/layout/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'network/remote/dio_helper.dart';

void main() async{
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUsers(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Sizer(
              builder: (context, orientation, deviceType){
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      selectedItemColor: Colors.red,
                      unselectedItemColor: Colors.grey,
                    ),
                    primaryColor: Colors.red,
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
                    useMaterial3: true,
                  ),
                  home: LayoutScreen(),
                );
              }
            );
      }
      ),
    );
  }
}
