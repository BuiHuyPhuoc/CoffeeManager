import 'package:coffee_house/models/discount.dart';
import 'package:coffee_house/models/product_size.dart';

class ProductService {
  static double calculatePrice(ProductSize productSize) {
    var product = productSize.product;
    Discount? discount = product.discount;
    if (discount != null) {
      if (discount.discountType == "PERCENT") {
        return productSize.price -
            (productSize.price * discount.discountValue / 100);
      } else {
        return (productSize.price - discount.discountValue).toDouble();
      }
    } else {
      return productSize.price.toDouble();
    }
  }
}
