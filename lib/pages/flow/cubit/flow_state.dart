part of 'flow_cubit.dart';

@immutable
class FlowState {
  const FlowState([this.wordIndex = 0]);

  FlowState inc() => FlowState(wordIndex + 1);

  final int wordIndex;
}
