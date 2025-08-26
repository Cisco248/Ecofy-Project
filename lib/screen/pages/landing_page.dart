import 'package:e_wms_mobile/screen/widgets/text_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:e_wms_mobile/screen/widgets/card_large.dart';
import 'package:e_wms_mobile/screen/widgets/card_medium.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        fit: StackFit.passthrough,
        children: [
          Align(alignment: Alignment.bottomCenter, child: LandingBottom()),
        ],
      ),
    );
  }
}

class LandingBottom extends StatefulWidget {
  const LandingBottom({super.key});

  @override
  State<LandingBottom> createState() => _LandingBottomState();
}

class _LandingBottomState extends State<LandingBottom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView(
        children: [
          TextDividerWidget(text: 'Goal'),
          MediumWidgetExport(),
          TextDividerWidget(text: 'News'),
          MediumWidgetExport(),
          TextDividerWidget(text: 'Announcement'),
          LargeWidgetExport(),
        ],
      ),
    );
  }
}
