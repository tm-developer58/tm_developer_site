import 'package:flutter/material.dart';

import '../models/app_work.dart';
import '../widgets/app_work_card.dart';
import '../widgets/section_heading.dart';

class WorksSection extends StatelessWidget {
  const WorksSection({super.key});

  static const _apps = [
    AppWork(
      icon: Icons.coffee_outlined,
      title: 'コーヒータイマー',
      summary: 'コーヒーのレシピと豆を管理できるアプリ',
      tech: 'Flutter / Firebase',
      note: 'レシピや豆の情報を継続して管理しやすいよう、入力・保存・参照の流れをシンプルに設計しました。',
      url: 'https://apps.apple.com/jp/app/コーヒータイマー-レシピと豆の管理アプリ/id6744885251',
    ),
    AppWork(
      icon: Icons.volume_up_outlined,
      title: '音量調整アプリ',
      summary: '音量を細かく調整できるユーティリティアプリ',
      tech: 'Flutter',
      note: '日常的にすぐ使えるよう、操作をできるだけ少なくし、シンプルな機能に絞って実装しました。',
      url: 'https://apps.apple.com/jp/app/音量調整-音量を微調整できるアプリ/id6502644391',
    ),
    AppWork(
      icon: Icons.restaurant_menu_outlined,
      title: 'レシピ保存・生成アプリ',
      summary: 'レシピの保存・タグ管理・生成を行うアプリ',
      tech: 'Flutter / Firebase / TypeScript',
      note: 'レシピを後から探しやすくするため、保存・分類・参照のしやすさを意識して設計しました。',
      url: 'https://apps.apple.com/jp/app/レシピ保管庫-保存とタグ管理/id6752911070',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(
          eyebrow: 'Works',
          title: 'App Storeで公開している個人開発アプリ',
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _apps
                    .map(
                      (app) => Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: app == _apps.last ? 0 : 14,
                          ),
                          child: AppWorkCard(work: app),
                        ),
                      ),
                    )
                    .toList(),
              );
            }

            return Column(
              children: _apps
                  .map(
                    (app) => Padding(
                      padding: EdgeInsets.only(
                        bottom: app == _apps.last ? 0 : 14,
                      ),
                      child: AppWorkCard(work: app),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
