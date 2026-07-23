import 'dart:io';
import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:wms_app/core/constants/text.dart';
import 'package:wms_app/core/constants/server.dart';
import 'package:wms_app/feature/discover/models/discover_model.dart';
import 'package:wms_app/utilities/helpers/app_failure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wms_app/utilities/helpers/debug_print.dart';

part 'discover_repository.g.dart';

@riverpod
DiscoverRepository discoverRepository(Ref ref) {
  return DiscoverRepository();
}

class DiscoverRepository {
  final serExcep = ExceptionText();
  Future<Either<AppFailure, List<DiscoverModel>>> getBinLoc() async {
    try {
      final binRes = await http.get(
        Uri.parse('${ServerConstant.serverURL}/bin-loc'),
        headers: ServerConstant.getHeaders(),
      );

      final json = jsonDecode(binRes.body);

      if (binRes.statusCode == 200) {
        DiscoverResponse discoverRespone = DiscoverResponse.fromJson(json);
        DebugPrint(discoverRespone.data, '[BIN LOC] Response Status').log();
        return Right(discoverRespone.data);
      }

      return Left(AppFailure('${serExcep.defaultExcep} ${json['detail']}'));
    } on SocketException {
      return Left(AppFailure(serExcep.socExcep));
    } on HttpException {
      return Left(AppFailure(serExcep.httpExcep));
    } on FormatException {
      return Left(AppFailure(serExcep.forExcep));
    } catch (e) {
      return Left(AppFailure('${serExcep.defaultExcep} ${e.toString()}'));
    }
  }
}
