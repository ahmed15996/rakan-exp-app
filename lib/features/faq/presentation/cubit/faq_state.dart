part of 'faq_cubit.dart';

@immutable
abstract class FaqState {}

class FaqInitial extends FaqState {}
class FaqLoading extends FaqState {}
class FaqSuccess extends FaqState {}
class FaqFailed extends FaqState {
  final String msg;

  FaqFailed({required this.msg});
}
