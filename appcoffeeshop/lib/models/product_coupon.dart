
class ProductCoupon {
  int? id;
  int? idCoupon;
  int? idProduct;

  ProductCoupon({this.id, this.idCoupon, this.idProduct});

  ProductCoupon.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    idCoupon = int.parse(json['id_coupon']);
    idProduct = int.parse(json['id_product']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_coupon'] = this.idCoupon;
    data['id_product'] = this.idProduct;
    return data;
  }
}
