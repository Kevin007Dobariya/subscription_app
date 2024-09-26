import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:p_v_j/utils/methods/methods.dart';

import '../../utils/comman_widget/PvjTextWidget.dart';
import '../../utils/comman_widget/pvj_underline_tf.dart';
import 'controller/add_subscriber_controller.dart';

class AddSubscriptionScreen extends StatelessWidget {
  final AddSubscriberController controller = Get.put(AddSubscriberController());

  AddSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const HeadlineBodyOneBaseWidget('Add Subscriber')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PvjUnderlineTf(
                  controller: controller.nameController,
                  labelText: 'Name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                PvjUnderlineTf(
                  controller: controller.usernameController,
                  labelText: 'email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+")
                        .hasMatch(value)) {
                      return 'Invalid email format';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                PvjUnderlineTf(
                  controller: controller.skipController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  keyboardType: TextInputType.number,
                  labelText: 'leaves',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a leave days';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade200,
                    // Set the desired color here
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      controller.createSubscription(pickedDate);
                    }
                  },
                  child: const HeadlineBodyOneBaseWidget(
                    "Select Subscription",
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade200,
                    // Set the desired color here
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    showWeekDaysDialog(context, controller);
                  },
                  child: const HeadlineBodyOneBaseWidget(
                      "Select Fixed Leave Days"),
                ),
                const SizedBox(height: 20),
                const HeadlineBodyOneBaseWidget(
                  'Fixed week Leave Days:',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10),
                Obx(() {
                  return HeadlineBodyOneBaseWidget(
                      controller.selectedWeekdays.isEmpty
                          ? 'No leave days selected'
                          : controller.selectedWeekdays.join(', '),
                      fontSize: 16);
                }),
                const SizedBox(height: 20),
                // Button to open the popup

                Obx(
                  () => controller.selectedStartDate.value != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const HeadlineBodyOneBaseWidget(
                              'Subscription summary',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 10),
                            HeadlineBodyOneBaseWidget(
                              "Start Date: ${UtilsMethods.localToDMMMYYYY(controller.selectedStartDate.value!.toLocal())}",
                              fontSize: 18,
                            ),
                            const SizedBox(height: 10),
                            HeadlineBodyOneBaseWidget(
                              "End Date: ${UtilsMethods.localToDMMMYYYY(controller.endDate.value!.toLocal())}",
                              fontSize: 18,
                            ),
                            const SizedBox(height: 10),
                            HeadlineBodyOneBaseWidget(
                              "Skipped Days: ${controller.skipController.value.text}",
                              fontSize: 18,
                            ),
                          ],
                        )
                      : Container(),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  return controller.selectedStartDate.value != null
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink.shade200,
                            // Set the desired color here
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.addSubscription();
                            }
                          },
                          child: const HeadlineBodyOneBaseWidget(
                            'Add Subscriber',
                            fontSize: 15,
                          ),
                        )
                      : Container();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showWeekDaysDialog(BuildContext context, AddSubscriberController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const HeadlineBodyOneBaseWidget("Select Fixed Leave Days"),
          content: WeekDaysWidget(
            controller: controller,
          ),
          actions: [
            ElevatedButton(
             style:  ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade200,
                // Set the desired color here
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // Save the selected weekdays from the dialog
                controller.conformFixWeekDays(controller.tempSelection);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const HeadlineBodyOneBaseWidget("Confirm"),
            ),
          ],
        );
      },
    );
  }
}

class WeekDaysWidget extends StatelessWidget {
  const WeekDaysWidget({super.key, required this.controller});

  final AddSubscriberController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: controller.tempSelection.keys.map((weekday) {
          return CheckboxListTile(
            title: HeadlineBodyOneBaseWidget(weekday),
            value: controller.tempSelection[weekday],
            onChanged: (bool? value) {
              controller.setWeekDay(weekday, value);
            },
          );
        }).toList(),
      );
    });
  }
}
