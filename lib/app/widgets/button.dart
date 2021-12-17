import 'package:flutter/material.dart';
import 'package:scheduler_app/app/theme/app_theme.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Function()? onTap;

  const AppButton({ Key? key, required this.label, required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 110,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primary,
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}