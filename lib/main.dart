import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const TmDeveloperSiteApp());
}

class TmDeveloperSiteApp extends StatelessWidget {
  const TmDeveloperSiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TM Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        textTheme: Typography.blackCupertino.apply(
          bodyColor: const Color(0xFF182033),
          displayColor: const Color(0xFF182033),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SiteHeader(),
              HeroSection(),
              SectionBand(child: AboutSection()),
              SectionBand(tinted: true, child: SkillsSection()),
              SectionBand(child: WorksSection()),
              SectionBand(tinted: true, child: WorkStyleSection()),
              SectionBand(child: ContactSection()),
              SiteFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

class SiteHeader extends StatelessWidget {
  const SiteHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final brand = Text(
                'TM Developer',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF111827),
                ),
              );
              const labels = Wrap(
                spacing: 18,
                runSpacing: 8,
                children: [
                  HeaderLabel(text: 'Flutter'),
                  HeaderLabel(text: 'Firebase'),
                  HeaderLabel(text: 'App Store'),
                  HeaderLabel(text: 'Remote Work'),
                ],
              );

              if (constraints.maxWidth >= 860) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [brand, labels],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [brand, const SizedBox(height: 12), labels],
              );
            },
          ),
        ),
      ),
    );
  }
}

class HeaderLabel extends StatelessWidget {
  const HeaderLabel({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: const Color(0xFF4B5563),
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 42, 24, 56),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 860;
              final content = [
                const Expanded(flex: 6, child: HeroCopy()),
                if (isWide) const SizedBox(width: 48),
                const Expanded(flex: 4, child: HeroCapabilityPanel()),
              ];

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: content,
                );
              }

              return const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HeroCopy(),
                  SizedBox(height: 32),
                  HeroCapabilityPanel(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class HeroCopy extends StatelessWidget {
  const HeroCopy({super.key});

  @override
  Widget build(BuildContext context) {
    final headlineStyle = Theme.of(context).textTheme.displaySmall?.copyWith(
      height: 1.18,
      fontWeight: FontWeight.w800,
      color: const Color(0xFF111827),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SectionEyebrow(text: 'Flutter / Firebase Developer'),
        const SizedBox(height: 16),
        Text('小規模なアプリ開発・改修を、設計からリリースまで対応します。', style: headlineStyle),
        const SizedBox(height: 20),
        Text(
          '個人開発でiOSアプリを複数リリースしています。既存アプリの機能追加・修正、Firebase連携、App Storeリリース対応などに対応できます。',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            height: 1.7,
            color: const Color(0xFF4B5563),
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              onPressed: () => _launchUri(
                Uri(
                  scheme: 'mailto',
                  path: 'tm.developer58@gmail.com',
                  queryParameters: {'subject': 'アプリ開発の相談'},
                ),
              ),
              icon: const Icon(Icons.mail_outline),
              label: const Text('相談する'),
            ),
            OutlinedButton.icon(
              onPressed: () =>
                  _launchUri(Uri.parse('https://github.com/tm-developer58')),
              icon: const Icon(Icons.code),
              label: const Text('GitHub'),
            ),
          ],
        ),
      ],
    );
  }
}

class HeroCapabilityPanel extends StatelessWidget {
  const HeroCapabilityPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.phone_iphone, color: Color(0xFF93C5FD), size: 42),
          const SizedBox(height: 28),
          Text(
            'Released Apps',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Flutter / Firebaseで設計・開発・リリース・運用まで経験しています。',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFD1D5DB),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 26),
          const Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              MetricPill(value: '3', label: '公開アプリ'),
              MetricPill(value: '5,000+', label: '運用ユーザー'),
              MetricPill(value: '2-3日', label: '週稼働目安'),
            ],
          ),
        ],
      ),
    );
  }
}

class MetricPill extends StatelessWidget {
  const MetricPill({required this.value, required this.label, super.key});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF374151)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: const Color(0xFFD1D5DB)),
          ),
        ],
      ),
    );
  }
}

