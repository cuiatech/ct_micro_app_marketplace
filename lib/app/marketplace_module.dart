// ignore_for_file: depend_on_referenced_packages

import 'package:flut_micro_app_marketplace/app/marketplace_routers.dart';
import 'package:flut_micro_app_marketplace/app/presentation/home/home_page.dart';
import 'package:flut_micro_commons_dependencies/flut_micro_commons_dependencies.dart';

class MarketplaceModule extends Module {
  @override
  final List<Bind> binds = [
    // Controllers
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      RoutersName.index,
      child: (_, args) => const HomePage(),
      transition: TransitionType.noTransition,
    ),
  ];
}