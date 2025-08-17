import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../core/utils/styles.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({
    super.key,
    required this.title,
    required this.isCheck,
    required this.icon,
  });

  final String title;
  final bool isCheck;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 300),
      child: Container(
        decoration: BoxDecoration(
          color: isCheck ? kPrimaryColor : kLightBlue,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4, // تقليل كثافة الظل
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ), // تقليل الحشو
          child: Row(
            mainAxisSize: MainAxisSize.min, // منع التمدد الأفقي
            children: [
              Icon(
                icon,
                size: 20, // تصغير حجم الأيقونة
                color: isCheck ? ksecondryColor : kPrimaryColor,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  style: Styles.subtitle16Bold.copyWith(
                    color: isCheck ? kWhite : kPrimaryColor,
                    fontSize: 14, // تصغير حجم الخط
                  ),
                  overflow: TextOverflow.ellipsis, // إضافة نقاط إذا طال النص
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
