import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signalr_netcore/signalr_client.dart';

final signalRProvider = Provider<SignalRService>((ref) {
  return SignalRService();
});

class SignalRService {
  late HubConnection _hubConnection;
  bool isConnected = false;
  int _retryCount = 0;
  final int _maxRetries = 3;
  Function()? onOrderUpdated;

  Future<void> initSignalR() async {
    if (isConnected) return; // Tránh kết nối nhiều lần

    _hubConnection = HubConnectionBuilder()
        .withUrl("https://coffeehousee.site/orderHub",
            options: HttpConnectionOptions(
              transport: HttpTransportType.WebSockets,
            ))
        .build();

    _hubConnection.on("OrderUpdated", (List<Object?>? arguments) {
      print("📢 Nhận tín hiệu cập nhật đơn hàng");
      onOrderUpdated?.call();
    });

    _hubConnection.onclose(({Exception? error}) {
      print("🔴 Kết nối bị mất: $error");
      isConnected = false;
      _retryCount = 0;
      reconnect();
    });

    await startConnection();
  }

  Future<void> startConnection() async {
    try {
      await _hubConnection.start();
      isConnected = true;
      print("✅ Kết nối SignalR thành công");
    } catch (e) {
      print("❌ Lỗi kết nối SignalR: $e");
      isConnected = false;
      reconnect();
    }
  }

  void reconnect() {
    if (_retryCount < _maxRetries) {
      _retryCount++;
      print("🔄 Thử kết nối lại (${_retryCount}/$_maxRetries)...");
      Future.delayed(
          Duration(seconds: 2 * _retryCount), () => startConnection());
    } else {
      print(
          "❌ Không thể kết nối SignalR sau $_maxRetries lần thử. App vẫn tiếp tục chạy.");
    }
  }
}
