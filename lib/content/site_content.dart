import 'package:flutter/material.dart';

import '../models/app_work.dart';
import '../models/skill_item.dart';
import '../models/work_style_item.dart';
import '../services/locale/site_language.dart';

class SiteContent {
  const SiteContent({
    required this.brandName,
    required this.pageTitle,
    required this.description,
    required this.email,
    required this.githubUrl,
    required this.headerLabels,
    required this.navigation,
    required this.hero,
    required this.metrics,
    required this.about,
    required this.skills,
    required this.works,
    required this.workStyle,
    required this.contact,
    required this.privacyPolicy,
    required this.footerText,
    required this.footerPrivacyLabel,
  });

  final String brandName;
  final String pageTitle;
  final String description;
  final String email;
  final String githubUrl;
  final List<String> headerLabels;
  final SiteNavigationContent navigation;
  final HeroContent hero;
  final List<MetricContent> metrics;
  final SectionCopy about;
  final SkillsContent skills;
  final WorksContent works;
  final WorkStyleContent workStyle;
  final ContactContent contact;
  final PrivacyPolicyContent privacyPolicy;
  final String footerText;
  final String footerPrivacyLabel;

  static SiteContent forLanguage(SiteLanguage language) {
    return switch (language) {
      SiteLanguage.ja => ja,
      SiteLanguage.en => en,
    };
  }

