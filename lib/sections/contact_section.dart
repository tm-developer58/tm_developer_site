import 'package:flutter/material.dart';

import '../content/site_content.dart';
import '../models/contact_message.dart';
import '../services/contact/contact_message_sender.dart';
import '../services/analytics/analytics_service.dart';
import '../utils/url_launcher_helper.dart';
import '../widgets/contact_form.dart';
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
  final _messageSender = const FirebaseContactMessageSender();
  bool _isSubmitting = false;
  bool _isError = false;
  String? _statusMessage;

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

    setState(() {
      _isSubmitting = true;
      _isError = false;
      _statusMessage = null;
    });

    try {
      await AnalyticsService.logContactClick(source: 'contact_form');
      await _messageSender.send(
        ContactMessage(
          name: _nameController.text,
          email: _emailController.text,
          subject: _subjectController.text,
          message: _messageController.text,
        ),
      );

      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();

      if (!mounted) {
        return;
      }
      setState(() {
        _isError = false;
        _statusMessage = widget.content.successMessage;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isError = true;
        _statusMessage = widget.content.failureMessage;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 860;
        final heading = Column(
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
          ],
        );

        final emailPanel = _ContactChoicePanel(
          icon: Icons.mail_outline,
          title: widget.content.emailOptionTitle,
          body: widget.content.emailOptionBody,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SelectableText(
                widget.email,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF2563EB),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () async {
                  await AnalyticsService.logContactClick(
                    source: 'contact_email_option',
                  );
                  await launchExternalUri(
                    Uri(scheme: 'mailto', path: widget.email),
                  );
                },
                icon: const Icon(Icons.open_in_new),
                label: Text(widget.content.emailOptionButtonLabel),
              ),
            ],
          ),
        );

        final formPanel = _ContactChoicePanel(
          icon: Icons.edit_note_outlined,
          title: widget.content.formOptionTitle,
          body: widget.content.formOptionBody,
          child: ContactForm(
            formKey: _formKey,
            content: widget.content,
            nameController: _nameController,
            emailController: _emailController,
            subjectController: _subjectController,
            messageController: _messageController,
            onSubmit: _submit,
            isSubmitting: _isSubmitting,
            statusMessage: _statusMessage,
            isError: _isError,
          ),
        );

        final choices = isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: emailPanel),
                  const SizedBox(width: 24),
                  Expanded(flex: 5, child: formPanel),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [emailPanel, const SizedBox(height: 18), formPanel],
              );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [heading, const SizedBox(height: 28), choices],
        );
      },
    );
  }
}

class _ContactChoicePanel extends StatelessWidget {
  const _ContactChoicePanel({
    required this.icon,
    required this.title,
    required this.body,
    required this.child,
  });

  final IconData icon;
  final String title;
  final String body;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF2563EB), size: 26),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF111827),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            body,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF4B5563),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}
