// ignore_for_file: depend_on_referenced_packages

import 'package:ct_micro_app_marketplace/app/presentation/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:ct_micro_commons_ds/ct_micro_commons_ds.dart';
import 'package:ct_micro_commons_shared/ct_micro_commons_shared.dart';
import 'package:ct_micro_commons_dependencies/ct_micro_commons_dependencies.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final controller = Modular.get<CartController>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    await controller.getCart();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CuiaAppBar(title: "Store"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _leftPanel(size),
              const SizedBox(width: 10),
              _rightPanel(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rightPanel(Size size) {
    return Container(
      constraints: BoxConstraints(
        minHeight: size.height,
      ),
      width: size.width * 0.3,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xffD3D3D3), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Resumo",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Divider(),
          const SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                width: 260,
                height: 70,
                child: CuiaTextFormField(
                  controller: TextEditingController(),
                  hintText: 'Cupom de desconto',
                  prefixIcon: const Icon(Icons.sell),
                  onFieldSubmitted: (_) {},
                ),
              ),
              const SizedBox(width: 5),
              CuiaButtons(
                "Aplicar",
                width: 87,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Subtotal",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    controller.cartDto?.total.toString().currency() ?? '',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Text(
                        "Descontos",
                        style: TextStyle(
                          color: Color(0xff8f8f8f),
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.info_rounded, size: 15),
                    ],
                  ),
                  const Text(
                    "- R\$ 0,00",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xff8f8f8f),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Text(
                        "Taxas",
                        style: TextStyle(
                          color: Color(0xff8f8f8f),
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.info_rounded, size: 15),
                    ],
                  ),
                  const Text(
                    "+ R\$ 0,00",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xff8f8f8f),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                controller.cartDto?.total.toString().currency() ?? '',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          CuiaButtons(
            "Finalizar compra",
            width: double.infinity,
            onTap: () {},
          ),
          const SizedBox(height: 20),
          Center(
            child: CuiaButtons.link(
              "Continuar comprando",
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _leftPanel(Size size) {
    return Container(
      constraints: BoxConstraints(
        minHeight: size.height,
      ),
      width: size.width * 0.6,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xffD3D3D3), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Carrinho",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Divider(),
          Column(
            children: List.generate(controller.orderItemList.length, (index) {
              var data = controller.orderItemList[index];
              return _cartItem(
                title: data.name ?? '',
                price: data.amount.toString().currency(),
                quantity: data.quantity ?? 0,
                maxQuantity: 99,
                onChanged: (value) {
                  controller.updateQuantity(index, value ?? 1);
                  setState(() {});
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _cartItem({
    required String title,
    required String price,
    required int quantity,
    int? maxQuantity,
    Widget? image,
    Function(int?)? onChanged,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (image != null)
              image
            else
              Image.asset(
                '/assets/images/system_page.png',
                width: 117,
                height: 97,
                package: 'ct_micro_commons_shared',
              ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 97,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              price.currency(),
                              style: const TextStyle(
                                color: Color(0xff8f8f8f),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                DropdownButton(
                                  value: quantity,
                                  items: List.generate(
                                    maxQuantity ?? 1,
                                    (i) => DropdownMenuItem(
                                      value: i + 1,
                                      child: SizedBox(
                                        width: 60,
                                        child: Center(
                                          child: Text((i + 1).toString()),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onChanged: onChanged,
                                ),
                                const SizedBox(width: 10),
                                const Text("Mês"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 97,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              price.currency(),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.delete,
                                    size: 18,
                                    color: Color(0xff8f8f8f),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Remover",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xff8f8f8f),
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
