import 'package:flutter/cupertino.dart';

class CustomButton extends StatelessWidget {

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
  });
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textColor = CupertinoDynamicColor.resolve(
      CupertinoColors.systemBlue,
      context,
    );
    final backgroundColor = CupertinoDynamicColor.resolve(
      CupertinoColors.systemGrey6,
      context,
    );
    return CupertinoButton(
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      borderRadius: BorderRadius.circular(20),
      color: backgroundColor,
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
