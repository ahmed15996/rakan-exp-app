part of 'static_page_cubit.dart';

@immutable
abstract class StaticPageState {}

class StaticPageInitial extends StaticPageState {}
class StaticPagesLoading extends StaticPageState {}

class StaticPagesSuccess extends StaticPageState {}

class StaticPagesFailed extends StaticPageState {
  final String msg;

  StaticPagesFailed({required this.msg});
}
