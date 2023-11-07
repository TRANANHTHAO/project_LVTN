import 'package:http/http.dart' as http;

class APIConnection {
  static const hostConnect = "http://192.168.1.7";

  static const webIP = "http://127.0.0.1:8000";

  static String getImgUrl(String imgName)
    => webIP + "/uploads/product/$imgName";

  static const Duration timeOut = Duration(seconds: 10);

  // Future<http.Response?> getData() async {
  //   String url = "${hostConnect}/mycoffee_api/products/all_products.php";
  //   // url = hostConnect;
  //   return await http.get(Uri.parse(url));
  // }

  Future<http.Response?> getAllProducts() async {
    String url = "${hostConnect}/mycoffee_api/products/all_products.php";
    return await http.get(Uri.parse(url));
  }

  Future<http.Response?> getCategories() async {
    String url = "${hostConnect}/mycoffee_api/categories/categories.php";
    return await http.get(Uri.parse(url));
  }

  Future<http.Response?> getCoupon() async {
    String url = "${hostConnect}/mycoffee_api/products/coupon.php";
    return await http.get(Uri.parse(url));
  }

  Future<http.Response?> getProductCoupon() async {
    String url = "${hostConnect}/mycoffee_api/products/product_coupon.php";
    return await http.get(Uri.parse(url));
  }
}