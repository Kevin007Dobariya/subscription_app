import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:rxdart/rxdart.dart';

import '../../../model/subscription_model.dart';

class UserListController extends GetxController {
  final BehaviorSubject<List<SubscriptionModel>> _subscriptionsSubject =
      BehaviorSubject.seeded([]);
  RxBool isLoading=false.obs;
  ValueStream<List<SubscriptionModel>> get subscriptions =>
      _subscriptionsSubject.stream;

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  @override
  void onInit() {


    fetchSubscriptions();
    super.onInit();
  }

  void fetchSubscriptions() {
    isLoading.value=true;
    users.snapshots().listen((snapshot) {
      final subscriptions = snapshot.docs.map((doc) {
        return SubscriptionModel(
          name: doc['name'],
          username: doc['username'],
          startDate: (doc['startDate'] as Timestamp).toDate(),
          endDate: (doc['endDate'] as Timestamp).toDate(),
        );
      }).toList();
      _subscriptionsSubject.add(subscriptions);
    });
    isLoading.value=false;
  }
}
