import 'package:flutter/material.dart';


class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Widget? prefixIcon;
  final bool isWhite;
  final bool usingSecColor;
  final bool usingBoldText;
  final bool isLoading;
  const PrimaryButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.isWhite = false,
    this.prefixIcon,
    this.usingSecColor = false,
    this.usingBoldText = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Colors.blue;
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(
            isWhite ? Colors.white : color,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                14,
              ),
              side: BorderSide(
                color: color,
                width: 2.5,
              ),
            ),
          ),
        ),
        child: Visibility(
          visible: !isLoading,
          replacement: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              prefixIcon ?? SizedBox(),
              Text(
                title,
                style: TextStyle(
                  fontWeight:
                      usingBoldText ? FontWeight.bold : FontWeight.normal,
                  color: isWhite ? color : Colors.white,
                ),
              ),
            ],
          ),
        ),
        onPressed: () {
          if (!isLoading) {
            if (onPressed != null) onPressed!();
          }
        },
      ),
    );
  }
}
