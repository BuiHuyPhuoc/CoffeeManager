import 'package:coffee_house/core/constants.dart';
import 'package:coffee_house/models/order.dart';
import 'package:coffee_house/models/order_status.dart';
import 'package:coffee_house/providers/auth_state_provider.dart';
import 'package:coffee_house/service/APIService.dart';
import 'package:coffee_house/service/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderStatusProvider extends StateNotifier<List<OrderStatus>> {
  final Ref _ref;

  OrderStatusProvider(this._ref) : super([]) {
    fetchOrderStatus();
  }

  Future<void> fetchOrderStatus() async {
    var callAPI = ApiService();
    String? token = await UserService.getToken();
    if (token == null) {
      _ref.read(authProvider.notifier).requireLogin();
      return;
    }

    callAPI.setToken(token);
    var response = await callAPI.get(ENDPOINT.GETORDERSTATUS);

    if (response.status == 401) {
      _ref.read(authProvider.notifier).requireLogin();
      return;
    } else if (response.isSuccess) {
      state = (response.value as List)
          .map((item) => OrderStatus.fromMap(item))
          .toList();
    }
  }
}

final orderStatusProvider = StateNotifierProvider<OrderStatusProvider, List<OrderStatus>>(
  (ref) => OrderStatusProvider(ref),
);
