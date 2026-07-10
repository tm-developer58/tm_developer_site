import 'package:flutter/material.dart';

import '../models/work_style_item.dart';
import '../theme/site_theme.dart';

class WorkStyleRow extends StatelessWidget {
  const WorkStyleRow({required this.item, super.key});

  final WorkStyleItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: SiteColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: SiteColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: SiteColors.blueSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: SiteColors.blue),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              item.label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: SiteColors.navy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
