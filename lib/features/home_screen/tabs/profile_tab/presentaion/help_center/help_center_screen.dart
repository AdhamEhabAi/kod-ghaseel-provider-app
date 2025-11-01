import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

import '../../../../../../Utilites/app_style/style.dart';
import '../../../../../../core/router/router.dart';
import '../../../../../../core/widgets/setting_app_bar.dart';
import '../../../../../../shared/shared_widget.dart';
import '../widgets/question_card.dart'; // <— localization

class HelpCenterScreen extends StatelessWidget {
  HelpCenterScreen({super.key});

  final TextEditingController searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SettingAppBar(title: s.faq_title),
              SizedBox(height: 35.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 27.w),
                child: Column(
                  children: [
                    CustomTextFormField(
                      hintText: s.faq_search_hint,
                      controller: searchCtrl,
                      colorBorder: const Color(0xffDADADA),
                      radius: 24.r,
                      prefixIcon: Icon(Icons.search, color: AppStyle.primaryColor),
                    ),
                    SizedBox(height: 25.h),

                    // Q1
                    QuestionCard(
                      title: s.faq_q_how_long_arrive,
                      subtitle: s.faq_a_quick_booking_time,
                      onTap: () => GoRouter.of(context).push(AppRouter.questionScreen),
                    ),
                    SizedBox(height: 25.h),

                    // Q2
                    QuestionCard(
                      title: s.faq_q_payment_methods,
                      subtitle: s.faq_a_payment_methods_list,
                    ),
                    SizedBox(height: 25.h),

                    // Q3 (repeat sample)
                    QuestionCard(
                      title: s.faq_q_how_long_arrive,
                      subtitle: s.faq_a_quick_booking_time,
                    ),
                    SizedBox(height: 25.h),

                    // Q4
                    QuestionCard(
                      title: s.faq_q_payment_methods,
                      subtitle: s.faq_a_payment_methods_list,
                    ),
                    SizedBox(height: 25.h),

                    // Q5
                    QuestionCard(
                      title: s.faq_q_how_long_arrive,
                      subtitle: s.faq_a_quick_booking_time,
                    ),
                    SizedBox(height: 25.h),

                    // Q6
                    QuestionCard(
                      title: s.faq_q_payment_methods,
                      subtitle: s.faq_a_payment_methods_list,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
