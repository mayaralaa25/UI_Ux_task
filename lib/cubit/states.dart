abstract class AppStates {}

class InitialAppState extends AppStates {}

class AppBottomNavState extends AppStates {}

class GetUsersLoadingState extends AppStates {}

class GetUsersSuccessState extends AppStates {}

class GetUsersErrorState extends AppStates {
  final String error;
  GetUsersErrorState(this.error);
}