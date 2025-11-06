// // lib/features/landing/presentation/providers/landing_provider.dart
// import 'package:e_wms_mobile/feature/landing/repository/home_repo.dart';
// import 'package:flutter/foundation.dart';
// import '../../data/repositories/landing_repository.dart';
// import '../../data/models/daily_task_model.dart';
// import '../../data/models/daily_news_model.dart';
// import '../../data/models/weekly_announcement_model.dart';
// import '../../data/models/additional_info_model.dart';
// import '../../data/models/token_info_model.dart';

// enum LandingState { initial, loading, loaded, error, refreshing }

// class LandingProvider with ChangeNotifier {
//   final LandingRepository _repository;

//   LandingProvider({LandingRepository? repository})
//     : _repository = repository ?? LandingRepository();

//   // State
//   LandingState _state = LandingState.initial;
//   String? _errorMessage;

//   // Data
//   List<DailyTaskModel> _dailyTasks = [];
//   List<DailyNewsModel> _dailyNews = [];
//   List<WeeklyAnnouncementModel> _weeklyAnnouncements = [];
//   List<AdditionalInfoModel> _additionalInfo = [];
//   TokenInfoModel? _tokenInfo;

//   // Getters
//   LandingState get state => _state;
//   String? get errorMessage => _errorMessage;
//   List<DailyTaskModel> get dailyTasks => _dailyTasks;
//   List<DailyNewsModel> get dailyNews => _dailyNews;
//   List<WeeklyAnnouncementModel> get weeklyAnnouncements => _weeklyAnnouncements;
//   List<AdditionalInfoModel> get additionalInfo => _additionalInfo;
//   TokenInfoModel? get tokenInfo => _tokenInfo;

//   bool get isLoading => _state == LandingState.loading;
//   bool get isLoaded => _state == LandingState.loaded;
//   bool get isError => _state == LandingState.error;
//   bool get isRefreshing => _state == LandingState.refreshing;

//   // Computed getters
//   int get pendingTasksCount =>
//       _dailyTasks.where((task) => task.status == 'pending').length;

//   int get completedTasksCount =>
//       _dailyTasks.where((task) => task.status == 'completed').length;

//   int get unreadNewsCount => _dailyNews.where((news) => !news.isRead).length;

//   List<WeeklyAnnouncementModel> get pinnedAnnouncements =>
//       _weeklyAnnouncements.where((a) => a.isPinned).toList();

//   // Set auth token
//   void setAuthToken(String token) {
//     _repository.setAuthToken(token);
//   }

//   // Load dashboard data
//   Future<void> loadDashboardData() async {
//     _state = LandingState.loading;
//     _errorMessage = null;
//     notifyListeners();

//     final result = await _repository.getDashboardData();

//     if (result.isSuccess && result.data != null) {
//       _dailyTasks = result.data!.dailyTasks;
//       _dailyNews = result.data!.dailyNews;
//       _weeklyAnnouncements = result.data!.weeklyAnnouncements;
//       _additionalInfo = result.data!.additionalInfo;
//       _tokenInfo = result.data!.tokenInfo;
//       _state = LandingState.loaded;
//       _errorMessage = null;
//     } else {
//       _state = LandingState.error;
//       _errorMessage = result.error;
//     }

//     notifyListeners();
//   }

//   // Refresh data
//   Future<void> refreshData() async {
//     _state = LandingState.refreshing;
//     notifyListeners();

//     await loadDashboardData();
//   }

//   // Load daily tasks
//   Future<void> loadDailyTasks() async {
//     final result = await _repository.getDailyTasks();

//     if (result.isSuccess && result.data != null) {
//       _dailyTasks = result.data!;
//       notifyListeners();
//     }
//   }

//   // Update task status
//   Future<bool> updateTaskStatus(String taskId, String status) async {
//     final result = await _repository.updateTaskStatus(taskId, status);

//     if (result.isSuccess && result.data != null) {
//       final index = _dailyTasks.indexWhere((task) => task.id == taskId);
//       if (index != -1) {
//         _dailyTasks[index] = result.data!;
//         notifyListeners();
//       }
//       return true;
//     }

//     return false;
//   }

//   // Load daily news
//   Future<void> loadDailyNews({int page = 1, int limit = 10}) async {
//     final result = await _repository.getDailyNews(page: page, limit: limit);

