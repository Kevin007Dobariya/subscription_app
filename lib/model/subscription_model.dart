class SubscriptionModel {
  final String name;
  final String username;
  final DateTime startDate;
  DateTime? endDate;
  int leavesDays = 0;
  List<String>? fixedWeekdayLeaves;

  SubscriptionModel({
    required this.name,
    required this.username,
    required this.startDate,
    required this.fixedWeekdayLeaves,
  }) {
    DateTime calculateRenewalDate(DateTime start) {
      return DateTime(start.year, start.month + 1, start.day);
    }
    // Calculate the dynamic end date based on the month and start date
    endDate = calculateRenewalDate(startDate);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate!.toIso8601String(),
      'Leaves': leavesDays,
      'fixedWeekdayLeaves': fixedWeekdayLeaves,
    };
  }
}
