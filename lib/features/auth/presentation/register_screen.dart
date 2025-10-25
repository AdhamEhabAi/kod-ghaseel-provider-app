import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_assets/assets.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/features/auth/presentation/widgets/register_form.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = S.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Color(0xFFb3dcff),
            ),
            Positioned(top: 10.h, child: Image.asset(Assets.loginAvatar)),
            Positioned(top: 60.h, child: SvgPicture.asset(Assets.sparksLogin)),
            Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset(Assets.upperLoginHalfCircle),
            ),
            Positioned(
              bottom: -50.h,
              left: 0,
              right: 0,
              child: SvgPicture.asset(Assets.lowerHalfCircle,fit: BoxFit.fitWidth,),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0.w,
                        vertical: 20.h,
                      ),
                      child: Text(
                        loc.loginTitle,
                        style: AppTextStyle.blackW700Size30,
                      ),
                    ),

                    RegisterForm(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
