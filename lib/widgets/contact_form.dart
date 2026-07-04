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
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final ContactContent content;
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
          _ContactTextField(
            controller: nameController,
            label: content.nameLabel,
            validator: (value) => _requiredValidator(value, content),
          ),
          const SizedBox(height: 14),
          _ContactTextField(
            controller: emailController,
            label: content.emailLabel,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => _emailValidator(value, content),
          ),
          const SizedBox(height: 14),
          _ContactTextField(
            controller: subjectController,
            label: content.subjectLabel,
            validator: (value) => _requiredValidator(value, content),
          ),
          const SizedBox(height: 14),
          _ContactTextField(
            controller: messageController,
            label: content.messageLabel,
            maxLines: 5,
            validator: (value) => _requiredValidator(value, content),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: onSubmit,
            icon: const Icon(Icons.send_outlined),
            label: Text(content.submitLabel),
          ),
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
  if (!value!.contains('@')) {
    return content.invalidEmailMessage;
  }
  return null;
}
