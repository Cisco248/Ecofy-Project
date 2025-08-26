import 'package:e_wms_mobile/provider/announce_provider.dart';
import 'package:e_wms_mobile/utilities/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardLarge extends StatelessWidget {
  const CardLarge({
    super.key,
    required this.img,
    required this.title,
    required this.description,
    this.child,
  });

  final ImageProvider img;
  final String title;
  final String description;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(image: img, fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 16),

            // Text Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LargeWidgetExport extends StatelessWidget {
  const LargeWidgetExport({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AnnounceProvider>(context, listen: false);
    return Column(
      children: provider.announcementList.map((a) {
        return CardLarge(
          img: AssetImage(a.image),
          title: a.title,
          description: a.description,
        );
      }).toList(),
    );
  }
}
