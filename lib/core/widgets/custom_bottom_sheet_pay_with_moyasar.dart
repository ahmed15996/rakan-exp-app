import 'dart:io';

import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moyasar/moyasar.dart';
import 'package:rakaan/core/util/extensions/media_query.dart';

import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../constants/app_text_styles.dart';
import '../framework/spaces.dart';

class CustomBottomSheetPayWithMoyasar extends StatelessWidget {
  final int price;

  const CustomBottomSheetPayWithMoyasar({
    super.key,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(20.r),
          topEnd: Radius.circular(20.r),
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsetsDirectional.only(bottom: !Platform.isIOS ? 20.h : 25.h),
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsetsDirectional.only(top: 10.h),
                height: 4.h,
                width: context.width * 0.136,
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
            ),
            heightSpace(30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: CreditCard(
                  locale: context.locale.languageCode == "ar" ? Localization.ar() : Localization.en(),
                  config: PaymentConfig(
                    publishableApiKey: AppConstants.moyserApiKey,
                    amount: price * 100,
                    description: 'Subscribe Now',
                    currency: 'SAR',
                  ),
                  onPaymentResult: (result) {
                    if (result is PaymentResponse) {
                      debugPrint("----- ${result.status}");
                      if (result.status == PaymentStatus.paid) {
                        debugPrint(result.id.toString());
                        debugPrint(result.invoiceId.toString());
                        debugPrint(result.ip.toString());
                        debugPrint("----- paid");
                        Navigator.pop(context, result.id.toString());
                      } else if (result.status == PaymentStatus.failed) {
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ),
            ),
            if (Platform.isIOS) ...[
              heightSpace(10.h),
              Text(
                "OR",
                style: AppTextStyles.textStyle18.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              heightSpace(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: ApplePay(
                  config: PaymentConfig(
                    applePay: ApplePayConfig(
                      label: context.locale.languageCode == "ar" ? "تطبيق EXP" : "EXP App",
                      merchantId: "merchant.com.rakaan.rakaan",
                      manual: false,
                      saveCard: true
                    ),
                    publishableApiKey: AppConstants.moyserApiKey,
                    amount: price * 100,
                    description: 'Subscribe Now',
                    currency: 'SAR',
                  ),
                  onPaymentResult: (result) {
                    debugPrint("----- $result");
                    if (result is PaymentResponse) {
                      debugPrint("----- ${result.status}");

                      debugPrint(result.id.toString());
                      debugPrint(result.invoiceId.toString());
                      debugPrint(result.ip.toString());
                      debugPrint("----- paid");
                      Navigator.pop(context, result.invoiceId);
                    }
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
