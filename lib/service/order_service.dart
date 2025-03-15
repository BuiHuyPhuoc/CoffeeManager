import 'package:coffee_house/models/order.dart';
import 'package:coffee_house/models/order_detail.dart';
import 'package:coffee_house/models/order_log.dart';
import 'package:coffee_house/models/voucher.dart';
import 'package:coffee_house/service/product_service.dart';
import 'package:coffee_house/service/voucher_service.dart';

class OrderService {
  static double calculatePriceOrder(Order order) {
    double totalPrice = 0;

    Voucher? voucher = order.voucher;

    for (var orderDetail in order.orderDetails) {
      totalPrice += calculateOrderDetail(orderDetail);
    }

    if (voucher != null) {
      totalPrice = VoucherService.calculatePrice(voucher, totalPrice);
    }

    return totalPrice;
  }

  static double calculateOrderDetail(OrderDetail orderDetail) {
    double totalPrice = 0;

    for (var topping in orderDetail.orderToppings) {
      totalPrice += topping.topping.toppingPrice;
    }

    totalPrice += ProductService.calculatePrice(orderDetail.productSize);

    return totalPrice * orderDetail.quantity;
  }

  static int calculateTotalQuantity(Order order) {
    int totalQuantity = 0;

    for (var orderDetail in order.orderDetails) {
      totalQuantity += orderDetail.quantity;
    }

    return totalQuantity;
  }

  static OrderLog getLastOrderLog(Order order) {
    return order.orderLogs.last;
  }

  static double getTotalOrderPrice(List<Order> orders) {
    double total = 0;
    orders.forEach((order) {
      total += OrderService.calculatePriceOrder(order);
    });
    return total;
  }
}
