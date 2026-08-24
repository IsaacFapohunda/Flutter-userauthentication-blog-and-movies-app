import 'package:intl/intl.dart';

String formatDate(String timeStamp) {
  return DateFormat.yMMMd().format(DateTime.parse(timeStamp));
}

String formatTime(String timeStamp) {
  return DateFormat("h:mm a").format((DateTime.parse(timeStamp)));
}

const appName = 'Springboot_flutter user app';


String truncateText(String text, {int maxLength = 15}) {
  return text.length > maxLength
      ? '${text.substring(0, maxLength)}...'
      : text;
}