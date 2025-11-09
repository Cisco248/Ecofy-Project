// // lib/features/landing/data/repositories/landing_repository.dart
// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import '../models/daily_task_model.dart';
// import '../models/daily_news_model.dart';
// import '../models/weekly_announcement_model.dart';
// import '../models/additional_info_model.dart';
// import '../models/token_info_model.dart';
// import '../models/landing_dashboard_model.dart';

// // Result class for better error handling
// class Result<T> {
//   final T? data;
//   final String? error;
//   final bool isSuccess;

//   Result.success(this.data) : error = null, isSuccess = true;

//   Result.failure(this.error) : data = null, isSuccess = false;
// }

// class LandingRepository {
//   final String baseUrl;
//   final http.Client client;
//   String? _authToken;

//   LandingRepository({
//     this.baseUrl = 'http://10.0.2.2:8000',
//     http.Client? client,
//   }) : client = client ?? http.Client();

//   void setAuthToken(String token) {
//     _authToken = token;
//   }

//   void clearAuthToken() {
//     _authToken = null;
//   }

//   Map<String, String> _getHeaders() {
//     final headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     };

//     if (_authToken != null) {
//       headers['Authorization'] = 'Bearer $_authToken';
//     }

//     return headers;
//   }

//   // ========== GET ALL DASHBOARD DATA ==========
//   Future<Result<LandingDashboardModel>> getDashboardData() async {
//     try {
//       final response = await client.get(
//         Uri.parse('$baseUrl/dashboard'),
//         headers: _getHeaders(),
//       );

//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         final dashboard = LandingDashboardModel.fromJson(json['data'] ?? json);
//         return Result.success(dashboard);
//       } else if (response.statusCode == 401) {
//         return Result.failure('Unauthorized. Please login again.');
//       } else {
//         final json = jsonDecode(response.body);
//         return Result.failure(
//           json['message'] ?? 'Failed to fetch dashboard data',
//         );
//       }
//     } on SocketException {
//       return Result.failure('No internet connection');
//     } on HttpException {
//       return Result.failure('Server error occurred');
//     } on FormatException {
//       return Result.failure('Invalid response format');
//     } catch (e) {
//       return Result.failure('An unexpected error occurred: $e');
//     }
//   }

//   // ========== DAILY TASKS ==========
//   Future<Result<List<DailyTaskModel>>> getDailyTasks() async {
//     try {
//       final response = await client.get(
//         Uri.parse('$baseUrl/daily-tasks'),
//         headers: _getHeaders(),
//       );

//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         final tasks = (json['data'] as List)
//             .map((task) => DailyTaskModel.fromJson(task))
//             .toList();
//         return Result.success(tasks);
//       } else if (response.statusCode == 401) {
//         return Result.failure('Unauthorized. Please login again.');
//       } else {
//         final json = jsonDecode(response.body);
//         return Result.failure(json['message'] ?? 'Failed to fetch daily tasks');
//       }
//     } on SocketException {
//       return Result.failure('No internet connection');
//     } on HttpException {
//       return Result.failure('Server error occurred');
//     } on FormatException {
//       return Result.failure('Invalid response format');
//     } catch (e) {
//       return Result.failure('An unexpected error occurred: $e');
//     }
//   }

//   Future<Result<DailyTaskModel>> updateTaskStatus(
//     String taskId,
//     String status,
//   ) async {
//     try {
//       final response = await client.patch(
//         Uri.parse('$baseUrl/daily-tasks/$taskId/status'),
//         headers: _getHeaders(),
//         body: jsonEncode({'status': status}),
//       );

//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         final task = DailyTaskModel.fromJson(json['data'] ?? json);
//         return Result.success(task);
//       } else if (response.statusCode == 401) {
//         return Result.failure('Unauthorized. Please login again.');
//       } else {
//         final json = jsonDecode(response.body);
//         return Result.failure(
//           json['message'] ?? 'Failed to update task status',
//         );
//       }
//     } on SocketException {
//       return Result.failure('No internet connection');
//     } on HttpException {
//       return Result.failure('Server error occurred');
//     } on FormatException {
//       return Result.failure('Invalid response format');
//     } catch (e) {
//       return Result.failure('An unexpected error occurred: $e');
//     }
//   }

