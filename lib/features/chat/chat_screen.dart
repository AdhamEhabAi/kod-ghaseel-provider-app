import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../Utilites/app_fonts/font.dart';
import '../../Utilites/app_style/style.dart';
import '../../generated/l10n.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.userName, this.avatar});

  final String userName;
  final String? avatar;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {
      "text": "أنا بالطريق لك، أوصل خلال 15 دقيقة إن شاء الله.",
      "type": "driver",
      "time": "09:10",
    },
    {
      "text": "تمام، أنا موجود عند البيت. إذا ما عرفت المكان دق علي.",
      "type": "user",
      "time": "09:12",
    },
    {
      "text": "خلصت الغسيل. السيارة جاهزة. شوفها وإذا عندك أي ملاحظات بلغني.",
      "type": "driver",
      "time": "10:13",
    },
    {"text": "ممتاز شغل مرتب 🔥 شكرًا لك!", "type": "user", "time": "10:14"},
    {
      "text": "الشكر لك لاختيارك كود غسيل. يومك سعيد 🌟",
      "type": "driver",
      "time": "10:15",
    },
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients &&
        _scrollController.position.hasContentDimensions) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    var s=S.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyle.grey,
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              height: 60.h,
              decoration: BoxDecoration(
                color: AppStyle.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppStyle.grey, width: 1),
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.userName,
                          style: AppTextStyle.blackW600Size16Roboto,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => GoRouter.of(context).pop(),
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.white,
                          border: Border.all(color: AppStyle.grey),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 20.w,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                reverse: true,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final message = _messages[_messages.length - index - 1];
                      final bool isUser = message["type"] == "user";

                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: isUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 4.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 10.h,
                              ),
                              constraints: BoxConstraints(maxWidth: 280.w),
                              decoration: BoxDecoration(
                                color: isUser
                                    ? AppStyle.primaryColor
                                    : AppStyle.white,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    message["text"],
                                    style: TextStyle(
                                      color: isUser
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Text(
                                    message["time"],
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: isUser
                                          ? Colors.white
                                          : Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }, childCount: _messages.length),
                  ),

                  SliverToBoxAdapter(child: SizedBox(height: 70.h)),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 10.h),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: AppStyle.white,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: TextField(
                        controller: _controller,
                        style: TextStyle(fontSize: 14.sp),
                        decoration:  InputDecoration(
                          hintText:s.writeMessage,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundColor: AppStyle.primaryColor,
                      radius: 24.r,
                      child: Icon(Icons.send, color: Colors.white, size: 20.sp),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
