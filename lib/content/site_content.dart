import 'package:flutter/material.dart';

import '../models/app_work.dart';
import '../models/skill_item.dart';
import '../models/work_style_item.dart';

class SiteContent {
  const SiteContent({
    required this.brandName,
    required this.pageTitle,
    required this.description,
    required this.email,
    required this.githubUrl,
    required this.headerLabels,
    required this.hero,
    required this.metrics,
    required this.about,
    required this.skills,
    required this.works,
    required this.workStyle,
    required this.contact,
    required this.footerText,
  });

  final String brandName;
  final String pageTitle;
  final String description;
  final String email;
  final String githubUrl;
  final List<String> headerLabels;
  final HeroContent hero;
  final List<MetricContent> metrics;
  final SectionCopy about;
  final SkillsContent skills;
  final WorksContent works;
  final WorkStyleContent workStyle;
  final ContactContent contact;
  final String footerText;

  static const ja = SiteContent(
    brandName: 'TM Developer',
    pageTitle: 'TM Developer',
    description: 'Flutter / Firebaseを中心に、iOSアプリの設計・開発・リリース・運用に対応する個人開発者サイトです。',
    email: 'tm.developer58@gmail.com',
    githubUrl: 'https://github.com/tm-developer58',
    headerLabels: ['Flutter', 'Firebase', 'App Store', 'Remote Work'],
    hero: HeroContent(
      eyebrow: 'Flutter / Firebase Developer',
      title: '小規模なアプリ開発・改修を、設計からリリースまで対応します。',
      body:
          '個人開発でiOSアプリを複数リリースしています。既存アプリの機能追加・修正、Firebase連携、App Storeリリース対応などに対応できます。',
      primaryActionLabel: '相談する',
      secondaryActionLabel: 'GitHub',
      mailSubject: 'アプリ開発の相談',
      panelTitle: 'Released Apps',
      panelBody: 'Flutter / Firebaseで設計・開発・リリース・運用まで経験しています。',
    ),
    metrics: [
      MetricContent(value: '3', label: '公開アプリ'),
      MetricContent(value: '5,000+', label: '運用ユーザー'),
      MetricContent(value: '2-3日', label: '週稼働目安'),
    ],
    about: SectionCopy(
      eyebrow: 'About',
      title: '個人開発で得た実装力を、実務の小さな前進に使います。',
      body:
          'Flutter / Firebaseを中心に個人開発をしています。独学でiOSアプリを複数リリースし、1つのアプリではアクティブユーザー約5,000人の運用経験があります。',
    ),
    skills: SkillsContent(
      eyebrow: 'Skills',
      title: '実装から運用まで、Flutterアプリに必要な範囲を扱います。',
      items: [
        SkillItem(Icons.flutter_dash, 'Flutter / Dart'),
        SkillItem(Icons.lock_outline, 'Firebase Authentication'),
        SkillItem(Icons.storage_outlined, 'Cloud Firestore'),
        SkillItem(Icons.cloud_upload_outlined, 'Firebase Storage'),
        SkillItem(Icons.functions, 'Cloud Functions / TypeScript'),
        SkillItem(Icons.ios_share, 'App Storeリリース'),
        SkillItem(Icons.schema_outlined, 'アプリ設計・開発・運用'),
      ],
    ),
    works: WorksContent(
      eyebrow: 'Works',
      title: 'App Storeで公開している個人開発アプリ',
      appStoreButtonLabel: 'App Store',
      techLabel: '使用技術',
      roleLabel: '担当範囲',
      roleValue: '設計・開発・リリース・運用',
      items: [
        AppWork(
          icon: Icons.coffee_outlined,
          title: 'コーヒータイマー',
          summary: 'コーヒーのレシピと豆を管理できるアプリ',
          tech: 'Flutter / Firebase',
          note: 'レシピや豆の情報を継続して管理しやすいよう、入力・保存・参照の流れをシンプルに設計しました。',
          url:
              'https://apps.apple.com/jp/app/コーヒータイマー-レシピと豆の管理アプリ/id6744885251',
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
      ],
    ),
    workStyle: WorkStyleContent(
      eyebrow: 'Work Style',
      title: '小さく始めて、着実に進める働き方',
      items: [
        WorkStyleItem(Icons.calendar_month_outlined, '週2〜3日程度'),
        WorkStyleItem(Icons.home_work_outlined, 'フルリモート希望'),
        WorkStyleItem(Icons.chat_bubble_outline, 'チャット中心'),
        WorkStyleItem(Icons.video_call_outlined, '短時間MTG対応可'),
        WorkStyleItem(Icons.construction_outlined, '設計・実装・Firebase連携が得意'),
      ],
    ),
    contact: ContactContent(
      eyebrow: 'Contact',
      title: 'アプリ開発・改修の相談',
      body: '既存Flutterアプリの改修、Firebase連携、App Storeリリース周りの相談に対応できます。',
      nameLabel: '名前',
      emailLabel: 'メールアドレス',
      subjectLabel: '件名',
      messageLabel: '本文',
      submitLabel: 'メールで送信',
      requiredMessage: '入力してください',
      invalidEmailMessage: 'メールアドレスを確認してください',
      mailNamePrefix: 'お名前',
      mailEmailPrefix: 'メール',
    ),
    footerText: 'TM Developer - Flutter / Firebase Developer',
  );
}

class HeroContent {
  const HeroContent({
    required this.eyebrow,
    required this.title,
    required this.body,
    required this.primaryActionLabel,
    required this.secondaryActionLabel,
    required this.mailSubject,
    required this.panelTitle,
    required this.panelBody,
  });

  final String eyebrow;
  final String title;
  final String body;
  final String primaryActionLabel;
  final String secondaryActionLabel;
  final String mailSubject;
  final String panelTitle;
  final String panelBody;
}

class MetricContent {
  const MetricContent({required this.value, required this.label});

  final String value;
  final String label;
}

class SectionCopy {
  const SectionCopy({
    required this.eyebrow,
    required this.title,
    required this.body,
  });

  final String eyebrow;
  final String title;
  final String body;
}

class SkillsContent {
  const SkillsContent({
    required this.eyebrow,
    required this.title,
    required this.items,
  });

  final String eyebrow;
  final String title;
  final List<SkillItem> items;
}

class WorksContent {
  const WorksContent({
    required this.eyebrow,
    required this.title,
    required this.items,
    required this.appStoreButtonLabel,
    required this.techLabel,
    required this.roleLabel,
    required this.roleValue,
  });

  final String eyebrow;
  final String title;
  final List<AppWork> items;
  final String appStoreButtonLabel;
  final String techLabel;
  final String roleLabel;
  final String roleValue;
}

class WorkStyleContent {
  const WorkStyleContent({
    required this.eyebrow,
    required this.title,
    required this.items,
  });

  final String eyebrow;
  final String title;
  final List<WorkStyleItem> items;
}

class ContactContent {
  const ContactContent({
    required this.eyebrow,
    required this.title,
    required this.body,
    required this.nameLabel,
    required this.emailLabel,
    required this.subjectLabel,
    required this.messageLabel,
    required this.submitLabel,
    required this.requiredMessage,
    required this.invalidEmailMessage,
    required this.mailNamePrefix,
    required this.mailEmailPrefix,
  });

  final String eyebrow;
  final String title;
  final String body;
  final String nameLabel;
  final String emailLabel;
  final String subjectLabel;
  final String messageLabel;
  final String submitLabel;
  final String requiredMessage;
  final String invalidEmailMessage;
  final String mailNamePrefix;
  final String mailEmailPrefix;
}
