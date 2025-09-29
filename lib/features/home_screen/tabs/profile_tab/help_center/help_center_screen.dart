import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../Utilites/app_style/style.dart';
import '../../../../../core/router/router.dart';
import '../../../../../core/widgets/setting_app_bar.dart';
import '../../../../../shared/shared_widget.dart';
import '../widgets/question_card.dart';

class HelpCenterScreen extends StatelessWidget {
  HelpCenterScreen({super.key});

  final TextEditingController searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SettingAppBar(title: "الاسئلة الشائعة"),
              SizedBox(height: 35.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 27.w),
                child: Column(
                  children: [
                    CustomTextFormField(
                      hintText: "ابحث عن ما يدور ببالك.......",
                      controller: searchCtrl,
                      colorBorder: Color(0xffDADADA),
                      radius: 24.r,
                      prefixIcon: Icon(Icons.search, color: AppStyle.primaryColor),
                    ),
                    SizedBox(height: 25.h,),
                    QuestionCard(
                      title: "كم من الوقت تحتاجون للوصول؟",
                      subtitle: "الحجز السريع: 15-30 دقيقة",
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.questionScreen);
                      },
                    ),
                    SizedBox(height: 25.h,),
                    QuestionCard(
                      title: "ما هي طرق الدفع المتاحة؟",
                      subtitle: "بطاقات الائتمان والخصم (فيزا، ماستركارد)",
                    ),
                    SizedBox(height: 25.h,),
                    QuestionCard(
                      title: "كم من الوقت تحتاجون للوصول؟",
                      subtitle: "الحجز السريع: 15-30 دقيقة",
                    ),
                    SizedBox(height: 25.h,),
                    QuestionCard(
                      title: "ما هي طرق الدفع المتاحة؟",
                      subtitle: "بطاقات الائتمان والخصم (فيزا، ماستركارد)",
                    ),
                    SizedBox(height: 25.h,),
                    QuestionCard(
                      title: "كم من الوقت تحتاجون للوصول؟",
                      subtitle: "الحجز السريع: 15-30 دقيقة",
                    ),
                    SizedBox(height: 25.h,),
                    QuestionCard(
                      title: "ما هي طرق الدفع المتاحة؟",
                      subtitle: "بطاقات الائتمان والخصم (فيزا، ماستركارد)",
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

