enum NotificationCode {
  scheduleTripHour('1'),

  unknown('');

  final String code;
  const NotificationCode(this.code);

  static NotificationCode fromCode(String code) {
    return NotificationCode.values.firstWhere(
      (e) => e.code == code,
      orElse: () => NotificationCode.unknown,
    );
  }
}
