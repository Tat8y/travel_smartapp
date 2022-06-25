class TravelRoute {
  static const String fromFeild = 'from';
  static const String toFeild = 'to';
  static const String dateFeild = 'date';

  final String from;
  final String to;
  final DateTime date;

  TravelRoute({
    required this.from,
    required this.to,
    required this.date,
  });

  // Travel Route Data to Map
  Map<String, dynamic> toMap() => {
        fromFeild: from,
        toFeild: to,
        dateFeild: date.millisecondsSinceEpoch,
      };

  // Travel Route Data from Map
  static TravelRoute fromMap(map) => TravelRoute(
        from: map['from'],
        to: map['to'],
        date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      );
}
