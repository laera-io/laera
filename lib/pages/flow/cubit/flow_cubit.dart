import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'flow_state.dart';

class FlowCubit extends Cubit<FlowState> {
  FlowCubit() : super(const FlowState());

  void accept() {
    log('the card has been accepted');
    emit(state.inc());
  }

  void reject() {
    log('the card has been rejected');
    emit(state.inc());
  }
}
