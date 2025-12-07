import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rakaan/core/constants/app_assets.dart';
import 'package:rakaan/core/constants/app_colors.dart';
import 'package:rakaan/core/constants/app_text_styles.dart';
import 'package:rakaan/core/util/extensions/media_query.dart';
import 'package:rakaan/core/util/extensions/on_tap.dart';
import 'package:rakaan/core/util/extensions/padding.dart';
import 'package:rakaan/core/widgets/custom_button.dart';
import 'package:rakaan/core/widgets/custom_error.dart';
import 'package:rakaan/core/widgets/custom_text_form_field.dart';
import 'package:rakaan/features/wallet/presentation/view/widgets/custom_wallet_item.dart';

import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_bottom_sheet_pay_with_moyasar.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../data/param/wallet_param.dart';
import '../cubit/wallet_cubit.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state is WalletChargingSuccess) {
          context.read<WalletCubit>().forCharge = false;
          context.read<WalletCubit>().getData();
        }
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<WalletCubit>(context);
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: LocaleKeys.wallet.tr()),
              state is WalletFailed
                  ? Expanded(child: CustomError(error: state.msg, retry: () => cubit.getData()))
                  : state is WalletLoading || state is WalletInitial?
                      ? Expanded(
                          child:
                              SizedBox(height: 32.r, width: 32.r, child: CircularProgressIndicator(color: AppColors.secondaryColor)).center)
                      : Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 24.h, right: 16.w, left: 16.w),
                                decoration: BoxDecoration(
                                    color: AppColors.whiteLightColor,
                                    boxShadow: [BoxShadow(color: AppColors.blackTextColor.withOpacity(.12),blurRadius: 4.4,offset: Offset(1, 2))],
                                    borderRadius: BorderRadius.circular(8.r)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(LocaleKeys.availableBalance.tr(),
                                            style: AppTextStyles.textStyle12
                                                .copyWith(fontWeight: FontWeight.w600, color: AppColors.grayTextColor))
                                        .withPadding(top: 16.h, start: 64.w),
                                    Row(
                                      children: [
                                        Image.asset(AppAssets.card, width: 40.r, height: 40.r).withPadding(end: 4.w),
                                        Expanded(
                                          child: Text((cubit.myBalance ?? "0") + LocaleKeys.currencySar.tr(),
                                              style: AppTextStyles.textStyle24
                                                  .copyWith(fontWeight: FontWeight.w700, color: AppColors.blackTextColor)),
                                        ),
                                        Icon(
                                          Icons.add_box_rounded,
                                          color: AppColors.primaryColor,
                                          size: 48.r,
                                        ).onTapShadow(
                                          borderRadius: BorderRadius.circular(8.r),
                                          function: () => cubit.update(),
                                        )
                                      ],
                                    ).withPadding(horizontal: 16.w, bottom: 16.h),
                                  ],
                                ),
                              ),
                              if (cubit.forCharge)
                                Expanded(
                                    child: SingleChildScrollView(
                                  padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                                  child: Form(
                                    key: cubit.formKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(AppAssets.wallet, width: 24.r, height: 24.r).withPadding(end: 8.w),
                                            Text("online pay",
                                                style: AppTextStyles.textStyle14
                                                    .copyWith(fontWeight: FontWeight.w500, color: AppColors.blackTextColor))
                                          ],
                                        ).withPadding(vertical: 16.h),
                                        CustomTextFormField(
                                          label: LocaleKeys.enterRechargeAmount.tr(),
                                          ctrl: cubit.balance,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          hintText: LocaleKeys.enterRechargeAmount.tr(),
                                          backGroundColor: AppColors.whiteLightColor,
                                        ),
                                        CustomButton(
                                          text: LocaleKeys.walletRecharge.tr(),
                                          onPressed: () {
                                            if (cubit.formKey.currentState!.validate() && (int.tryParse(cubit.balance.text) ?? 0) > 0) {
                                              showModalBottomSheet(
                                                      context: context,
                                                      constraints: BoxConstraints(maxWidth: context.width),
                                                      isScrollControlled: true,
                                                      builder: (_) =>
                                                          CustomBottomSheetPayWithMoyasar(price: int.tryParse(cubit.balance.text) ?? 1))
                                                  .then(((result) {
                                                if (result != null) {
                                                  cubit.charge(param: WalletParam(balance: cubit.balance.text, transactionId: result));
                                                }
                                              }));
                                            } else {
                                              showToast(text: LocaleKeys.enterRechargeAmount.tr(), state: ToastStates.error);
                                            }
                                          },
                                        ).withPadding(vertical: 24.h)
                                      ],
                                    ),
                                  ),
                                )),
                              if (!cubit.forCharge)
                                Text(LocaleKeys.previousTransactions.tr(),
                                        style:
                                            AppTextStyles.textStyle12.copyWith(fontWeight: FontWeight.w500, color: AppColors.grayTextColor))
                                    .withPadding(horizontal: 16.w, top: 20.h),
                              if (!cubit.forCharge)
                                Expanded(
                                    child: SingleChildScrollView(
                                  padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(cubit.list.length, (index) => CustomWalletItem(model: cubit.list[index])),
                                  ),
                                ))
                            ],
                          ),
                        )
            ],
          ),
        );
      },
    );
  }
}
