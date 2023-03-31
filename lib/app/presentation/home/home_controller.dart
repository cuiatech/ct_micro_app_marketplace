// ignore_for_file: depend_on_referenced_packages

import 'package:ct_micro_commons_core_app/app/domain/usecases/get_all_apps_usecase.dart';
import 'package:ct_micro_commons_dependencies/ct_micro_commons_dependencies.dart';
import 'package:ct_micro_commons_shared/shared/domain/models/dto/app_dto.dart';

final $HomeController = Bind.singleton(
  (i) => HomeController(i()),
);

class HomeController {
  HomeController(this._getAllAppsUsecase);

  final GetAllAppsUsecase _getAllAppsUsecase;

  List<AppDto> apps = [];

  Future<List<AppDto>> getAllApps() async {
    var res = await _getAllAppsUsecase();
    apps = res.data as List<AppDto>;
    return res.data;
  }
}
