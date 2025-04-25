import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybookstore/shared/utils/bloc_utils.dart';
import 'package:mybookstore/shared/utils/color_utils.dart';
import 'package:mybookstore/shared/utils/global_utils.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    Observer<bool>? loading,
    required this.onTap,
    this.enabled = true,
    required this.text,
    this.icon,
  }) : loading = loading ?? false.obs();

  final Observer<bool> loading;
  final VoidCallback onTap;
  final bool enabled;
  final String text;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Observer<bool>, bool>(
      bloc: loading,
      builder: (context, value) {
        return ElevatedButton(
          onPressed: enabled ? onTap : null,
          style: ButtonStyle(
            backgroundColor:
                enabled
                    ? WidgetStatePropertyAll(primaryColor)
                    : WidgetStatePropertyAll(Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 8.0,
            children: [
              if (value)
                SizedBox.square(
                  dimension: 14.0,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              if (icon != null) Image.asset(icon!, color: Colors.white,height: 24,),
              Text(text),
            ],
          ),
        );
      },
    );
  }
}
