// ignore_for_file: depend_on_referenced_packages

import 'package:ct_micro_commons_dependencies/ct_micro_commons_dependencies.dart';

class MarketplaceRouters {
  static goToIndex() => Modular.to.navigate('/store${RoutersName.index}');
  static goToDetails(int id) =>
      Modular.to.navigate('/store${RoutersName.details}/$id');
}

class RoutersName {
  static String index = "/";
  static String details = "/details";
}
