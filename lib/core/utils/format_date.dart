import 'package:intl/intl.dart';

String formateDate(DateTime date) {
  return DateFormat('d MMM, yyyy').format(date);
}
