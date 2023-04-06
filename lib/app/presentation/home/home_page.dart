// ignore_for_file: depend_on_referenced_packages, must_be_immutable, use_build_context_synchronously

import 'package:ct_micro_app_marketplace/app/marketplace_routers.dart';
import 'package:ct_micro_app_marketplace/app/presentation/home/home_controller.dart';
import 'package:ct_micro_app_marketplace/app/presentation/home/widgets/body_list.dart';
import 'package:flutter/material.dart';
import 'package:ct_micro_commons_ds/ct_micro_commons_ds.dart';
import 'package:ct_micro_app_help_center/app/presentation/help_center_widget/help_center_widget.dart';
import 'package:ct_micro_commons_dependencies/ct_micro_commons_dependencies.dart';
import 'package:ct_micro_commons_shared/ct_micro_commons_shared.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CuiaAppBar(title: "Store"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CuiaTextFormField(
              //   controller: TextEditingController(),
              //   hintText: "Pesquisar",
              // ),
              // const CategoriesWidget(),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FutureBuilder(
                    future: _controller.getAllApps(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Skeleton(
                            isLoading: true,
                            skeleton: SkeletonItem(
                              child: MarketplaceBodyList.loading(12),
                            ),
                            child: Container(),
                          );
                        case ConnectionState.active:
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Container();
                          } else {
                            return CuiaGridRow(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: snapshot.data!.map((e) {
                                return CuiaGridColumn(
                                  xl: 2,
                                  lg: 3,
                                  md: 4,
                                  sm: 6,
                                  xs: 6,
                                  child: ItemWidget(appDto: e),
                                );
                              }).toList(),
                            );
                          }
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
      endDrawer: const Drawer(
        backgroundColor: Colors.white,
        width: 500,
        child: HelpCenterWidget(),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.appDto,
  });

  final AppDto appDto;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => MarketplaceRouters.goToDetails(appDto.id),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 228,
            height: 291,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xff2196f3),
                width: 1,
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: appDto.imageUrl != ""
                      ? Image.network(appDto.imageUrl)
                      : Image.asset(
                          '/assets/images/system_page.png',
                          package: 'ct_micro_commons_shared',
                          width: 168,
                        ),
                ),
                const SizedBox(height: 3),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 228,
                        child: Text(
                          appDto.title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      SizedBox(
                        width: 208,
                        child: Text(
                          appDto.description,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: const Color(0xff8f8f8f),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (appDto.hasAccess)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.88),
                            color: const Color(0xff8f8f8f),
                          ),
                          padding: const EdgeInsets.all(9),
                          child: Text(
                            "Comprado",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 10.67,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      else
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.88),
                            color: const Color(0xff007dfa),
                          ),
                          padding: const EdgeInsets.all(9),
                          child: Text(
                            "Saiba mais",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 10.67,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      const SizedBox(height: 3),
                      Text(
                        appDto.amount.toString().currency(),
                        textAlign: TextAlign.right,
                        style: GoogleFonts.poppins(
                          color: const Color(0xff007dfa),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
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
    );
  }
}

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CuiaButtons.link(
            "Recomendado",
            onTap: () {},
          ),
          const SizedBox(width: 20),
          CuiaButtons.link(
            "Gestão",
            onTap: () {},
            color: Colors.black,
          ),
          const SizedBox(width: 20),
          CuiaButtons.link(
            "Finanças",
            onTap: () {},
            color: Colors.black,
          ),
          const SizedBox(width: 20),
          CuiaButtons.link(
            "Lojas",
            onTap: () {},
            color: Colors.black,
          ),
          const SizedBox(width: 20),
          CuiaButtons.link(
            "Estoque",
            onTap: () {},
            color: Colors.black,
          ),
          const SizedBox(width: 20),
          CuiaButtons.link(
            "Grátis",
            onTap: () {},
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
