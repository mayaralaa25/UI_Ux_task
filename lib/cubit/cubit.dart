import 'package:figma_task/cubit/states.dart';
import 'package:figma_task/modules/assets/assets_screen.dart';
import 'package:figma_task/modules/home/home_screen.dart';
import 'package:figma_task/modules/profile/profile_screen.dart';
import 'package:figma_task/modules/support/support_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems =
  [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home_filled,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.dashboard_customize_outlined,
      ),
      label: 'Assets',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.support_agent,
      ),
      label: 'Support',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.perm_identity,
      ),
      label: 'Profile',
    ),
  ];

  List<Widget> screens =
  [
    HomeScreen(),
    AssetsScreen(),
    SupportScreen(),
    ProfileScreen(),
  ];
  List<String> titles =
  [
    'Home',
    'Assets',
    'Support',
    'Profile',
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    // if (index == 0) getBusiness();
    // if (index == 1) getSports();
    // if (index == 2) getScience();
    // if (index == 3) getScience();
    emit(AppBottomNavState());
  }
}