import 'package:coffee_house/core/constants.dart';
import 'package:coffee_house/models/order.dart';
import 'package:coffee_house/providers/auth_state_provider.dart';
import 'package:coffee_house/service/APIService.dart';
import 'package:coffee_house/service/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderDetailNotifier extends StateNotifier<Order?> {
  final Ref _ref;

  OrderDetailNotifier(this._ref, int idOrder) : super(null) {
    fetchOrderDetail(idOrder);
  }

  Future<void> fetchOrderDetail(int idOrder) async {
    var callAPI = ApiService();
    String? token = await UserService.getToken();
    if (token == null) {
      _ref.read(authProvider.notifier).requireLogin();
      return;
    }

    callAPI.setToken(token);
    var response = await callAPI.get(ENDPOINT.GETORDERDETAIL, params: {
      'orderId': idOrder,
    });

    if (response.status == 401) {
      _ref.read(authProvider.notifier).requireLogin();
      return;
    } else if (response.isSuccess) {
      state = Order.fromMap(response.value);
    }
  }
}

final orderDetailProvider =
    StateNotifierProvider.family<OrderDetailNotifier, Order?, int>(
  (ref, idOrder) => OrderDetailNotifier(ref, idOrder),
);