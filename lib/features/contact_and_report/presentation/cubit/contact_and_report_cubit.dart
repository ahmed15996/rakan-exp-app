import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/widgets/custom_toast.dart';
import 'package:rakaan/features/contact_and_report/data/params/contact_and_report_param.dart';
import 'package:rakaan/features/contact_and_report/data/repository/contact_and_report_repository.dart';

import '../../../../generated/locale_keys.g.dart';

part 'contact_and_report_state.dart';

@injectable
class ContactAndReportCubit extends Cubit<ContactAndReportState> {
  ContactAndReportCubit(this.repository) : super(ContactAndReportInitial());
  final ContactAndReportRepository repository;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String msgType = LocaleKeys.suggestion.tr();
  List<String> messageTypeList = [
  LocaleKeys.suggestion.tr(),
   LocaleKeys.report.tr(),
  ];

  selectType({required String type}) {
    msgType = type;
    emit(ContactAndReportUpdate());
  }

  void addContact({required BuildContext context}) async {
    emit(ContactAndReportLoading());
    var result = await repository.addContactAndReport(
      param: ContactAndReportParam(
        name: nameController.text,
        email: emailController.text,
        message: messageController.text,
        subject: msgType == LocaleKeys.suggestion.tr() ? "suggestion" : "complaint",
      ),
    );
    result.fold((failure) {
      emit(ContactAndReportFailed(msg: failure.message));
    }, (msg) {
      context.pop();
      emit(ContactAndReportSuccess(msg: msg));
    });
  }
}
