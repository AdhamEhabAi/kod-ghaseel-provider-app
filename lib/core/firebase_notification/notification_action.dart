
import 'notifications_code.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationAction {
  static final Map<NotificationCode,
          Function(Map<String, dynamic> data, RemoteMessage message)>
      notificationHandlers = {


    // NotificationCode.dismissLimitReached: (data, message) {
    //   final profileProvider = Provider.of<ProfileProvider>(
    //       AppRouter.globalNavKey.currentContext!,
    //       listen: false);
    //   profileProvider.getProfile();
    // }
  };






}
