import 'package:flutter/material.dart';

import '../models/app_work.dart';
import '../utils/url_launcher_helper.dart';
import 'info_label.dart';

class AppWorkCard extends StatelessWidget {
  const AppWorkCard({required this.work, super.key});

  final AppWork work;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(work.icon, size: 32, color: const Color(0xFF2563EB)),
            const SizedBox(height: 18),
            Text(
              work.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              work.summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF4B5563),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 16),
            InfoLabel(label: '使用技術', value: work.tech),
            const SizedBox(height: 8),
            const InfoLabel(label: '担当範囲', value: '設計・開発・リリース・運用'),
            const SizedBox(height: 16),
            Text(
              work.note,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: const Color(0xFF6B7280),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 18),
            OutlinedButton.icon(
              onPressed: () => launchExternalUri(Uri.parse(work.url)),
              icon: const Icon(Icons.open_in_new, size: 18),
              label: const Text('App Store'),
            ),
          ],
        ),
      ),
    );
  }
}