//   // ========== DAILY NEWS ==========
//   Future<Result<List<DailyNewsModel>>> getDailyNews({
//     int page = 1,
//     int limit = 10,
//   }) async {
//     try {
//       final response = await client.get(
//         Uri.parse('$baseUrl/daily-news?page=$page&limit=$limit'),
//         headers: _getHeaders(),
//       );

//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         final news = (json['data'] as List)
//             .map((item) => DailyNewsModel.fromJson(item))
//             .toList();
//         return Result.success(news);
//       } else if (response.statusCode == 401) {
//         return Result.failure('Unauthorized. Please login again.');
//       } else {
//         final json = jsonDecode(response.body);
//         return Result.failure(json['message'] ?? 'Failed to fetch daily news');
//       }
//     } on SocketException {
//       return Result.failure('No internet connection');
//     } on HttpException {
//       return Result.failure('Server error occurred');
//     } on FormatException {
//       return Result.failure('Invalid response format');
//     } catch (e) {
//       return Result.failure('An unexpected error occurred: $e');
//     }
//   }

//   Future<Result<DailyNewsModel>> getNewsById(String newsId) async {
//     try {
//       final response = await client.get(
//         Uri.parse('$baseUrl/daily-news/$newsId'),
//         headers: _getHeaders(),
//       );

//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         final news = DailyNewsModel.fromJson(json['data'] ?? json);
//         return Result.success(news);
//       } else if (response.statusCode == 401) {
//         return Result.failure('Unauthorized. Please login again.');
//       } else {
//         final json = jsonDecode(response.body);
//         return Result.failure(
//           json['message'] ?? 'Failed to fetch news details',
//         );
//       }
//     } on SocketException {
//       return Result.failure('No internet connection');
//     } on HttpException {
//       return Result.failure('Server error occurred');
//     } on FormatException {
//       return Result.failure('Invalid response format');
//     } catch (e) {
//       return Result.failure('An unexpected error occurred: $e');
//     }
//   }

//   Future<Result<bool>> markNewsAsRead(String newsId) async {
//     try {
//       final response = await client.post(
//         Uri.parse('$baseUrl/daily-news/$newsId/mark-read'),
//         headers: _getHeaders(),
//       );

//       if (response.statusCode == 200) {
//         return Result.success(true);
//       } else if (response.statusCode == 401) {
//         return Result.failure('Unauthorized. Please login again.');
//       } else {
//         final json = jsonDecode(response.body);
//         return Result.failure(json['message'] ?? 'Failed to mark news as read');
//       }
//     } on SocketException {
//       return Result.failure('No internet connection');
//     } on HttpException {
//       return Result.failure('Server error occurred');
//     } catch (e) {
//       return Result.failure('An unexpected error occurred: $e');
//     }
//   }

//   // ========== WEEKLY ANNOUNCEMENTS ==========
//   Future<Result<List<WeeklyAnnouncementModel>>> getWeeklyAnnouncements() async {
//     try {
//       final response = await client.get(
//         Uri.parse('$baseUrl/weekly-announcements'),
//         headers: _getHeaders(),
//       );

//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         final announcements = (json['data'] as List)
//             .map((item) => WeeklyAnnouncementModel.fromJson(item))
//             .toList();
//         return Result.success(announcements);
//       } else if (response.statusCode == 401) {
//         return Result.failure('Unauthorized. Please login again.');
//       } else {
//         final json = jsonDecode(response.body);
//         return Result.failure(
//           json['message'] ?? 'Failed to fetch weekly announcements',
//         );
//       }
//     } on SocketException {
//       return Result.failure('No internet connection');
//     } on HttpException {
//       return Result.failure('Server error occurred');
//     } on FormatException {
//       return Result.failure('Invalid response format');
//     } catch (e) {
//       return Result.failure('An unexpected error occurred: $e');
//     }
//   }