//     if (result.isSuccess && result.data != null) {
//       if (page == 1) {
//         _dailyNews = result.data!;
//       } else {
//         _dailyNews.addAll(result.data!);
//       }
//       notifyListeners();
//     }
//   }

//   // Mark news as read
//   Future<void> markNewsAsRead(String newsId) async {
//     final result = await _repository.markNewsAsRead(newsId);

//     if (result.isSuccess) {
//       final index = _dailyNews.indexWhere((news) => news.id == newsId);
//       if (index != -1) {
//         _dailyNews[index] = _dailyNews[index].copyWith(isRead: true);
//         notifyListeners();
//       }
//     }
//   }

//   // Load weekly announcements
//   Future<void> loadWeeklyAnnouncements() async {
//     final result = await _repository.getWeeklyAnnouncements();

//     if (result.isSuccess && result.data != null) {
//       _weeklyAnnouncements = result.data!;
//       notifyListeners();
//     }
//   }

//   // Load additional info
//   Future<void> loadAdditionalInfo() async {
//     final result = await _repository.getAdditionalInfo();

//     if (result.isSuccess && result.data != null) {
//       _additionalInfo = result.data!;
//       notifyListeners();
//     }
//   }

//   // Load token info
//   Future<void> loadTokenInfo() async {
//     final result = await _repository.getTokenInfo();

//     if (result.isSuccess && result.data != null) {
//       _tokenInfo = result.data!;
//       notifyListeners();
//     }
//   }

//   // Refresh tokens
//   Future<bool> refreshTokens() async {
//     final result = await _repository.refreshTokens();

//     if (result.isSuccess) {
//       await loadTokenInfo();
//       return true;
//     }

//     return false;
//   }

//   // Get task by id
//   DailyTaskModel? getTaskById(String taskId) {
//     try {
//       return _dailyTasks.firstWhere((task) => task.id == taskId);
//     } catch (e) {
//       return null;
//     }
//   }

//   // Get news by id
//   DailyNewsModel? getNewsById(String newsId) {
//     try {
//       return _dailyNews.firstWhere((news) => news.id == newsId);
//     } catch (e) {
//       return null;
//     }
//   }

//   // Get announcement by id
//   WeeklyAnnouncementModel? getAnnouncementById(String announcementId) {
//     try {
//       return _weeklyAnnouncements.firstWhere(
//         (announcement) => announcement.id == announcementId,
//       );
//     } catch (e) {
//       return null;
//     }
//   }

//   // Filter tasks by status
//   List<DailyTaskModel> filterTasksByStatus(String status) {
//     return _dailyTasks.where((task) => task.status == status).toList();
//   }

//   // Filter tasks by priority
//   List<DailyTaskModel> filterTasksByPriority(String priority) {
//     return _dailyTasks.where((task) => task.priority == priority).toList();
//   }

//   // Filter news by category
//   List<DailyNewsModel> filterNewsByCategory(String category) {
//     return _dailyNews.where((news) => news.category == category).toList();
//   }

//   // Search tasks
//   List<DailyTaskModel> searchTasks(String query) {
//     final lowerQuery = query.toLowerCase();
//     return _dailyTasks.where((task) {
//       return task.title.toLowerCase().contains(lowerQuery) ||
//           task.description.toLowerCase().contains(lowerQuery);
//     }).toList();
//   }

//   // Search news
//   List<DailyNewsModel> searchNews(String query) {
//     final lowerQuery = query.toLowerCase();
//     return _dailyNews.where((news) {
//       return news.title.toLowerCase().contains(lowerQuery) ||
//           news.content.toLowerCase().contains(lowerQuery);
//     }).toList();
//   }

//   @override
//   void dispose() {
//     _repository.dispose();
//     super.dispose();
//   }
// }

// // Usage with Provider package:
// //
// // 1. Add provider to pubspec.yaml:
// //    dependencies:
// //      provider: ^6.0.0
// //
// // 2. Wrap your app with ChangeNotifierProvider:
// //    void main() {
// //      runApp(
// //        ChangeNotifierProvider(
// //          create: (_) => LandingProvider(),
// //          child: MyApp(),
// //        ),
// //      );
// //    }
// //
// // 3. Use in widgets:
// //    final provider = Provider.of<LandingProvider>(context);
// //    // or
// //    final provider = context.watch<LandingProvider>();
// //    // or
// //    final provider = context.read<LandingProvider>();
