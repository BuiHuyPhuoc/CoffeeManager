import 'package:coffee_house/models/voucher.dart';

class VoucherService {
  static double calculatePrice(Voucher voucher, double totalPrice) {
    if (voucher.discountType == 'PERCENT') {
      return totalPrice * (1 - voucher.discountValue);
    } else {
      return totalPrice - voucher.discountValue;
    }
  }
}