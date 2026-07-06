import 'package:flutter/material.dart';

import '../content/site_content.dart';

class ContactForm extends StatelessWidget {
  const ContactForm({
    required this.formKey,
    required this.content,
    required this.nameController,
    required this.emailController,
    required this.subjectController,
    required this.messageController,
    required this.onSubmit,
    this.isSubmitting = false,
    this.statusMessage,
    this.isError = false,
    super.key,
  });

  static const nameMaxLength = 50;
  static const emailMaxLength = 100;
  static const subjectMaxLength = 100;
  static const messageMaxLength = 1000;

  final GlobalKey<FormState> formKey;
  final ContactContent content;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController subjectController;
  final TextEditingController messageController;
  final VoidCallback onSubmit;
  final bool isSubmitting;
  final String? statusMessage;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ContactTextField(
            controller: nameController,
            label: content.nameLabel,
            maxLength: nameMaxLength,
            validator: (value) => _textValidator(
              value,
              content: content,
              label: content.nameLabel,
              maxLength: nameMaxLength,
            ),
          ),
          const SizedBox(height: 14),
          _ContactTextField(
            controller: emailController,
            label: content.emailLabel,
            keyboardType: TextInputType.emailAddress,
            maxLength: emailMaxLength,
            validator: (value) => _emailValidator(value, content),
          ),
          const SizedBox(height: 14),
          _ContactTextField(
            controller: subjectController,
            label: content.subjectLabel,
            maxLength: subjectMaxLength,
            validator: (value) => _textValidator(
              value,
              content: content,
              label: content.subjectLabel,
              maxLength: subjectMaxLength,
            ),
          ),
          const SizedBox(height: 14),
          _ContactTextField(
            controller: messageController,
            label: content.messageLabel,
            maxLines: 5,
            maxLength: messageMaxLength,
            validator: (value) => _textValidator(
              value,
              content: content,
              label: content.messageLabel,
              maxLength: messageMaxLength,
            ),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: isSubmitting ? null : onSubmit,
            icon: isSubmitting
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.send_outlined),
            label: Text(
              isSubmitting ? content.submittingLabel : content.submitLabel,
            ),
          ),
          if (statusMessage != null) ...[
            const SizedBox(height: 12),
            Text(
              statusMessage!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isError
                    ? Theme.of(context).colorScheme.error
                    : const Color(0xFF166534),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ContactTextField extends StatelessWidget {
  const _ContactTextField({
    required this.controller,
    required this.label,
    required this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
  });

  final TextEditingController controller;
  final String label;
  final FormFieldValidator<String> validator;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
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

String? _requiredValidator(String? value, ContactContent content) {
  if (value == null || value.trim().isEmpty) {
    return content.requiredMessage;
  }
  return null;
}

String? _emailValidator(String? value, ContactContent content) {
  final message = _requiredValidator(value, content);
  if (message != null) {
    return message;
  }
  final email = value!.trim();
  final lengthMessage = _maxLengthValidator(
    email,
    label: content.emailLabel,
    maxLength: ContactForm.emailMaxLength,
  );
  if (lengthMessage != null) {
    return lengthMessage;
  }
  final emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  if (!emailPattern.hasMatch(email)) {
    return content.invalidEmailMessage;
  }
  return null;
}

String? _textValidator(
  String? value, {
  required ContactContent content,
  required String label,
  required int maxLength,
}) {
  final message = _requiredValidator(value, content);
  if (message != null) {
    return message;
  }
  return _maxLengthValidator(value!.trim(), label: label, maxLength: maxLength);
}

String? _maxLengthValidator(
  String value, {
  required String label,
  required int maxLength,
}) {
  if (value.length > maxLength) {
    return '$labelは$maxLength文字以内で入力してください';
  }
  return null;
}
