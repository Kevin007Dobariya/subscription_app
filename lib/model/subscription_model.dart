
class SubscriptionModel {
  final String name;
  final String username;
  final DateTime startDate;
  final DateTime endDate;

  SubscriptionModel({
    required this.name,
    required this.username,
    required this.startDate,
    required this.endDate,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }
}