// ignore_for_file: depend_on_referenced_packages

import 'package:ct_micro_commons_dependencies/ct_micro_commons_dependencies.dart';

class MarketplaceRouters {
  static goToIndex() => Modular.to.navigate('/marketplace${RoutersName.index}');
}

class RoutersName {
  static String index = "/";
}
