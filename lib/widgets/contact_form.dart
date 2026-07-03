import 'package:flutter/material.dart';

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
          _ContactTextField(
            controller: nameController,
            label: '名前',
            validator: _requiredValidator,
          ),
          const SizedBox(height: 14),
          _ContactTextField(
            controller: emailController,
            label: 'メールアドレス',
            keyboardType: TextInputType.emailAddress,
            validator: _emailValidator,
          ),
          const SizedBox(height: 14),
          _ContactTextField(
            controller: subjectController,
            label: '件名',
            validator: _requiredValidator,
          ),
          const SizedBox(height: 14),
          _ContactTextField(
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
