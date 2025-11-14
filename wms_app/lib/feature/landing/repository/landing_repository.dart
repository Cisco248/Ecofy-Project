// lib/features/landing/data/repositories/landing_repository.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wms_app/core/constants/server.dart';
import 'package:wms_app/core/constants/text.dart';
import 'package:wms_app/feature/landing/models/news_model.dart';
import 'package:wms_app/feature/landing/models/task_model.dart';
import 'package:wms_app/feature/landing/models/announce_model.dart';
import 'package:wms_app/utilities/helpers/app_failure.dart';

part 'landing_repository.g.dart';

@riverpod
LandingRepository landingRepository(Ref ref) {
  return LandingRepository();
}

class LandingRepository {
  final serUrl = ServerConstant.serverURL;
  final serConst = ServerConstant();
  final serExcep = ExceptionText();

  /// Fetches the daily tasks for the current user from the server.
  ///
  /// This method retrieves a paginated list of daily tasks by making a GET request to the `/tasks-data` endpoint.
  ///
  /// Returns:
  ///   A [Future] that resolves to an [Either] object containing:
  ///   - `Right(DailyTasksModels.fromList(value))`: A list of daily tasks on success.
  ///   - `Left(AppFailure(String))`: An error message describing the failure reason.
  ///
  /// Possible error cases:
  ///   - `Unauthorized. Please login again.`: HTTP 401 status code.
  ///   - `No internet connection`: [SocketException] thrown (network unavailable).
  ///   - `Server error occurred`: [HttpException] thrown (server-side error).
  ///   - `Invalid response format`: [FormatException] thrown (malformed response).
  ///   - `An unexpected error occurred: $e`: Any other default exception.
  ///   - Server-returned error message or `Failed to fetch daily tasks` for other HTTP errors.
  ///
  /// Return Type Example:
  ///   ```dart
  ///    final value = switch(response) {
  ///     Left(value: final failure) => failure,
  ///     Right(value: final success) => success,
  ///   }
  ///   ```
  Future<Either<AppFailure, TaskModel>> getDailyTasks() async {
    try {
      final taskRes = await http.get(
        Uri.parse('$serUrl/task-data'),
        headers: serConst.getHeaders(),
      );

      final json = jsonDecode(taskRes.body);

      if (taskRes.statusCode == 200) {
        // ignore: unused_local_variable
        final tasksList = (json['data'] as List)
            .map((task) => TaskModel.fromJson(task))
            .toList();
        if (kDebugMode) {
          print("Response: ${tasksList.toString()}");
        }
        return Right(TaskModel.fromJson(tasksList as Map<String, dynamic>));
      } else if (taskRes.statusCode == 401) {
        return Left(AppFailure(serExcep.error401));
      } else {
        final json = jsonDecode(taskRes.body);
        return Left(AppFailure(serExcep.defaultExcep + json['detail']));
      }
    } on SocketException {
      return Left(AppFailure(serExcep.socExcep));
    } on HttpException {
      return Left(AppFailure(serExcep.httpExcep));
    } on FormatException {
      return Left(AppFailure(serExcep.forExcep));
    } catch (e) {
      return Left(AppFailure(serExcep.defaultExcep + e.toString()));
    }
  }

