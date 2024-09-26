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
  RxList<String> fixedWeekdayLeaves = <String>[].obs;
  Rxn<DateTime> selectedStartDate = Rxn<DateTime>(null);
  Rxn<DateTime> endDate = Rxn<DateTime>(null);
  Rxn<DateTime> selectedEndDate = Rxn<DateTime>(null);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<String> selectedWeekdays = <String>[].obs;
  RxMap<String, bool> tempSelection = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
  }.obs;

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  @override
  void onInit() {
    skipController.text = "0";
    super.onInit();
  }

  conformFixWeekDays(Map<String, bool> tempSelection) {
    selectedWeekdays.value =
        tempSelection.keys.where((day) => tempSelection[day] == true).toList();
  }

  setWeekDay(String weekday, bool? value) {
    tempSelection[weekday] = value ?? false;
  }

  // void extendEndDateWithLeaves(List<DateTime> randomLeaves) {
  //   int extraDays = skippedDays; // Start with the skipped days
  //   DateTime newEndDate = endDate;
  //
  //   // For each skipped day, find the next available non-leave day
  //   while (extraDays > 0) {
  //     newEndDate = newEndDate.add(Duration(days: 1));
  //
  //     // If it's a fixed leave day, extend and count it as an extra day
  //     if (isFixedLeaveDay(newEndDate)) {
  //       extraDays++;
  //       continue;
  //     }
  //
  //     // If it's a random leave day, skip it
  //     if (randomLeaves.contains(newEndDate)) continue;
  //
  //     // Reduce extra day count if the day is valid (not a fixed leave or random leave)
  //     extraDays--;
  //   }
  //
  //   // Update the end date
  //   endDate = newEndDate;
  // }
  //
  // // Add random leave and increase skipped days
  // void addRandomLeave(DateTime leaveDate) {
  //   // Ensure the leave day isn't on a fixed leave day (Sunday or fixed weekday)
  //   if (isFixedLeaveDay(leaveDate)) {
  //     print("Can't take a leave on a fixed leave day.");
  //     return;
  //   }
  //
  //   skippedDays++;
  // }

  void addSubscription() {
    if (formKey.currentState!.validate()) {
      if (selectedStartDate.value != null) {
        final subscription = SubscriptionModel(
          name: nameController.text,
          username: usernameController.text,
          startDate: selectedStartDate.value!,
          fixedWeekdayLeaves: fixedWeekdayLeaves,
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
