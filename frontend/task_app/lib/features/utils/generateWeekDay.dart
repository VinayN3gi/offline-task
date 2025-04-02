// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

List<DateTime> generateWeekDates(int weekOffSet) {
  final toady = DateTime.now();
  DateTime startOfWeek = toady.subtract(Duration(days: toady.weekday - 1));
  startOfWeek = startOfWeek.add(Duration(days: weekOffSet * 7));

  return List.generate(7, (index)=>startOfWeek.add(Duration(days:index)));
}
