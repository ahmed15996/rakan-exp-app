part of 'contact_and_report_cubit.dart';

@immutable
abstract class ContactAndReportState {}

class ContactAndReportInitial extends ContactAndReportState {}
class ContactAndReportUpdate extends ContactAndReportState {}
class ContactAndReportLoading extends ContactAndReportState {}
class ContactAndReportSuccess extends ContactAndReportState {
  final String msg;

  ContactAndReportSuccess({required this.msg}){
    showToast(text: msg, state: ToastStates.success);
  }
}
class ContactAndReportFailed extends ContactAndReportState {
  final String msg;

  ContactAndReportFailed({required this.msg});
}
