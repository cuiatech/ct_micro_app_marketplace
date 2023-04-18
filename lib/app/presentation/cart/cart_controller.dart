// ignore_for_file: depend_on_referenced_packages

import 'package:ct_micro_commons_core_app/app/domain/usecases/get_cart_list_usecase.dart';
import 'package:ct_micro_commons_shared/ct_micro_commons_shared.dart';
import 'package:flutter_modular/flutter_modular.dart';

final $CartController = Bind.lazySingleton(
  (i) => CartController(i.get()),
);

class CartController {
  CartController(this._getCartListUsecase);

  final GetCartListUsecase _getCartListUsecase;

  CartDto? cartDto;
  List<OrderItemDto> orderItemList = [];

  Future<CartDto> getCart() async {
    var res = await _getCartListUsecase();

    if (!res.success) {
      print(res.message);
    }

    orderItemList.clear();
    orderItemList.addAll(res.data.orderItems ?? []);
    return cartDto = res.data;
  }

  updateQuantity(int index, int quantity) {
    orderItemList[index].quantity = quantity;
  }
}
