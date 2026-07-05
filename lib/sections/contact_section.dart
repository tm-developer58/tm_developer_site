import 'package:flutter/material.dart';

import '../content/site_content.dart';
import '../services/analytics/analytics_service.dart';
import '../utils/url_launcher_helper.dart';
import '../widgets/contact_form.dart';
import '../widgets/contact_line.dart';
import '../widgets/section_heading.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({required this.content, required this.email, super.key});

  final ContactContent content;
  final String email;

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
      '${widget.content.mailNamePrefix}: ${_nameController.text}',
      '${widget.content.mailEmailPrefix}: ${_emailController.text}',
      '',
      _messageController.text,
    ].join('\n');

    await AnalyticsService.logContactClick(source: 'contact_form');
    await launchExternalUri(
      Uri(
        scheme: 'mailto',
        path: widget.email,
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
          content: widget.content,
          nameController: _nameController,
          emailController: _emailController,
          subjectController: _subjectController,
          messageController: _messageController,
          onSubmit: _submit,
        );

        final copy = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeading(
              eyebrow: widget.content.eyebrow,
              title: widget.content.title,
            ),
            const SizedBox(height: 18),
            Text(
              widget.content.body,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF4B5563),
                height: 1.7,
              ),
            ),
            const SizedBox(height: 22),
            ContactLine(
              icon: Icons.mail_outline,
              text: widget.email,
              onTap: () async {
                await AnalyticsService.logContactClick(source: 'contact_line');
                await launchExternalUri(
                  Uri(scheme: 'mailto', path: widget.email),
                );
              },
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
