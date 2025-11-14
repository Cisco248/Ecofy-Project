import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:wms_app/core/constants/color.dart';
import 'package:wms_app/core/widgets/loader.dart';
import 'package:wms_app/core/widgets/text_divider_widget.dart';
import 'package:wms_app/feature/landing/viewmodels/landing_task_view_model.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final landingTaskState = ref.watch(landingTaskViewModelProvider);
    if (kDebugMode) {
      print(landingTaskState);
    }
    return Scaffold(
      body: SafeArea(
        child: landingTaskState == null
            ? Center()
            : landingTaskState.when(
                loading: () => Loader(),
                error: (error, st) => Center(child: Text(error.toString())),
                data: (data) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListView(
                      children: [
                        TextDividerWidget(text: 'Goal'),
                        Text(data.title ?? ''),
                        Text(data.description ?? ''),
                        Text(data.dueDate ?? ''),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