  /// Fetches the daily news for the current user from the server.
  ///
  /// This method retrieves a paginated list of daily news by making a GET request to the `/news-data` endpoint.
  ///
  /// Returns:
  ///   A [Future] that resolves to an [Either] object containing:
  ///   - `Right(DailyNewsModels.fromList(value))`: A list of daily tasks on success.
  ///   - `Left(AppFailure(String))`: An error message describing the failure reason.
  ///
  /// Possible error cases:
  ///   - `Unauthorized. Please login again.`: HTTP 401 status code.
  ///   - `No internet connection`: [SocketException] thrown (network unavailable).
  ///   - `Server error occurred`: [HttpException] thrown (server-side error).
  ///   - `Invalid response format`: [FormatException] thrown (malformed response).
  ///   - `An unexpected error occurred: $e`: Any other default exception.
  ///   - Server-returned error message or `Failed to fetch daily news` for other HTTP errors.
  ///
  /// Return Type Example:
  ///   ```dart
  ///    final value = switch(response) {
  ///     Left(value: final failure) => failure,
  ///     Right(value: final success) => success,
  ///   }
  ///   ```
  Future<Either<AppFailure, NewsModel>> getDailyNews() async {
    try {
      final newsRes = await http.get(
        Uri.parse('$serUrl/news-data'),
        headers: serConst.getHeaders(),
      );

      final json = jsonDecode(newsRes.body);

      if (newsRes.statusCode == 200) {
        // ignore: unused_local_variable
        final newsList = (json['data'] as List)
            .map((news) => NewsModel.fromJson(news))
            .toList();
        return Right(NewsModel.fromJson(json));
      } else if (newsRes.statusCode == 401) {
        return Left(AppFailure(serExcep.error401));
      } else {
        final json = jsonDecode(newsRes.body);
        return Left(AppFailure(serExcep.defaultExcep + json['detail']));
      }
    } on SocketException {
      return Left(AppFailure(serExcep.socExcep));
    } on HttpException {
      return Left(AppFailure(serExcep.httpExcep));
    } on FormatException {
      return Left(AppFailure(serExcep.forExcep));
    } catch (e) {
      return Left(AppFailure(serExcep.defaultExcep + e.toString()));
    }
  }

  /// Fetches weekly announcement from the server with pagination support.
  ///
  /// This method retrieves a paginated list of daily news articles by making
  /// a GET request to the `/announce-data` endpoint.
  ///
  /// Returns:
  ///   A [Future] that resolves to an [Either] object containing:
  ///   - `Right(WeeklyAnnouncementModels.formList(value))`: A list of weekly announcement on success.
  ///   - `Left(AppFailure(String))`: An error message describing the failure reason.
  ///
  /// Possible error cases:
  ///   - `Unauthorized. Please login again.`: HTTP 401 status code.
  ///   - `No internet connection`: [SocketException] thrown (network unavailable).
  ///   - `Server error occurred`: [HttpException] thrown (server-side error).
  ///   - `Invalid response format`: [FormatException] thrown (malformed response).
  ///   - `An unexpected error occurred: $e`: Any other default exception.
  ///   - Server-returned error message or `Failed to fetch weekly announcement` for other HTTP errors.
  ///
  /// Return Type Example:
  ///   ```dart
  ///   final value = switch(response) {
  ///     Left(value: final failure) => failure,
  ///     Right(value: final success) => success,
  ///   }
  ///   ```
  Future<Either<AppFailure, AnnounceModel>> getWeeklyAnnouncements() async {
    try {
      final announceRes = await http.get(
        Uri.parse('$serUrl/announce-data'),
        headers: serConst.getHeaders(),
      );

      final json = jsonDecode(announceRes.body);

      if (announceRes.statusCode == 200) {
        // ignore: unused_local_variable
        final announceList = (json['data'] as List)
            .map((item) => AnnounceModel.fromJson(item))
            .toList();
        return Right(AnnounceModel.fromJson(json));
      } else if (announceRes.statusCode == 401) {
        return Left(AppFailure(serExcep.error401));
      } else {
        final json = jsonDecode(announceRes.body);
        return Left(AppFailure(serExcep.defaultExcep + json['message']));
      }
    } on SocketException {
      return Left(AppFailure(serExcep.socExcep));
    } on HttpException {
      return Left(AppFailure(serExcep.httpExcep));
    } on FormatException {
      return Left(AppFailure(serExcep.forExcep));
    } catch (e) {
      return Left(AppFailure(serExcep.defaultExcep + e.toString()));
    }
  }
}
