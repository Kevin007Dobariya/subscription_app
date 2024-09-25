import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/comman_widget/PvjTextWidget.dart';
import 'controller/user_list_controller.dart';
import '../add_subscriber/add_user_screen.dart';

class UserListScreens extends StatelessWidget {
  UserListScreens({super.key});

  final UserListController controller =
      Get.put(UserListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const HeadlineBodyOneBaseWidget('Subscription Tracker')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddSubscriptionScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CupertinoActivityIndicator())
            : controller.subscriptions.value.isEmpty
                ? const Center(child: HeadlineBodyOneBaseWidget("No subscriber data found"))
                : ListView.builder(
                    itemCount: controller.subscriptions.value.length,
                    itemBuilder: (context, index) {
                      final subscription =
                          controller.subscriptions.value[index];
                      return ListTile(
                        title: HeadlineBodyOneBaseWidget(
                            '${subscription.name} (${subscription.username})'),
                        subtitle: HeadlineBodyOneBaseWidget('End Date: ${subscription.endDate}'),
                      );
                    },
                  );
      }),
    );
  }
}
