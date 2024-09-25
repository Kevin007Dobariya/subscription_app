import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:p_v_j/utils/methods/methods.dart';

import '../../../model/subscription_model.dart';

class AddSubscriberController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController skipController = TextEditingController();
  RxList<String> fixedWeekdayLeaves=<String>[].obs;
  Rxn<DateTime> selectedStartDate = Rxn<DateTime>(null);
  Rxn<DateTime> endDate = Rxn<DateTime>(null);
  Rxn<DateTime> selectedEndDate = Rxn<DateTime>(null);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  void addSubscription() {
    if (formKey.currentState!.validate()) {
      if (selectedStartDate.value != null) {
        final subscription = SubscriptionModel(
          name: nameController.text,
          username: usernameController.text,
          startDate: selectedStartDate.value!,
          endDate: selectedStartDate.value!.add(Duration(
              days: UtilsMethods.getDaysInMonth(selectedStartDate.value!.year,
                  selectedStartDate.value!.month))),
          // Assuming 30-day subscription
        );
        users.add(subscription.toJson()).then((doc) {
          // Handle successful addition
          print('User added successfully with document ID: ${doc.id}');
        }).catchError((error) {
          // Handle errors
          print('Error adding user: $error');
        });
        Get.back();
      } else {
        Get.snackbar("Error!", "Please select subscription start date",
            snackPosition: SnackPosition.BOTTOM,
            isDismissible: true,
            padding: const EdgeInsets.all(10),
            backgroundColor: CupertinoColors.black,
            colorText: CupertinoColors.white);
      }
    }
  }
  // Helper function to check if a date is a fixed leave day
  bool isFixedLeaveDay(DateTime date) {
    // Check if the date is a Sunday (fixed company leave)
    if (date.weekday == DateTime.sunday) return true;

    // Check if the date matches any of the fixed weekday leaves
    String dayName = DateFormat('EEEE').format(date); // Get full weekday name
    if (fixedWeekdayLeaves.contains(dayName)) return true;

    return false;
  }

  void createSubscription(
    DateTime startDate,
  ) {
    endDate.value = startDate.add(Duration(
        days: (UtilsMethods.getDaysInMonth(startDate.year, startDate.month) -
            1)));
    selectedStartDate.value = startDate;
  }
}
