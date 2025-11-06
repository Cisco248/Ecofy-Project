// // lib/features/landing/presentation/pages/landing_screen_with_provider.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/landing_provider.dart';
// import '../widgets/daily_task_card.dart';
// import '../widgets/daily_news_card.dart';
// import '../widgets/weekly_announcement_card.dart';
// import '../widgets/additional_info_card.dart';
// import '../widgets/token_info_widget.dart';
// import 'package:e_wms_mobile/core/constants/color.dart';

// class LandingScreenWithProvider extends StatefulWidget {
//   const LandingScreenWithProvider({super.key});

//   @override
//   State<LandingScreenWithProvider> createState() =>
//       _LandingScreenWithProviderState();
// }

// class _LandingScreenWithProviderState extends State<LandingScreenWithProvider> {
//   @override
//   void initState() {
//     super.initState();
//     // Load data when screen initializes
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<LandingProvider>().loadDashboardData();
//     });
//   }

//   Future<void> _handleRefresh() async {
//     await context.read<LandingProvider>().refreshData();
//   }

//   Future<void> _updateTaskStatus(String taskId, String status) async {
//     final success = await context.read<LandingProvider>().updateTaskStatus(
//       taskId,
//       status,
//     );

//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             success
//                 ? 'Task status updated to $status'
//                 : 'Failed to update task',
//           ),
//           backgroundColor: success ? Colors.green : Colors.red,
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   Future<void> _markNewsAsRead(String newsId) async {
//     await context.read<LandingProvider>().markNewsAsRead(newsId);
//   }

//   Future<void> _refreshTokens() async {
//     final success = await context.read<LandingProvider>().refreshTokens();

//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             success
//                 ? 'Tokens refreshed successfully'
//                 : 'Failed to refresh tokens',
//           ),
//           backgroundColor: success ? Colors.green : Colors.red,
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text('Dashboard'),
//         backgroundColor: AppColors.primary,
//         actions: [
//           // Notification badge with unread count
//           Consumer<LandingProvider>(
//             builder: (context, provider, child) {
//               return Stack(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.notifications_outlined),
//                     onPressed: () {
//                       // Navigate to notifications
//                     },
//                   ),
//                   if (provider.unreadNewsCount > 0)
//                     Positioned(
//                       right: 8,
//                       top: 8,
//                       child: Container(
//                         padding: const EdgeInsets.all(4),
//                         decoration: const BoxDecoration(
//                           color: Colors.red,
//                           shape: BoxShape.circle,
//                         ),
//                         constraints: const BoxConstraints(
//                           minWidth: 16,
//                           minHeight: 16,
//                         ),
//                         child: Text(
//                           '${provider.unreadNewsCount}',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 10,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                 ],
//               );
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.settings_outlined),
//             onPressed: () {
//               // Navigate to settings
//             },
//           ),
//         ],
//       ),
//       body: Consumer<LandingProvider>(
//         builder: (context, provider, child) {
//           // Loading state
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           // Error state
//           if (provider.isError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
//                   const SizedBox(height: 16),
//                   Text(
//                     provider.errorMessage ?? 'An error occurred',
//                     style: const TextStyle(fontSize: 16),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 24),
//                   ElevatedButton.icon(
//                     onPressed: () => provider.loadDashboardData(),
//                     icon: const Icon(Icons.refresh),
//                     label: const Text('Retry'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primary,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 24,
//                         vertical: 12,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }

//           // Success state
//           return RefreshIndicator(
//             onRefresh: _handleRefresh,
//             child: SingleChildScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Token Info Widget
//                   if (provider.tokenInfo != null)
//                     TokenInfoWidget(
//                       tokenInfo: provider.tokenInfo!,
//                       onRefresh: _refreshTokens,
//                     ),

//                   const SizedBox(height: 8),

//                   // Summary Cards Row
//                   _buildSummaryCards(provider),

//                   const SizedBox(height: 16),

//                   // Daily Tasks Section
//                   _buildSectionHeader(
//                     context,
//                     'Daily Tasks',
//                     Icons.task_alt,
//                     badge: provider.pendingTasksCount > 0
//                         ? '${provider.pendingTasksCount}'
//                         : null,
//                     onViewAll: () {
//                       // Navigate to all tasks
//                     },
//                   ),
//                   if (provider.dailyTasks.isEmpty)
//                     _buildEmptyState('No tasks for today')
//                   else
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: provider.dailyTasks.length > 3
//                           ? 3
//                           : provider.dailyTasks.length,
//                       itemBuilder: (context, index) {
//                         return DailyTaskCard(
//                           task: provider.dailyTasks[index],
//                           onTap: () {
//                             // Navigate to task details
//                           },
//                           onStatusChanged: (status) {
//                             _updateTaskStatus(
//                               provider.dailyTasks[index].id,
//                               status,
//                             );
//                           },
//                         );
//                       },
//                     ),

