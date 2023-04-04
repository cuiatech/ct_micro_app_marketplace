// ignore_for_file: depend_on_referenced_packages

import 'package:ct_micro_app_marketplace/app/presentation/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:ct_micro_commons_ds/ct_micro_commons_ds.dart';
import 'package:ct_micro_commons_dependencies/ct_micro_commons_dependencies.dart';
import 'package:ct_micro_commons_shared/shared/domain/models/dto/app_dto.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final HomeController controller = Modular.get<HomeController>();
  late AppDto appDto;

  @override
  void initState() {
    super.initState();
    appDto = controller.getDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CuiaAppBar(title: "Store"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1,
            vertical: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _leftSide(),
              _rightSide(),
            ],
          ),
        ),
      ),
    );
  }

  _leftSide() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appDto.title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "v${appDto.version}",
            style: const TextStyle(
              color: Color(0xff8f8f8f),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            "Sobre este app",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            appDto.description,
            style: const TextStyle(
              color: Color(0xff8f8f8f),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            "O que há de novo?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            appDto.releases?.first.details ?? '--',
            style: const TextStyle(
              color: Color(0xff8f8f8f),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            "Atualizado em",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            appDto.releases?.first.createdAt ?? '--',
            style: const TextStyle(
              color: Color(0xff8f8f8f),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            "Últimas atualizações",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            (appDto.releases ?? [])
                .map((e) => "v${e.version}\n${e.details}")
                .toList()
                .join('\n\n'),
            style: const TextStyle(
              color: Color(0xff8f8f8f),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  _rightSide() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Distribuído por: ${appDto.distributor}",
              style: const TextStyle(
                color: Color(0xff8f8f8f),
                fontSize: 16,
              ),
            ),
            Image.asset(
              '/assets/images/system_page.png',
              package: 'ct_micro_commons_shared',
              width: double.infinity,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CuiaButtons.elevated(
                    "Adquirir",
                    loading: false,
                    onTap: () {},
                  ),
                ),
                const Expanded(
                  child: Text(
                    "R\$ 99.999,99",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xff007dfa),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
