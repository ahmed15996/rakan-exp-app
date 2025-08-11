part of 'statics_cubit.dart';

@immutable
abstract class StaticsState {}

class StaticsInitial extends StaticsState {}
class StaticsLoading extends StaticsState {}
class StaticsSuccess extends StaticsState {}
class StaticsFailed extends StaticsState {
  final String msg;

  StaticsFailed({required this.msg});
}

