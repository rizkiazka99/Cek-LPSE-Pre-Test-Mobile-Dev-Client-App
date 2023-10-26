import 'package:ceklpse_pretest_mobiledev/app/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Size buttonSize;
  final TextStyle? textStyle;
  final Color? color;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.buttonSize = const Size(0, 0),
    this.color = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: buttonSize == const Size(0, 0)
            ? Size(
              MediaQuery.of(context).size.width * 0.9, 
              MediaQuery.of(context).size.height * 0.06
            ) : buttonSize,
        elevation: 2,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashFactory: NoSplash.splashFactory,
        backgroundColor: color,
        enableFeedback: true,
        textStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          )
      ),
    );
  }
}