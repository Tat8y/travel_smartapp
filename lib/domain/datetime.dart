bool isThisDay({required DateTime thisDate, required DateTime dateToCheck}) {
  final thisDay = DateTime(thisDate.year, thisDate.month, thisDate.day);
  final aDate = DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
  return aDate == thisDay;
}
