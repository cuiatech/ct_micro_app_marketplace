import 'package:ct_micro_app_marketplace/app/marketplace_routers.dart';
import 'package:ct_micro_app_marketplace/app/presentation/cart/cart_controller.dart';
import 'package:ct_micro_app_marketplace/app/presentation/cart/cart_page.dart';
import 'package:ct_micro_app_marketplace/app/presentation/details/details_controller.dart';
import 'package:ct_micro_app_marketplace/app/presentation/details/details_page.dart';
import 'package:ct_micro_app_marketplace/app/presentation/home/home_controller.dart';
import 'package:ct_micro_app_marketplace/app/presentation/home/home_page.dart';
import 'package:ct_micro_commons_dependencies/ct_micro_commons_dependencies.dart';

class MarketplaceModule extends Module {
  @override
  final List<Bind> binds = [
    // Controllers
    $HomeController,
    $DetailsController,
    $CartController,
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      RoutersName.index,
      child: (_, args) => const HomePage(),
      transition: TransitionType.noTransition,
    ),
    ChildRoute(
      '${RoutersName.details}/:id',
      child: (_, args) => DetailsPage(id: int.parse(args.params['id'])),
      transition: TransitionType.noTransition,
    ),
    ChildRoute(
      RoutersName.myCart,
      child: (_, args) => const CartPage(),
      transition: TransitionType.noTransition,
    ),
  ];
}
