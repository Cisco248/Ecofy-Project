import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_app/core/widgets/card_large.dart';
import 'package:wms_app/core/widgets/card_medium.dart';
import 'package:wms_app/core/widgets/loader.dart';
import 'package:wms_app/core/widgets/text_divider_widget.dart';
import 'package:wms_app/feature/landing/viewmodels/landing_announce_view_model.dart';
import 'package:wms_app/feature/landing/viewmodels/landing_news_view_model.dart';
import 'package:wms_app/feature/landing/viewmodels/landing_task_view_model.dart';
import 'package:wms_app/utilities/helpers/debug_print.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextDividerWidget(text: 'Tasks'),
          taskBuilder(context),
          TextDividerWidget(text: 'News'),
          newsBuilder(context),
          TextDividerWidget(text: 'Announcement'),
          announceBuilder(context),
        ],
      ),
    );
  }

  Widget taskBuilder(BuildContext context) {
    final landingTaskState = ref.watch(landingTaskViewModelProvider);
    DebugPrint(landingTaskState, '[TASKS] View Status').log();
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
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final task = data[index];
                  return CardMedium(
                    title: task.title ?? "",
                    description: task.description ?? "",
                    dueDate: task.dueDate ?? "",
                    priority: task.priority ?? '',
                  );
                },
              );
            },
          );
  }

  Widget newsBuilder(BuildContext context) {
    final landingNewsState = ref.watch(landingNewsViewModelProvider);
    DebugPrint(landingNewsState, '[NEWS] View Status').log();
    return landingNewsState == null
        ? Center(child: Text('Error'))
        : landingNewsState.when(
            loading: () => Center(child: Loader()),
            error: (error, st) => Center(child: Text(error.toString())),
            data: (data) {
              if (data.isEmpty) {
                return Center(child: Text("No News Available"));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final news = data[index];
                  return CardLarge(
                    title: news.title ?? '',
                    description: news.description ?? '',
                    dueDate: news.dueDate ?? '',
                  );
                },
              );
            },
          );
  }

  Widget announceBuilder(BuildContext context) {
    final landingAnnounceState = ref.watch(landingAnnounceViewModelProvider);
    DebugPrint(landingAnnounceState, '[ANNOUNCEMENTS] View Status').log();
    return landingAnnounceState == null
        ? Center(child: Text('Error'))
        : landingAnnounceState.when(
            loading: () => Center(child: Loader()),
            error: (error, st) => Center(child: Text(error.toString())),
            data: (data) {
              if (data.isEmpty) {
                return Center(child: Text("No Announcement Available"));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final announce = data[index];
                  return CardLarge(
                    title: announce.title ?? "",
                    description: announce.description ?? "",
                    dueDate: announce.dueDate ?? "",
                  );
                },
              );
            },
          );
  }
}
