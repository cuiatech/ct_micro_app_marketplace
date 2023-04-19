import 'package:ct_micro_commons_dependencies/ct_micro_commons_dependencies.dart';

class MarketplaceRouters {
  static goToIndex() => Modular.to.navigate('/store${RoutersName.index}');
  static goToDetails(int id) =>
      Modular.to.navigate('/store${RoutersName.details}/$id');
  static goToCheckout() => Modular.to.navigate('/store${RoutersName.myCart}');
}

class RoutersName {
  static String index = "/";
  static String details = "/details";
  static String myCart = "/cart";
}