class SectionBand extends StatelessWidget {
  const SectionBand({required this.child, this.tinted = false, super.key});

  final Widget child;
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: tinted ? const Color(0xFFF0F4F8) : const Color(0xFFF7F8FA),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 54),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: child,
        ),
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionLayout(
      eyebrow: 'About',
      title: '個人開発で得た実装力を、実務の小さな前進に使います。',
      body:
          'Flutter / Firebaseを中心に個人開発をしています。独学でiOSアプリを複数リリースし、1つのアプリではアクティブユーザー約5,000人の運用経験があります。',
    );
  }
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const _skills = [
    SkillItem(Icons.flutter_dash, 'Flutter / Dart'),
    SkillItem(Icons.lock_outline, 'Firebase Authentication'),
    SkillItem(Icons.storage_outlined, 'Cloud Firestore'),
    SkillItem(Icons.cloud_upload_outlined, 'Firebase Storage'),
    SkillItem(Icons.functions, 'Cloud Functions / TypeScript'),
    SkillItem(Icons.ios_share, 'App Storeリリース'),
    SkillItem(Icons.schema_outlined, 'アプリ設計・開発・運用'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(
          eyebrow: 'Skills',
          title: '実装から運用まで、Flutterアプリに必要な範囲を扱います。',
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _skills.map((skill) => SkillChip(item: skill)).toList(),
        ),
      ],
    );
  }
}

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

class WorkStyleSection extends StatelessWidget {
  const WorkStyleSection({super.key});

  static const _items = [
    WorkStyleItem(Icons.calendar_month_outlined, '週2〜3日程度'),
    WorkStyleItem(Icons.home_work_outlined, 'フルリモート希望'),
    WorkStyleItem(Icons.chat_bubble_outline, 'チャット中心'),
    WorkStyleItem(Icons.video_call_outlined, '短時間MTG対応可'),
    WorkStyleItem(Icons.construction_outlined, '設計・実装・Firebase連携が得意'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(eyebrow: 'Work Style', title: '小さく始めて、着実に進める働き方'),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth >= 760
                ? (constraints.maxWidth - 16) / 2
                : constraints.maxWidth;

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _items
                  .map(
                    (item) => SizedBox(
                      width: width,
                      child: WorkStyleRow(item: item),
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

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final body = [
      'お名前: ${_nameController.text}',
      'メール: ${_emailController.text}',
      '',
      _messageController.text,
    ].join('\n');

    await _launchUri(
      Uri(
        scheme: 'mailto',
        path: 'tm.developer58@gmail.com',
        queryParameters: {'subject': _subjectController.text, 'body': body},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 860;
        final form = ContactForm(
          formKey: _formKey,
          nameController: _nameController,
          emailController: _emailController,
          subjectController: _subjectController,
          messageController: _messageController,
          onSubmit: _submit,
        );

        final copy = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(eyebrow: 'Contact', title: 'アプリ開発・改修の相談'),
            const SizedBox(height: 18),
            Text(
              '既存Flutterアプリの改修、Firebase連携、App Storeリリース周りの相談に対応できます。',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF4B5563),
                height: 1.7,
              ),
            ),
            const SizedBox(height: 22),
            ContactLine(
              icon: Icons.mail_outline,
              text: 'tm.developer58@gmail.com',
              onTap: () => _launchUri(
                Uri(scheme: 'mailto', path: 'tm.developer58@gmail.com'),
              ),
            ),
          ],
        );

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 4, child: copy),
              const SizedBox(width: 44),
              Expanded(flex: 5, child: form),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [copy, const SizedBox(height: 28), form],
        );
      },
    );
  }
}

class SectionLayout extends StatelessWidget {
  const SectionLayout({
    required this.eyebrow,
    required this.title,
    required this.body,
    super.key,
  });

