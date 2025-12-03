abstract class NotificationStates{
}
class NotificationInitState extends NotificationStates{}
class GetNotificationLoadingState extends NotificationStates{}
class GetNotificationSuccessState extends NotificationStates{}
class GetNotificationErrorState extends NotificationStates{}

class DeleteNotificationLoadingState extends NotificationStates{}
class DeleteNotificationSuccessState extends NotificationStates{
  final String message;
  DeleteNotificationSuccessState({required this.message});
}
class DeleteNotificationErrorState extends NotificationStates{}

class MarkAsReadLoadingState extends NotificationStates{}
class MarkAsReadSuccessState extends NotificationStates{
  final String message;
  MarkAsReadSuccessState({required this.message});
}
class MarkAsReadErrorState extends NotificationStates{}
class FilteredNotificationSuccessState extends NotificationStates{}
