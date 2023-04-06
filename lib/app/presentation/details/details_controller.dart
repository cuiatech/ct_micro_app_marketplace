// ignore_for_file: unused_import, depend_on_referenced_packages, use_build_context_synchronously

import 'package:ct_micro_app_marketplace/app/marketplace_routers.dart';
import 'package:ct_micro_commons_shared/ct_micro_commons_shared.dart';
import 'package:ct_micro_commons_core_app/app/domain/usecases/app_checkout_usecase.dart';
import 'package:ct_micro_commons_ds/ct_micro_commons_ds.dart';
import 'package:ct_micro_commons_dependencies/ct_micro_commons_dependencies.dart';
import 'package:flutter/material.dart';

final $DetailsController = Bind.lazySingleton(
  (i) => DetailsController(i()),
);

class DetailsController {
  DetailsController(this._appCheckoutUsecase);
  final AppCheckoutUsecase _appCheckoutUsecase;

  void accessApp(AppDto appDto) async {
    Modular.to.pushNamed(appDto.url);
  }

  Future buyApp(BuildContext context, int appId, {int? quantity}) async {
    var res = await _appCheckoutUsecase(appId, quantity: quantity);

    if (!res.success) {
      CuiaToast.error(res.message ?? 'error-generic'.i18n(), context: context);
      return;
    }

    MarketplaceRouters.goToCheckout();

    return res.data;
  }
}
