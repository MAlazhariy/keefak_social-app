import 'package:intl/intl.dart';

String getFormattedDate({DateTime? now}) {
  return DateFormat('MMMM dd, yyyy - hh:mm aa')
      .format(now??DateTime.now())
      .replaceAll('-', 'at');
}