  static const ja = SiteContent(
    brandName: 'TM Developer',
    pageTitle: 'TM Developer',
    description: 'Flutter / Firebaseを中心に、iOSアプリの設計・開発・リリース・運用に対応する個人開発者サイトです。',
    email: 'tm.developer58@gmail.com',
    githubUrl: 'https://github.com/tm-developer58',
    headerLabels: ['Flutter', 'Firebase', 'App Store', 'Remote Work'],
    navigation: SiteNavigationContent(
      worksLabel: '実績',
      skillsLabel: 'スキル',
      workStyleLabel: '働き方',
      contactLabel: '相談する',
      languageToggleSemanticsLabel: '英語表示に切り替える',
    ),
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
      MetricContent(icon: Icons.apps_rounded, value: '3', label: '公開アプリ'),
      MetricContent(
        icon: Icons.people_alt_outlined,
        value: '5,000+',
        label: '運用ユーザー',
      ),
      MetricContent(
        icon: Icons.calendar_today_outlined,
        value: '2〜3日',
        label: '週稼働目安',
      ),
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
          iconAsset: 'assets/apps/coffee_timer/icon.jpg',
          screenshotAsset: 'assets/apps/coffee_timer/screenshot.jpg',
          title: 'コーヒータイマー',
          summary: 'コーヒーのレシピと豆を管理できるアプリ',
          tech: 'Flutter / Firebase',
          note: 'レシピや豆の情報を継続して管理しやすいよう、入力・保存・参照の流れをシンプルに設計しました。',
          url:
              'https://apps.apple.com/jp/app/コーヒータイマー-レシピと豆の管理アプリ/id6744885251',
        ),
        AppWork(
          icon: Icons.volume_up_outlined,
          iconAsset: 'assets/apps/volume_changer/icon.jpg',
          screenshotAsset: 'assets/apps/volume_changer/screenshot.jpg',
          title: '音量調整アプリ',
          summary: '音量を細かく調整できるユーティリティアプリ',
          tech: 'Flutter',
          note: '日常的にすぐ使えるよう、操作をできるだけ少なくし、シンプルな機能に絞って実装しました。',
          url: 'https://apps.apple.com/jp/app/音量調整-音量を微調整できるアプリ/id6502644391',
        ),
        AppWork(
          icon: Icons.restaurant_menu_outlined,
          iconAsset: 'assets/apps/recipe_archive/icon.jpg',
          screenshotAsset: 'assets/apps/recipe_archive/screenshot.jpg',
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
      emailOptionTitle: 'メールで直接相談',
      emailOptionBody:
          'メールアプリを開いて送信します。添付資料がある場合や、普段のメールから連絡したい場合はこちらを使ってください。',
      emailOptionButtonLabel: 'メールを開く',
      formOptionTitle: 'フォームで送信',
      formOptionBody: 'このページから送信します。入力内容は問い合わせ確認用に保存されます。',
      nameLabel: '名前',
      emailLabel: 'メールアドレス',
      subjectLabel: '件名',
      messageLabel: '本文',
      submitLabel: '送信する',
      submittingLabel: '送信中',
      successMessage: '送信しました。確認後に返信します。',
      failureMessage: '送信できませんでした。メールリンクからご連絡ください。',
      requiredMessage: '入力してください',
      invalidEmailMessage: 'メールアドレスを確認してください',
      maxLengthMessageTemplate: '{label}は{maxLength}文字以内で入力してください',
      mailNamePrefix: 'お名前',
      mailEmailPrefix: 'メール',
    ),
    privacyPolicy: PrivacyPolicyContent(
      pageTitle: 'プライバシーポリシー',
      backToHomeLabel: 'トップへ戻る',
      lastUpdatedLabel: '制定日: 2026年7月5日',
      intro:
          'TM Developer（以下「当サイト」）は、当サイトの利用者に関する情報を適切に取り扱うため、以下の通りプライバシーポリシーを定めます。',
      sections: [
        PrivacyPolicySection(
          title: '取得する情報',
          body:
              '当サイトでは、お問い合わせ時に入力された氏名、メールアドレス、件名、本文を取得する場合があります。また、アクセス解析のため、Cookie等を利用して閲覧状況に関する情報を取得する場合があります。',
        ),
        PrivacyPolicySection(
          title: '利用目的',
          body: '取得した情報は、お問い合わせへの返信、サービス改善、サイト利用状況の把握、必要な連絡のために利用します。',
        ),
        PrivacyPolicySection(
          title: 'アクセス解析について',
          body:
              '当サイトでは、Google Analytics 4を利用しています。Google AnalyticsはCookie等を利用して、利用者の訪問状況を収集します。収集される情報は個人を直接特定するものではありません。',
        ),
        PrivacyPolicySection(
          title: '第三者提供',
          body: '法令に基づく場合を除き、取得した個人情報を本人の同意なく第三者へ提供することはありません。',
        ),
        PrivacyPolicySection(
          title: '外部リンク',
          body:
              '当サイトには外部サイトへのリンクが含まれる場合があります。外部サイトでの個人情報の取り扱いについて、当サイトは責任を負いません。',
        ),
        PrivacyPolicySection(
          title: 'お問い合わせ',
          body: '本ポリシーに関するお問い合わせは、当サイトのお問い合わせ先メールアドレスまでご連絡ください。',
        ),
        PrivacyPolicySection(
          title: '変更について',
          body: '本ポリシーの内容は、必要に応じて変更する場合があります。変更後の内容は、当サイトに掲載した時点で有効となります。',
        ),
      ],
    ),
    footerText: 'TM Developer - Flutter / Firebase Developer',
    footerPrivacyLabel: 'プライバシーポリシー',
  );

  static const en = SiteContent(
    brandName: 'TM Developer',
    pageTitle: 'TM Developer | Flutter & Firebase Developer',
    description:
        'Independent Flutter and Firebase developer providing iOS app design, development, release, and ongoing support.',
    email: 'tm.developer58@gmail.com',
    githubUrl: 'https://github.com/tm-developer58',
    headerLabels: ['Flutter', 'Firebase', 'App Store', 'Remote Work'],
    navigation: SiteNavigationContent(
      worksLabel: 'Work',
      skillsLabel: 'Skills',
      workStyleLabel: 'Work Style',
      contactLabel: 'Contact',
      languageToggleSemanticsLabel: 'Switch to Japanese',
    ),
    hero: HeroContent(
      eyebrow: 'Flutter / Firebase Developer',
      title: 'From planning to release, I help ship focused app improvements.',
      body:
          'I independently develop and publish iOS apps. I can help enhance existing Flutter apps, integrate Firebase, resolve issues, and support App Store releases.',
      primaryActionLabel: 'Discuss a project',
      secondaryActionLabel: 'GitHub',
      mailSubject: 'App development inquiry',
      panelTitle: 'Released Apps',
      panelBody:
          'Hands-on experience across design, development, release, and ongoing operation with Flutter and Firebase.',
    ),
    metrics: [
      MetricContent(
        icon: Icons.apps_rounded,
        value: '3',
        label: 'Apps released',
      ),
      MetricContent(
        icon: Icons.people_alt_outlined,
        value: '5,000+',
        label: 'Active users',
      ),
      MetricContent(
        icon: Icons.calendar_today_outlined,
        value: '2-3 days',
        label: 'Available per week',
      ),
    ],
    about: SectionCopy(
      eyebrow: 'About',
      title: 'Practical product experience that moves your app forward.',
      body:
          'I am an independent developer specializing in Flutter and Firebase. I have taught myself to build and release multiple iOS apps, including one serving approximately 5,000 active users.',
    ),
    skills: SkillsContent(
      eyebrow: 'Skills',
      title: 'End-to-end Flutter expertise, from implementation to operation.',
      items: [
        SkillItem(Icons.flutter_dash, 'Flutter / Dart'),
        SkillItem(Icons.lock_outline, 'Firebase Authentication'),
        SkillItem(Icons.storage_outlined, 'Cloud Firestore'),
        SkillItem(Icons.cloud_upload_outlined, 'Firebase Storage'),
        SkillItem(Icons.functions, 'Cloud Functions / TypeScript'),
        SkillItem(Icons.ios_share, 'App Store releases'),
        SkillItem(Icons.schema_outlined, 'App design, development & operation'),
      ],
    ),
    works: WorksContent(
      eyebrow: 'Work',
      title: 'Independent apps published on the App Store',
      appStoreButtonLabel: 'View on App Store',
      techLabel: 'Technology',
      roleLabel: 'Responsibilities',
      roleValue: 'Design, development, release, and operation',
      items: [
        AppWork(
          icon: Icons.coffee_outlined,
          iconAsset: 'assets/apps/coffee_timer/icon.jpg',
          screenshotAsset: 'assets/apps/coffee_timer/screenshot.jpg',
          title: 'Coffee Timer',
          summary: 'A coffee recipe and bean management app',
          tech: 'Flutter / Firebase',
          note:
              'Designed a straightforward flow for entering, saving, and reviewing recipes and bean details over time.',
          url:
              'https://apps.apple.com/jp/app/コーヒータイマー-レシピと豆の管理アプリ/id6744885251',
        ),
        AppWork(
          icon: Icons.volume_up_outlined,
          iconAsset: 'assets/apps/volume_changer/icon.jpg',
          screenshotAsset: 'assets/apps/volume_changer/screenshot.jpg',
          title: 'Volume Control',
          summary: 'A utility for making precise volume adjustments',
          tech: 'Flutter',
          note:
              'Kept interactions to a minimum and focused the feature set so the app is quick to use in everyday situations.',
          url: 'https://apps.apple.com/jp/app/音量調整-音量を微調整できるアプリ/id6502644391',
        ),
        AppWork(
          icon: Icons.restaurant_menu_outlined,
          iconAsset: 'assets/apps/recipe_archive/icon.jpg',
          screenshotAsset: 'assets/apps/recipe_archive/screenshot.jpg',
          title: 'Recipe Archive',
          summary: 'An app for saving, tagging, and generating recipes',
          tech: 'Flutter / Firebase / TypeScript',
          note:
              'Designed the saving, categorization, and browsing experience to make recipes easy to find again later.',
          url: 'https://apps.apple.com/jp/app/レシピ保管庫-保存とタグ管理/id6752911070',
        ),
      ],
    ),
    workStyle: WorkStyleContent(
      eyebrow: 'Work Style',
      title: 'Start small and make steady, dependable progress.',
      items: [
        WorkStyleItem(
          Icons.calendar_month_outlined,
          'Available 2-3 days per week',
        ),
        WorkStyleItem(Icons.home_work_outlined, 'Fully remote preferred'),
        WorkStyleItem(Icons.chat_bubble_outline, 'Asynchronous chat first'),
        WorkStyleItem(
          Icons.video_call_outlined,
          'Available for short meetings',
        ),
        WorkStyleItem(
          Icons.construction_outlined,
          'Strong in design, implementation, and Firebase integration',
        ),
      ],
    ),
    contact: ContactContent(
      eyebrow: 'Contact',
      title: 'Discuss app development or improvements',
      body:
          'I can help with existing Flutter app improvements, Firebase integrations, and App Store release support.',
      emailOptionTitle: 'Contact me by email',
      emailOptionBody:
          'Open your email app to send a message. Choose this option if you need to attach files or prefer using your usual email client.',
      emailOptionButtonLabel: 'Open email app',
      formOptionTitle: 'Send the form',
      formOptionBody:
          'Send your inquiry directly from this page. Your submission is stored so I can review and respond to it.',
      nameLabel: 'Name',
      emailLabel: 'Email address',
      subjectLabel: 'Subject',
      messageLabel: 'Message',
      submitLabel: 'Send message',
      submittingLabel: 'Sending',
      successMessage:
          'Your message has been sent. I will reply after reviewing it.',
      failureMessage:
          'Your message could not be sent. Please contact me using the email link.',
      requiredMessage: 'This field is required',
      invalidEmailMessage: 'Enter a valid email address',
      maxLengthMessageTemplate:
          '{label} must be {maxLength} characters or fewer',
      mailNamePrefix: 'Name',
      mailEmailPrefix: 'Email',
    ),
    privacyPolicy: PrivacyPolicyContent(
      pageTitle: 'Privacy Policy',
      backToHomeLabel: 'Back to home',
      lastUpdatedLabel: 'Effective date: July 5, 2026',
      intro:
          'TM Developer ("this site") has established this Privacy Policy to explain how information about visitors is handled appropriately.',
      sections: [
        PrivacyPolicySection(
          title: 'Information collected',
          body:
              'This site may collect the name, email address, subject, and message entered when a visitor submits an inquiry. It may also use cookies and similar technologies to collect information about browsing activity for analytics purposes.',
        ),
        PrivacyPolicySection(
          title: 'How information is used',
          body:
              'Collected information is used to respond to inquiries, improve services, understand site usage, and provide necessary communications.',
        ),
        PrivacyPolicySection(
          title: 'Analytics',
          body:
              'This site uses Google Analytics 4. Google Analytics uses cookies and similar technologies to collect information about visits. The information collected does not directly identify individual visitors.',
        ),
        PrivacyPolicySection(
          title: 'Disclosure to third parties',
          body:
              'Personal information will not be disclosed to third parties without the individual\'s consent, except where required by law.',
        ),
        PrivacyPolicySection(
          title: 'External links',
          body:
              'This site may contain links to external websites. This site is not responsible for how those external websites handle personal information.',
        ),
        PrivacyPolicySection(
          title: 'Contact',
          body:
              'For questions about this Privacy Policy, please use the contact email address provided on this site.',
        ),
        PrivacyPolicySection(
          title: 'Changes to this policy',
          body:
              'This policy may be updated when necessary. Any changes take effect when the revised policy is published on this site.',
        ),
      ],
    ),
    footerText: 'TM Developer - Flutter / Firebase Developer',
    footerPrivacyLabel: 'Privacy Policy',
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

class SiteNavigationContent {
  const SiteNavigationContent({
    required this.worksLabel,
    required this.skillsLabel,
    required this.workStyleLabel,
    required this.contactLabel,
    required this.languageToggleSemanticsLabel,
  });

  final String worksLabel;
  final String skillsLabel;
  final String workStyleLabel;
  final String contactLabel;
  final String languageToggleSemanticsLabel;
}

class MetricContent {
  const MetricContent({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
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
    required this.emailOptionTitle,
    required this.emailOptionBody,
    required this.emailOptionButtonLabel,
    required this.formOptionTitle,
    required this.formOptionBody,
    required this.nameLabel,
    required this.emailLabel,
    required this.subjectLabel,
    required this.messageLabel,
    required this.submitLabel,
    required this.submittingLabel,
    required this.successMessage,
    required this.failureMessage,
    required this.requiredMessage,
    required this.invalidEmailMessage,
    required this.maxLengthMessageTemplate,
    required this.mailNamePrefix,
    required this.mailEmailPrefix,
  });

  final String eyebrow;
  final String title;
  final String body;
  final String emailOptionTitle;
  final String emailOptionBody;
  final String emailOptionButtonLabel;
  final String formOptionTitle;
  final String formOptionBody;
  final String nameLabel;
  final String emailLabel;
  final String subjectLabel;
  final String messageLabel;
  final String submitLabel;
  final String submittingLabel;
  final String successMessage;
  final String failureMessage;
  final String requiredMessage;
  final String invalidEmailMessage;
  final String maxLengthMessageTemplate;
  final String mailNamePrefix;
  final String mailEmailPrefix;

  String maxLengthMessage(String label, int maxLength) {
    return maxLengthMessageTemplate
        .replaceAll('{label}', label)
        .replaceAll('{maxLength}', '$maxLength');
  }
}

class PrivacyPolicyContent {
  const PrivacyPolicyContent({
    required this.pageTitle,
    required this.backToHomeLabel,
    required this.lastUpdatedLabel,
    required this.intro,
    required this.sections,
  });

  final String pageTitle;
  final String backToHomeLabel;
  final String lastUpdatedLabel;
  final String intro;
  final List<PrivacyPolicySection> sections;
}

class PrivacyPolicySection {
  const PrivacyPolicySection({required this.title, required this.body});

  final String title;
  final String body;
}
