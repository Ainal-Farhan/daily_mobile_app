const List<String> _months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
];

String getCurrentLocalDateTimeStringForFileName() {
  final DateTime currDate = DateTime.now().toLocal();
  final String dateString =
      "${currDate.day}${_months[currDate.month - 1]}${currDate.year.toString().substring(2)}";

  final hourString = "${currDate.hour < 10 ? "0" : ""}${currDate.hour}";
  final minuteString = "${currDate.minute < 10 ? "0" : ""}${currDate.minute}";
  final secondString = "${currDate.second < 10 ? "0" : ""}${currDate.second}";
  final String timeString = "$hourString-$minuteString-${secondString}H";

  return "$dateString--$timeString";
}
