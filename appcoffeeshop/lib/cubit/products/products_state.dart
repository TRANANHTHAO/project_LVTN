part of 'products_cubit.dart';

class ProductsState extends Equatable {
  final List<Product> allProducts;
  final List<Categories> categories;
  final List<Coupon> coupons;
  final List<ProductCoupon> productCoupon;

  const ProductsState({
    this.allProducts = const [],
    this.categories = const [],
    this.coupons = const [],
    this.productCoupon = const [],
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    allProducts,
    categories,
    coupons,
    productCoupon
  ];

  ProductsState copyWith({
    List<Product>? allProducts,
    List<Categories>? categories,
    List<Coupon>? coupons,
    List<ProductCoupon>? productCoupon
  }) => ProductsState(
      allProducts: allProducts ?? this.allProducts,
      categories: categories ?? this.categories,
      coupons: coupons ?? this.coupons,
      productCoupon: productCoupon ?? this.productCoupon
  );

}