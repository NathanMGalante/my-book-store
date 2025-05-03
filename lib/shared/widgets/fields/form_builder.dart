import 'package:flutter/material.dart';

class FormBuilder extends StatefulWidget {
  const FormBuilder({
    super.key,
    required this.builder,
    this.formKey,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  final Widget Function(BuildContext, bool) builder;
  final GlobalKey<FormState>? formKey;
  final AutovalidateMode autovalidateMode;

  static _FormBuilderState? of(BuildContext context) {
    return context.findAncestorStateOfType<_FormBuilderState>();
  }

  @override
  State<FormBuilder> createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isValid = true;

  bool get isValid => _isValid;

  void validate() {
    _isValid = _formKey.currentState?.validate() ?? false;
    // setState(() => _isValid = _formKey.currentState?.validate() ?? false);
  }

  @override
  void initState() {
    if (widget.formKey != null) {
      _formKey = widget.formKey!;
    }
    validate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      // autovalidateMode: widget.autovalidateMode,
      onChanged: validate,
      child: Builder(builder: (context) => widget.builder(context, _isValid)),
    );
  }
}
