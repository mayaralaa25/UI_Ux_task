import 'package:figma_task/cubit/states.dart';
import 'package:figma_task/modules/assets/assets_screen.dart';
import 'package:figma_task/modules/home/home_screen.dart';
import 'package:figma_task/modules/profile/profile_screen.dart';
import 'package:figma_task/modules/support/support_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/remote/dio_helper.dart';

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

  List<dynamic> users = [];

  void getUsers() {
    emit(GetUsersLoadingState());
    if (users.isEmpty) {
      DioHelper.getData(
          url: 'users',
      ).then((value) {
        users = value.data;
        print(users[0]['name']);
        emit(GetUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetUsersErrorState(error.toString()));
      });
    } else
      emit(GetUsersSuccessState());
  }
}