import 'package:flutter/material.dart';
import 'package:show_flutter/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
    this.text,
  });

  final bool disabled;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size5),
          color: disabled
              ? Theme.of(context).disabledColor
              : Theme.of(context).primaryColor,
        ),
        duration: const Duration(milliseconds: 500),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 500),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
          child: Text(
            text ?? "Next",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
