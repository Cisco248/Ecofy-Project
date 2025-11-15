import 'dart:io';
import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:wms_app/core/constants/text.dart';
import 'package:wms_app/core/constants/server.dart';
import 'package:wms_app/utilities/helpers/app_failure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wms_app/feature/landing/models/news_model.dart';
import 'package:wms_app/feature/landing/models/task_model.dart';
import 'package:wms_app/feature/landing/models/announce_model.dart';

part 'landing_repository.g.dart';

@riverpod
LandingRepository landingRepository(Ref ref) {
  return LandingRepository();
}

class LandingRepository {
  final serExcep = ExceptionText();

  /// ---------------------------------------------------------------------------
  /// Fetch Daily Tasks
  /// ---------------------------------------------------------------------------
  ///
  /// Retrieves the daily tasks for the authenticated user.
  ///
  /// Makes a `GET` request to **/task-data** and returns a parsed list of
  /// `TaskModel` inside an `Either<AppFailure, List<TaskModel>>`.
  ///
  /// **Success:**
  ///   Returns `Right(List<TaskModel>)`.
  ///
  /// **Failure:**
  /// - 401 Unauthorized → requires re-login
  /// - SocketException → No internet
  /// - HttpException → Server-side error
  /// - FormatException → Malformed JSON
  /// - Any other errors wrapped with a default message
  ///
  /// Example usage:
  /// ```dart
  /// final result = await ref.read(landingRepositoryProvider).getDailyTasks();
  /// ```
  Future<Either<AppFailure, List<TaskModel>>> getDailyTasks() async {
    try {
      final taskRes = await http.get(
        Uri.parse('${ServerConstant.serverURL}/task-data'),
        headers: ServerConstant.getHeaders(),
      );

      final json = jsonDecode(taskRes.body);

      if (taskRes.statusCode == 200) {
        TaskResponse taskResponse = TaskResponse.fromJson(json);

        if (kDebugMode) {
          print('Tasks Length: ${taskResponse.data.length}');
          print('Task List: ${taskResponse.data}');
        }

        return Right(taskResponse.data);
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

  /// ---------------------------------------------------------------------------
  /// Fetch Daily News
  /// ---------------------------------------------------------------------------
  ///
  /// Retrieves the latest news articles for the user.
  ///
  /// Makes a `GET` request to **/news-data** and returns a parsed `NewsModel`
  /// inside an `Either<AppFailure, NewsModel>`.
  ///
  /// **Success:**
  ///   Returns `Right(List<NewsModel>)`.
  ///
  /// **Failure:**
  /// - 401 Unauthorized → requires re-login
  /// - SocketException → No internet
  /// - HttpException → Server-side error
  /// - FormatException → Malformed JSON
  /// - Any other errors wrapped with a default message
  ///
  /// Example usage:
  /// ```dart
  /// final result = await ref.read(landingRepositoryProvider).getDailyNews();
  /// ```
  Future<Either<AppFailure, List<NewsModel>>> getDailyNews() async {
    try {
      final newsRes = await http.get(
        Uri.parse('${ServerConstant.serverURL}/news-data'),
        headers: ServerConstant.getHeaders(),
      );

      final json = jsonDecode(newsRes.body);

      if (newsRes.statusCode == 200) {
        NewsResponse newsResponse = NewsResponse.fromJson(json);

        if (kDebugMode) {
          print('News Length: ${newsResponse.data.length}');
          print('News List: ${newsResponse.data}');
        }

        return Right(newsResponse.data);
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

  /// ---------------------------------------------------------------------------
  /// Fetch Weekly Announcements
  /// ---------------------------------------------------------------------------
  ///
  /// Retrieves weekly announcements.
  ///
  /// Makes a `GET` request to **/announce-data** and returns a parsed
  /// `AnnounceModel` inside an `Either<AppFailure, AnnounceModel>`.
  ///
  /// **Success:**
  ///   Returns `Right(List<AnnounceModel>)`.
  ///
  /// **Failure:**
  /// - 401 Unauthorized → requires re-login
  /// - SocketException → No internet
  /// - HttpException → Server-side error
  /// - FormatException → Malformed JSON
  /// - Any other errors wrapped with a default message
  ///
  /// Example usage:
  /// ```dart
  /// final result = await ref.read(landingRepositoryProvider).getWeeklyAnnouncements();
  /// ```
  Future<Either<AppFailure, List<AnnounceModel>>>
  getWeeklyAnnouncements() async {
    try {
      final announceRes = await http.get(
        Uri.parse('${ServerConstant.serverURL}/announce-data'),
        headers: ServerConstant.getHeaders(),
      );

      final json = jsonDecode(announceRes.body);

      if (announceRes.statusCode == 200) {
        if (kDebugMode) {
          print(
            'Announce Length: ${AnnounceResponse.fromJson(json).data.length}',
          );
          print('Announce List: ${AnnounceResponse.fromJson(json).data}');
        }

        return Right(AnnounceResponse.fromJson(json).data);
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
