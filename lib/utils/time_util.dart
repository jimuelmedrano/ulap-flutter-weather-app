String getTimeFromEpoch(epoch) {
  final dateTimeFromEpoch = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
  String hour = '${dateTimeFromEpoch.hour}';
  String minute = '${dateTimeFromEpoch.minute}';
  if (dateTimeFromEpoch.hour < 10) {
    hour = '0${dateTimeFromEpoch.hour}';
  }
  if (dateTimeFromEpoch.minute == 0) {
    minute = '${dateTimeFromEpoch.minute}0';
  }
  final String formattedTime = '$hour:$minute';
  return formattedTime;
}
