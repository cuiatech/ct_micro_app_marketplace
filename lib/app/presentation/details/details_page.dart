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
    return Scaffold(
      appBar: const CuiaAppBar(title: "Store"),
      body: Center(
        child: Text("App: ${appDto.id} - ${appDto.title} "),
      ),
    );
  }
}