  final String eyebrow;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 760;
        final heading = SectionHeading(eyebrow: eyebrow, title: title);
        final content = Text(
          body,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF4B5563),
            height: 1.8,
          ),
        );

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 2),
              Expanded(flex: 4, child: heading),
              const SizedBox(width: 52),
              Expanded(flex: 5, child: content),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [heading, const SizedBox(height: 18), content],
        );
      },
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({required this.eyebrow, required this.title, super.key});

  final String eyebrow;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionEyebrow(text: eyebrow),
        const SizedBox(height: 10),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            height: 1.35,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF111827),
          ),
        ),
      ],
    );
  }
}

class SectionEyebrow extends StatelessWidget {
  const SectionEyebrow({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: const Color(0xFF2563EB),
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class SkillChip extends StatelessWidget {
  const SkillChip({required this.item, super.key});

  final SkillItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 340),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(item.icon, size: 20, color: const Color(0xFF0F766E)),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              item.label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
              onPressed: () => _launchUri(Uri.parse(work.url)),
              icon: const Icon(Icons.open_in_new, size: 18),
              label: const Text('App Store'),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoLabel extends StatelessWidget {
  const InfoLabel({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: const Color(0xFF374151),
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}

class WorkStyleRow extends StatelessWidget {
  const WorkStyleRow({required this.item, super.key});

  final WorkStyleItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Icon(item.icon, color: const Color(0xFFD97706)),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              item.label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactLine extends StatelessWidget {
  const ContactLine({
    required this.icon,
    required this.text,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: const Color(0xFF2563EB)),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF2563EB),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactForm extends StatelessWidget {
  const ContactForm({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.subjectController,
    required this.messageController,
    required this.onSubmit,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController subjectController;
  final TextEditingController messageController;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ContactTextField(
            controller: nameController,
            label: '名前',
            validator: _requiredValidator,
          ),
          const SizedBox(height: 14),
          ContactTextField(
            controller: emailController,
            label: 'メールアドレス',
            keyboardType: TextInputType.emailAddress,
            validator: _emailValidator,
          ),
          const SizedBox(height: 14),
          ContactTextField(
            controller: subjectController,
            label: '件名',
            validator: _requiredValidator,
          ),
          const SizedBox(height: 14),
          ContactTextField(
            controller: messageController,
            label: '本文',
            maxLines: 5,
            validator: _requiredValidator,
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: onSubmit,
            icon: const Icon(Icons.send_outlined),
            label: const Text('メールで送信'),
          ),
        ],
      ),
    );
  }
}

class ContactTextField extends StatelessWidget {
  const ContactTextField({
    required this.controller,
    required this.label,
    required this.validator,
    this.keyboardType,
    this.maxLines = 1,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final FormFieldValidator<String> validator;
  final TextInputType? keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
        ),
      ),
    );
  }
}

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF111827),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Text(
            'TM Developer - Flutter / Firebase Developer',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: const Color(0xFFD1D5DB)),
          ),
        ),
      ),
    );
  }
}

class SkillItem {
  const SkillItem(this.icon, this.label);

  final IconData icon;
  final String label;
}

class AppWork {
  const AppWork({
    required this.icon,
    required this.title,
    required this.summary,
    required this.tech,
    required this.note,
    required this.url,
  });

  final IconData icon;
  final String title;
  final String summary;
  final String tech;
  final String note;
  final String url;
}

class WorkStyleItem {
  const WorkStyleItem(this.icon, this.label);

  final IconData icon;
  final String label;
}

String? _requiredValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return '入力してください';
  }
  return null;
}

String? _emailValidator(String? value) {
  final message = _requiredValidator(value);
  if (message != null) {
    return message;
  }
  if (!value!.contains('@')) {
    return 'メールアドレスを確認してください';
  }
  return null;
}

Future<void> _launchUri(Uri uri) async {
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}
