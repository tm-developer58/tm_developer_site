import 'package:flutter/material.dart';

import '../models/skill_item.dart';
import '../theme/site_theme.dart';

class SkillChip extends StatelessWidget {
  const SkillChip({required this.item, super.key});

  final SkillItem item;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: item.label,
      child: ExcludeSemantics(
        child: Container(
          constraints: const BoxConstraints(minHeight: 68),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          decoration: BoxDecoration(
            color: SiteColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: SiteColors.border),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D0F172A),
                blurRadius: 14,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: SiteColors.blueSoft,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(item.icon, size: 21, color: SiteColors.blue),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Text(
                  item.label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: SiteColors.navy,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
