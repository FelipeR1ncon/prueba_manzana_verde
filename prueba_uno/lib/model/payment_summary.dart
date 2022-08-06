import 'cupon.dart';

class PaymentSummary {
  double subTotal;
  double shippingCost;
  Coupon? coupon;

  getTotal() {
    return subTotal + shippingCost - getDiscountCoupon();
  }

  double getDiscountCoupon() {
    double discountCoupon = 0;

    if (coupon != null) {
      if (coupon!.code == "PORCENTAJE") {
        if (subTotal >= double.parse(coupon!.payload!["minimum"].toString())) {
          discountCoupon = subTotal *(double.parse(coupon!.payload!["value"].toString()) / 100);
        }
      } else {
        discountCoupon = double.parse(coupon!.payload!["value"].toString());
      }
    }

    return discountCoupon;
  }

  PaymentSummary(this.subTotal, this.shippingCost, {this.coupon});
}
