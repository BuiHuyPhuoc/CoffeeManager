import 'package:coffee_house/core/constants.dart';
import 'package:coffee_house/models/order_detail.dart';
import 'package:coffee_house/models/order_log.dart';
import 'package:coffee_house/models/order_status.dart';
import 'package:coffee_house/providers/order_detail_provider.dart';
import 'package:coffee_house/providers/order_status_provider.dart';
import 'package:coffee_house/service/APIService.dart';
import 'package:coffee_house/service/order_service.dart';
import 'package:coffee_house/widget/custom_button.dart';
import 'package:coffee_house/widget/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends ConsumerWidget {
  OrderDetailScreen({Key? key, required this.orderId}) : super(key: key);
  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderDetail = ref.watch(orderDetailProvider(orderId));
    final List<OrderStatus> orderStatus = ref.watch(orderStatusProvider);

    OrderStatus? getCurrentOrderStatus;
    OrderStatus? getNextOrderStatus;

    if (orderDetail != null) {
      getCurrentOrderStatus = orderDetail.orderLogs.last.statusCodeNavigation;
      getNextOrderStatus = orderStatus.firstWhere(
          (status) => status.index == (getCurrentOrderStatus!.index + 1),
          orElse: () => OrderStatus(
              statusCode: "DONE", statusName: "Đã hoàn thành", index: 0));
    }

    ChangeOrderStatus(int orderId, OrderStatus? getNextOrderStatus) async {
      // Implement change order status here
      if (getNextOrderStatus?.statusCode == "DONE") {
        NotifyToast(
          context: context,
          message: "Đơn hàng đã hoàn thành, không thể thay đổi trạng thái",
        ).ShowToast();
        return;
      }
      ApiService apiService = ApiService();
      var data = {
        "orderId": orderId,
        "statusCode": getNextOrderStatus!.statusCode,
      };
      var resposne =
          await apiService.post(ENDPOINT.CHANGEORDERSTATUS, data: data);

      if (resposne.status == 200) {
        print("Change order status success");
        ref.invalidate(orderStatusProvider);
        ref.invalidate(orderDetailProvider(orderId));
        SuccessToast(
          context: context,
          message: resposne.message ?? "",
        ).ShowToast();
      } else {
        WarningToast(
          context: context,
          message: resposne.message ?? "",
        ).ShowToast();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          'Chi Tiết Đơn Hàng',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: (orderDetail == null)
          ? Container(
              child: Center(
                child: Text("No data"),
              ),
            )
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Đơn hàng #${orderDetail.id}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ngày đặt: ${DateFormat("dd/MM/yyyy HH:mm:ss").format(orderDetail.orderDate)}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Trạng thái đơn hàng:',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      OrderTimeline(
                        steps: orderDetail.orderLogs,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 8),
                    itemCount: orderDetail.orderDetails.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, thickness: 1),
                    itemBuilder: (context, index) {
                      final item = orderDetail.orderDetails[index];
                      return _buildCartItem(item);
                    },
                  ),
                ),

                const Divider(height: 1, thickness: 1),

                // Checkout bar
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${OrderService.calculateTotalQuantity(orderDetail)} items',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '\$${OrderService.calculatePriceOrder(orderDetail)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          text: "Cancel",
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await ChangeOrderStatus(
                                orderId, getNextOrderStatus);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          child: Text(
                            getNextOrderStatus!.statusName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildCartItem(OrderDetail item) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Image.network(item
                  .productSize.product.imageDefaultNavigation.firebaseImage),
            ),
          ),
          const SizedBox(width: 12),

          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Trà sữa",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${item.productSize.product.productName} (${item.productSize.size})",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    children: item.orderToppings
                        .map((e) => Text(
                              "+ ${e.topping.toppingName} + (${e.quantity})",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\Tổng cộng: ${OrderService.calculateOrderDetail(item)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Số lượng: ${item.quantity}",
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderTimeline extends StatelessWidget {
  final List<OrderLog> steps;

  const OrderTimeline({
    Key? key,
    required this.steps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: steps.map((step) {
        bool isLastStep = step == steps.last;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24.0,
              height: isLastStep ? 24.0 : 60.0,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  if (!isLastStep)
                    Positioned(
                      top: 12.0,
                      bottom: 0,
                      child: Container(
                        width: 2.0,
                        color: Colors.black,
                      ),
                    ),
                  Container(
                    width: 24.0,
                    height: 24.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      border: Border.all(color: Colors.black, width: 2.0),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat("dd/MM/yyyy HH:mm").format(step.timeLog),
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    step.statusCodeNavigation.statusName,
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: isLastStep ? 0 : 24.0),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class OrderTimelineStep {
  final String time;
  final String status;
  final bool isCompleted;

  OrderTimelineStep({
    required this.time,
    required this.status,
    required this.isCompleted,
  });
}
