import 'package:flutter/material.dart';

class CustomForm extends StatefulWidget {
  final Key? formKey;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType input;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const CustomForm({
    super.key,
    required this.formKey, 
    required this.autovalidateMode,
    required this.controller, 
    this.obscureText = false,
    this.input = TextInputType.text,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    required this.hintText, 
    this.suffixIcon, 
    this.prefixIcon, 
    required this.validator,
    this.onChanged
  });

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autovalidateMode,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.grey[700]),
          counterText: '',
          errorMaxLines: 4,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon
        ),
        validator: widget.validator,
        onChanged: widget.onChanged,
      )
    );
  }
}