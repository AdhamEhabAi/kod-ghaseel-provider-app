import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../data/models/get_all_notification_response.dart';
import '../data/notification_repo/notification_repo.dart';
import 'notification_state.dart';

@injectable
class NotificationCubit extends Cubit<NotificationStates> {
  NotificationRepo notificationRepo;

  List<NotificationItem> notificationList=[];
  NotificationCubit(this.notificationRepo) : super(NotificationInitState());

  Future<void> getNotification() async {
    emit(GetNotificationLoadingState());
    final result = await notificationRepo.getNotifications();

    result.fold((failure) => emit(GetNotificationErrorState()), (response) {
      emit(GetNotificationSuccessState());
      notificationList=response.data;
    });
  }

  Future<void> deleteNotification({required int notificationId}) async {
    emit(DeleteNotificationLoadingState());
    final result = await notificationRepo.deleteNotification(notificationId: notificationId);

    result.fold((failure) => emit(DeleteNotificationErrorState()), (response) {
      notificationList.removeWhere((element) => element.id==notificationId);
      emit(DeleteNotificationSuccessState(
          message: response.message
      ));
    });
  }

  Future<void> markAsRead({required int notificationId}) async {
    emit(MarkAsReadLoadingState());
    final result = await notificationRepo.markAsRead(notificationId: notificationId);

    result.fold((failure) => emit(MarkAsReadErrorState()), (response) {
      getNotification();
      emit(MarkAsReadSuccessState(
          message: response.message
      ));
    });
  }
  void filterByRead(){
    notificationList=notificationList.where((element) => element.isRead==0).toList();
    emit(FilteredNotificationSuccessState());
  }

}
