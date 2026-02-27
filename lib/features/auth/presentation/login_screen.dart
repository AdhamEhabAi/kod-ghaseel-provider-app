import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_assets/assets.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/features/auth/presentation/widgets/login_form.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    // Scrolls to the max scroll extent smoothly
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = S.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: NotificationListener<SizeChangedLayoutNotification>(
        onNotification: (notification) {
          // This triggers when keyboard opens/closes
          _scrollToBottom();
          return true;
        },
        child: SizeChangedLayoutNotifier(
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.only(bottom: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(Assets.loginBanner),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12.0.w, vertical: 20.h),
                  child: Text(
                    loc.loginTitle,
                    style: AppTextStyle.blackW700Size30,
                  ),
                ),
                LoginForm(
                  onFocus: _scrollToBottom,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}