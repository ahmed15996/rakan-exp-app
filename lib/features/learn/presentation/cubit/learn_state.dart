part of 'learn_cubit.dart';

@immutable
abstract class LearnState {}

class LearnInitial extends LearnState {}
class LearnLoading extends LearnState {}

class LearnSuccess extends LearnState {}

class LearnFailed extends LearnState {
  final String msg;

  LearnFailed({required this.msg});
}

