import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<int> {
  BottomNavigationCubit() : super(0);

  void changeTab(int newIndex) {
    emit(newIndex);
  }
}