//   Future<Result<WeeklyAnnouncementModel>> getAnnouncementById(
//     String announcementId,
//   ) async {
//     try {
//       final response = await client.get(
//         Uri.parse('$baseUrl/weekly-announcements/$announcementId'),
//         headers: _getHeaders(),
//       );

//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         final announcement = WeeklyAnnouncementModel.fromJson(
//           json['data'] ?? json,
//         );
//         return Result.success(announcement);
//       } else if (response.statusCode == 401) {
//         return Result.failure('Unauthorized. Please login again.');
//       } else {
//         final json = jsonDecode(response.body);
//         return Result.failure(
//           json['message'] ?? 'Failed to fetch announcement details',
//         );
//       }
//     } on SocketException {
//       return Result.failure('No internet connection');
//     } on HttpException {
//       return Result.failure('Server error occurred');
//     } on FormatException {
//       return Result.failure('Invalid response format');
//     } catch (e) {
//       return Result.failure('An unexpected error occurred: $e');
//     }
//   }

//   // ========== ADDITIONAL INFO ==========
//   Future<Result<List<AdditionalInfoModel>>> getAdditionalInfo() async {
//     try {
//       final response = await client.get(
//         Uri.parse('$baseUrl/additional-info'),
//         headers: _getHeaders(),
//       );

//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         final info = (json['data'] as List)
//             .map((item) => AdditionalInfoModel.fromJson(item))
//             .toList();
//         return Result.success(info);
//       } else if (response.statusCode == 401) {
//         return Result.failure('Unauthorized. Please login again.');
//       } else {
//         final json = jsonDecode(response.body);
//         return Result.failure(
//           json['message'] ?? 'Failed to fetch additional info',
//         );
//       }
//     } on SocketException {
//       return Result.failure('No internet connection');
//     } on HttpException {
//       return Result.failure('Server error occurred');
//     } on FormatException {
//       return Result.failure('Invalid response format');
//     } catch (e) {
//       return Result.failure('An unexpected error occurred: $e');
//     }
//   }

//   // ========== TOKEN INFO ==========
//   Future<Result<TokenInfoModel>> getTokenInfo() async {
//     try {
//       final response = await client.get(
//         Uri.parse('$baseUrl/token-info'),
//         headers: _getHeaders(),
//       );

//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         final tokenInfo = TokenInfoModel.fromJson(json['data'] ?? json);
//         return Result.success(tokenInfo);
//       } else if (response.statusCode == 401) {
//         return Result.failure('Unauthorized. Please login again.');
//       } else {
//         final json = jsonDecode(response.body);
//         return Result.failure(json['message'] ?? 'Failed to fetch token info');
//       }
//     } on SocketException {
//       return Result.failure('No internet connection');
//     } on HttpException {
//       return Result.failure('Server error occurred');
//     } on FormatException {
//       return Result.failure('Invalid response format');
//     } catch (e) {
//       return Result.failure('An unexpected error occurred: $e');
//     }
//   }

//   Future<Result<bool>> refreshTokens() async {
//     try {
//       final response = await client.post(
//         Uri.parse('$baseUrl/token-info/refresh'),
//         headers: _getHeaders(),
//       );

//       if (response.statusCode == 200) {
//         return Result.success(true);
//       } else if (response.statusCode == 401) {
//         return Result.failure('Unauthorized. Please login again.');
//       } else {
//         final json = jsonDecode(response.body);
//         return Result.failure(json['message'] ?? 'Failed to refresh tokens');
//       }
//     } on SocketException {
//       return Result.failure('No internet connection');
//     } on HttpException {
//       return Result.failure('Server error occurred');
//     } catch (e) {
//       return Result.failure('An unexpected error occurred: $e');
//     }
//   }

//   void dispose() {
//     client.close();
//   }
// }
