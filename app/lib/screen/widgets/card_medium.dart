import 'package:e_wms_mobile/provider/goal_provider.dart';
import 'package:e_wms_mobile/provider/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardMedium extends StatelessWidget {
  const CardMedium({
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              width: 48,
              height: 48,
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
                    style: Theme.of(context).textTheme.labelLarge,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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

class GoalWidgetExport extends StatelessWidget {
  const GoalWidgetExport({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoalProvider>(context, listen: false);
    return Column(
      children: provider.goalsList.map((g) {
        return CardMedium(
          img: AssetImage(g.image),
          title: g.title,
          description: g.description,
        );
      }).toList(),
    );
  }
}

class NewsWidgetExport extends StatelessWidget {
  const NewsWidgetExport({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context, listen: false);
    return Column(
      children: provider.newsList.map((n) {
        return CardMedium(
          img: AssetImage(n.image),
          title: n.title,
          description: n.description,
        );
      }).toList(),
    );
  }
}
