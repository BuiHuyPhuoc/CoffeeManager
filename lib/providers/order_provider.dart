import 'package:coffee_house/core/constants.dart';
import 'package:coffee_house/models/order.dart';
import 'package:coffee_house/service/APIService.dart';
import 'package:coffee_house/service/signalr_service.dart';
import 'package:coffee_house/service/user_service.dart';
import 'package:riverpod/riverpod.dart';

class OrderNotifier extends StateNotifier<List<Order>> {
  final SignalRService _signalRService;

  OrderNotifier(this._signalRService) : super([]) {
    _init();
  }

  void _init() {
    fetchOrders();
    _signalRService.onOrderUpdated = fetchOrders;
    _signalRService
        .initSignalR();
  }

  Future<void> fetchOrders() async {
    var callAPI = ApiService();
    String? token = await UserService.getToken();
    if (token == null) {
      return;
    }

    callAPI.setToken(token);
    var response = await callAPI.get(ENDPOINT.GETORDER);

    if (response.status == 401) {
      return;
    } else if (response.isSuccess) {
      state =
          (response.value as List).map((item) => Order.fromMap(item)).toList();
    }
  }

  void listenForOrderUpdates() {
    _signalRService.onOrderUpdated = fetchOrders;
    _signalRService.startConnection();
  }
}

final orderProvider = StateNotifierProvider<OrderNotifier, List<Order>>(
  (ref) {
    final signalRService = ref.watch(signalRProvider);
    return OrderNotifier(signalRService);
  },
);
