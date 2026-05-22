import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';

import '../../Utilites/app_fonts/font.dart';
import '../../Utilites/app_style/style.dart';
import '../../core/widgets/app_loader.dart';
import '../../generated/l10n.dart';


class ChatScreen extends StatefulWidget {
   const ChatScreen({super.key, required this.userName, this.avatar, required this.userId});

  final String userName;
  final String? avatar;
  final String userId;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String currentProviderId;
  late String chatId;

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final userString = AppSharedPreferences.getString(SharedPreferencesKeys.userModel);
    final userMap = jsonDecode(userString ?? '{}') as Map<String, dynamic>;
    currentProviderId = (userMap['id'] ?? '').toString();
    final List<String> ids = [currentProviderId, widget.userId];
    ids.sort();
    chatId = ids.join('_');
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
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
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('chats')
                        .doc(chatId)
                        .collection('messages')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                      if (!snapshot.hasData) {
                        return SliverToBoxAdapter(
                          child: Center(child: AppLoader()),
                        );
                      }

                      final docs = snapshot.data!.docs;

                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final data = docs[index].data() as Map<String, dynamic>;
                            final bool isMe = (data['senderId'] as String?) == currentProviderId;
                            final Timestamp? timestamp = data['timestamp'] as Timestamp?;
                            String formattedTime = '';
                            if (timestamp != null) {
                              formattedTime = DateFormat('h:mm a').format(timestamp.toDate());
                            }
                            return Align(
                              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: isMe ? AppStyle.primaryColor : AppStyle.white,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: isMe
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      (data['text'] as String?) ?? '',
                                      style: TextStyle(
                                        color: isMe ? Colors.white : Colors.black,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    if (formattedTime.isNotEmpty)
                                      Padding(
                                        padding: EdgeInsets.only(top: 5.h),
                                        child: Text(
                                          formattedTime,
                                          style: TextStyle(
                                            color: isMe ? Colors.white : Colors.black54,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: docs.length,
                        ),
                      );
                    },
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
                        decoration: InputDecoration(
                          hintText: s.writeMessage,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: sendMessage,
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

  Future<void> sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty || text.length > 1000) return;

    _controller.clear();

    final messageRef = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc();

    await messageRef.set({
      'senderId': currentProviderId,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
      'isSeen': false,
    });

    await FirebaseFirestore.instance.collection('chats').doc(chatId).set({
      'participants': {
        currentProviderId: true,
        widget.userId: true,
      },
      'lastMessage': text,
      'lastMessageTime': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
