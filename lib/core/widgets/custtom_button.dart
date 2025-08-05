import 'package:flutter/material.dart';
import 'package:uber/core/utils/styles.dart';

class CusttomButton extends StatelessWidget {
  const CusttomButton({
    super.key,
    required this.title,
    required this.color,
    required this.titleColor,
    required this.isborder,
    this.function,
  });
  final String title;
  final Color color;
  final Color titleColor;
  final bool isborder;
  final void Function()? function;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      ),
      onPressed: function,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: isborder ? Border.all(width: 0.5) : null,
          borderRadius: BorderRadius.circular(26),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 35),
          child: Center(
            child: Text(
              title,
              style: Styles.subtitle16Bold.copyWith(color: titleColor),
            ),
          ),
        ),
      ),
    );
  }
}
