import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_app/core/widgets/loader.dart';
import 'package:wms_app/core/widgets/text_divider_widget.dart';
import 'package:wms_app/feature/landing/viewmodels/landing_announce_view_model.dart';
import 'package:wms_app/feature/landing/viewmodels/landing_news_view_model.dart';
import 'package:wms_app/feature/landing/viewmodels/landing_task_view_model.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextDividerWidget(text: 'Goal'),
            Flexible(fit: FlexFit.tight, flex: 3, child: taskBuilder(context)),
            TextDividerWidget(text: 'News'),
            Flexible(fit: FlexFit.tight, flex: 3, child: newsBuilder(context)),
            TextDividerWidget(text: 'Announcement'),
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: announceBuilder(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget taskBuilder(BuildContext context) {
    final landingTaskState = ref.watch(landingTaskViewModelProvider);
    return landingTaskState == null
        ? Center(child: Text('Error'))
        : landingTaskState.when(
            loading: () => Center(child: Loader()),
            error: (error, st) => Center(child: Text(error.toString())),
            data: (data) {
              if (data.isEmpty) {
                return Center(child: Text("No Task Available"));
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final task = data[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            task.title ?? 'No Title',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            task.description ?? 'No Description',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Due: ${task.dueDate}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                ),
                              ),
                              Chip(
                                label: Text(task.priority ?? 'normal'),
                                backgroundColor: _getPriorityColor(
                                  task.priority,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
  }

  Color _getPriorityColor(String? priority) {
    switch (priority?.toLowerCase()) {
      case 'high':
        return Colors.red.shade100;
      case 'medium':
        return Colors.orange.shade100;
      case 'low':
        return Colors.green.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  Widget newsBuilder(BuildContext context) {
    final landingNewsState = ref.watch(landingNewsViewModelProvider);
    return landingNewsState == null
        ? Center(child: Text('Error'))
        : landingNewsState.when(
            loading: () => Center(child: Loader()),
            error: (error, st) => Center(child: Text(error.toString())),
            data: (data) {
              if (data.isEmpty) {
                return Center(child: Text("No Task Available"));
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final news = data[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            news.title ?? 'No Title',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            news.description ?? 'No Description',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Due: ${news.dueDate}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
  }

  Widget announceBuilder(BuildContext context) {
    final landingAnnounceState = ref.watch(landingAnnounceViewModelProvider);
    return landingAnnounceState == null
        ? Center(child: Text('Error'))
        : landingAnnounceState.when(
            loading: () => Center(child: Loader()),
            error: (error, st) => Center(child: Text(error.toString())),
            data: (data) {
              if (data.isEmpty) {
                return Center(child: Text("No Task Available"));
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final announce = data[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            announce.title ?? 'No Title',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            announce.description ?? 'No Description',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Due: ${announce.dueDate}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
  }
}
