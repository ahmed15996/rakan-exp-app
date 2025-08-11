import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_app_bar.dart';
import 'package:rakaan/core/widgets/custom_error.dart';
import 'package:rakaan/core/widgets/custom_text_form_field.dart';
import 'package:rakaan/features/chat/data/param/chat_param.dart';
import 'package:rakaan/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:rakaan/features/chat/presentation/view/widgets/custom_chat_item.dart';
import 'package:rakaan/generated/locale_keys.g.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<ChatCubit>(context);
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: LocaleKeys.customerService.tr()),
              state is GetChatFailed
                  ? Expanded(
                  child: CustomError(
                    error: state.msg,
                    retry: () => cubit.getData(),
                  ).withPadding(horizontal: 24.w))
                  : state is GetChatLoading || state is ChatInitial
                  ? Expanded(
                child: SizedBox(),
              )
                  : Expanded(
                  child: ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                      itemCount: cubit.list.length ?? 0,
                      itemBuilder: (context, index) =>
                          CustomChatItem(img: (cubit.list[index].type != "user" ? cubit.list[index].admin?.img:cubit.list[index].user?.img)??"",
                              msg: cubit.list[index].message, fromSender: cubit.list[index].type != "user" ? true : false)))
            ],
          ),
          bottomNavigationBar: Container(
            color: AppColors.whiteColor,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            margin: EdgeInsets.only(bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom),
            child: Row(
              children: [
                Expanded(
                    child: CustomTextFormField(
                        hintText: LocaleKeys.typeAMessage.tr(),
                        borderColor: AppColors.borderColor,
                        backGroundColor: AppColors.whiteLightColor,
                        ctrl: cubit.msgController)),
                Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(12.r)),
                    child: Icon(Icons.send, color: AppColors.primaryColor, size: 24.r))
                    .withPadding(start: 8.w)
                    .onTapShadow(
                    borderRadius: BorderRadius.circular(8.r),
                    function: () {
                      if (cubit.msgController.text.isNotEmpty) {
                        cubit.sendMsg(param: ChatParam(message: cubit.msgController.text));
                      }
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
