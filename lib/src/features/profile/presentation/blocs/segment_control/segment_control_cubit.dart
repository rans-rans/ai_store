import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

part 'segment_control_state.dart';

class CollectionsSegmentControl extends Cubit<int> {
  CollectionsSegmentControl() : super(0);

  void changeSegment(int newIndex) {
    emit(newIndex);
  }
}