//                   const SizedBox(height: 16),

//                   // Weekly Announcements Section
//                   _buildSectionHeader(
//                     context,
//                     'Weekly Announcements',
//                     Icons.campaign,
//                     badge: provider.pinnedAnnouncements.isNotEmpty
//                         ? '${provider.pinnedAnnouncements.length}'
//                         : null,
//                     onViewAll: () {
//                       // Navigate to all announcements
//                     },
//                   ),
//                   if (provider.weeklyAnnouncements.isEmpty)
//                     _buildEmptyState('No announcements this week')
//                   else
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: provider.weeklyAnnouncements.length > 2
//                           ? 2
//                           : provider.weeklyAnnouncements.length,
//                       itemBuilder: (context, index) {
//                         return WeeklyAnnouncementCard(
//                           announcement: provider.weeklyAnnouncements[index],
//                           onTap: () {
//                             // Navigate to announcement details
//                           },
//                         );
//                       },
//                     ),

//                   const SizedBox(height: 16),

//                   // Daily News Section
//                   _buildSectionHeader(
//                     context,
//                     'Daily News',
//                     Icons.newspaper,
//                     badge: provider.unreadNewsCount > 0
//                         ? '${provider.unreadNewsCount}'
//                         : null,
//                     onViewAll: () {
//                       // Navigate to all news
//                     },
//                   ),
//                   if (provider.dailyNews.isEmpty)
//                     _buildEmptyState('No news available')
//                   else
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: provider.dailyNews.length > 3
//                           ? 3
//                           : provider.dailyNews.length,
//                       itemBuilder: (context, index) {
//                         return DailyNewsCard(
//                           news: provider.dailyNews[index],
//                           onTap: () {
//                             _markNewsAsRead(provider.dailyNews[index].id);
//                             // Navigate to news details
//                           },
//                         );
//                       },
//                     ),

//                   const SizedBox(height: 16),

//                   // Additional Info Section
//                   if (provider.additionalInfo.isNotEmpty) ...[
//                     _buildSectionHeader(
//                       context,
//                       'Quick Access',
//                       Icons.dashboard,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: GridView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3,
//                               childAspectRatio: 1,
//                               crossAxisSpacing: 8,
//                               mainAxisSpacing: 8,
//                             ),
//                         itemCount: provider.additionalInfo.length > 6
//                             ? 6
//                             : provider.additionalInfo.length,
//                         itemBuilder: (context, index) {
//                           return AdditionalInfoCard(
//                             info: provider.additionalInfo[index],
//                             onTap: () {
//                               // Navigate to info details
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ],

//                   const SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: Consumer<LandingProvider>(
//         builder: (context, provider, child) {
//           return FloatingActionButton(
//             onPressed: provider.isRefreshing ? null : _handleRefresh,
//             backgroundColor: AppColors.primary,
//             child: provider.isRefreshing
//                 ? const SizedBox(
//                     width: 24,
//                     height: 24,
//                     child: CircularProgressIndicator(
//                       color: Colors.white,
//                       strokeWidth: 2,
//                     ),
//                   )
//                 : const Icon(Icons.refresh),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildSummaryCards(LandingProvider provider) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: [
//           Expanded(
//             child: _buildSummaryCard(
//               'Pending',
//               '${provider.pendingTasksCount}',
//               Icons.pending_actions,
//               Colors.orange,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: _buildSummaryCard(
//               'Completed',
//               '${provider.completedTasksCount}',
//               Icons.check_circle,
//               Colors.green,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: _buildSummaryCard(
//               'Unread',
//               '${provider.unreadNewsCount}',
//               Icons.mail,
//               Colors.blue,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSummaryCard(
//     String label,
//     String value,
//     IconData icon,
//     Color color,
//   ) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Icon(icon, color: color, size: 28),
//             const SizedBox(height: 8),
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: color,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               label,
//               style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionHeader(
//     BuildContext context,
//     String title,
//     IconData icon, {
//     String? badge,
//     VoidCallback? onViewAll,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         children: [
//           Icon(icon, color: AppColors.primary),
//           const SizedBox(width: 8),
//           Text(
//             title,
//             style: Theme.of(
//               context,
//             ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//           ),
//           if (badge != null) ...[
//             const SizedBox(width: 8),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//               decoration: BoxDecoration(
//                 color: AppColors.primary,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 badge,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//           const Spacer(),
//           if (onViewAll != null)
//             TextButton(onPressed: onViewAll, child: const Text('View All')),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyState(String message) {
//     return Padding(
//       padding: const EdgeInsets.all(32),
//       child: Center(
//         child: Column(
//           children: [
//             Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
//             const SizedBox(height: 16),
//             Text(
//               message,
//               style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
