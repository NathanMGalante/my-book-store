import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybookstore/shared/utils/color_utils.dart';
import 'package:mybookstore/shared/utils/image_path_utils.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    required this.label,
    this.inputType,
    this.validator,
    String? value,
    this.onChanged,
    this.onTap,
    TextEditingController? controller,
    this.readOnly = false,
  }) : value = value ?? controller?.value.text,
       controller = controller ?? TextEditingController(text: value);

  final String? value;
  final String label;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final bool readOnly;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final FocusNode focusNode;

  bool get _isPasswordMode => widget.inputType == TextInputType.visiblePassword;

  bool _isHidingPassword = true;

  @override
  void initState() {
    widget.controller.text = widget.value ?? '';
    focusNode = FocusNode();
    focusNode.addListener(() => setState(() {}));
    widget.controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: widget.controller.value.text,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        return InputDecorator(
          isFocused: focusNode.hasFocus,
          decoration: InputDecoration(
            fillColor:
                state.errorText != null
                    ? bgDangerColor
                    : focusNode.hasFocus
                    ? bgColor
                    : inputBgColor,
            filled: true,
            isCollapsed: true,
            errorText: state.errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2.0, color: darkColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2.0, color: dangerColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2.0, color: dangerColor),
            ),
          ),
          child: TextField(
            focusNode: focusNode,
            controller: widget.controller,
            keyboardType: widget.inputType,
            obscureText: _isPasswordMode && _isHidingPassword,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            onChanged: (value) {
              state.didChange(value);
              widget.onChanged?.call(value);
              setState(() {});
            },
            decoration: InputDecoration(
              labelText: widget.label,
              suffixIcon:
                  !_isPasswordMode
                      ? null
                      : InkWell(
                        onTap: () {
                          setState(
                            () => _isHidingPassword = !_isHidingPassword,
                          );
                        },
                        child: Visibility(
                          visible: _isHidingPassword,
                          replacement: Image.asset(
                            viewIconImage,
                            height: 16,
                            width: 16,
                            scale: 2.5,
                          ),
                          child: Image.asset(
                            hideIconImage,
                            height: 16,
                            width: 16,
                            scale: 2.5,
                          ),
                        ),
                      ),
              contentPadding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 8.0,
                bottom: 4.0,
              ),
              floatingLabelStyle: GoogleFonts.poppins(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                backgroundColor: Colors.transparent,
                color: labelColor,
              ),
              labelStyle: GoogleFonts.poppins(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                backgroundColor: Colors.transparent,
                color: labelColor,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
            ),
          ),
        );
      },
    );
  }
}
