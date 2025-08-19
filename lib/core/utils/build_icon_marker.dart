import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum DriverStatus { online, idle, busy }

enum VehicleKind { car, bike }

Future<BitmapDescriptor> buildVehicleMarker({
  required VehicleKind kind,
  required DriverStatus status,
  required double headingDeg, // 0..360
  double size = 92,
}) async {
  final bgColor = switch (status) {
    DriverStatus.online => const Color(0xFF2ECC71),
    DriverStatus.idle => const Color(0xFF3498DB),
    DriverStatus.busy => const Color(0xFFE67E22),
  };

  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final paint = Paint()..isAntiAlias = true;
  final center = Offset(size / 2, size / 2);
  final r = size / 2;

  // ظل خفيف
  paint
    ..color = Colors.black.withOpacity(0.18)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
  canvas.drawCircle(center.translate(0, 2), r * 0.92, paint);

  // دائرة الخلفية
  paint
    ..color = bgColor
    ..maskFilter = null;
  canvas.drawCircle(center, r * 0.92, paint);

  // حلقة بيضاء
  paint
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4
    ..color = Colors.white.withOpacity(0.85);
  canvas.drawCircle(center, r * 0.78, paint);

  // توجيه الرمز حسب الـ heading
  canvas.save();
  canvas.translate(center.dx, center.dy);
  canvas.rotate(headingDeg * 3.1415926535 / 180);

  // سهم اتجاه صغير (فوق)
  paint
    ..style = PaintingStyle.fill
    ..color = Colors.white.withOpacity(0.9);
  final arrow = Path()
    ..moveTo(0, -r * 0.78)
    ..lineTo(r * 0.10, -r * 0.60)
    ..lineTo(-r * 0.10, -r * 0.60)
    ..close();
  canvas.drawPath(arrow, paint);

  // رمز المركبة (car/bike) — بسيط وجذاب
  final iconColor = Colors.white;
  paint..color = iconColor;

  if (kind == VehicleKind.car) {
    final car = Path();
    // جسم السيارة مبسط
    car.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(0, 0), width: r * 1.1, height: r * 0.55),
        Radius.circular(r * 0.20),
      ),
    );
    canvas.drawPath(car, paint);

    // شبابيك
    final winPaint = Paint()..color = Colors.white.withOpacity(0.28);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(0, -r * 0.05),
          width: r * 0.7,
          height: r * 0.22,
        ),
        Radius.circular(r * 0.10),
      ),
      winPaint,
    );

    // عجلات
    final wheel = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(-r * 0.45, r * 0.22), r * 0.10, wheel);
    canvas.drawCircle(Offset(r * 0.45, r * 0.22), r * 0.10, wheel);
  } else {
    // bike
    final stroke = Paint()
      ..color = iconColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // عجلتين
    canvas.drawCircle(Offset(-r * 0.45, r * 0.20), r * 0.14, stroke);
    canvas.drawCircle(Offset(r * 0.45, r * 0.20), r * 0.14, stroke);

    // فريم مبسط
    final frame = Path()
      ..moveTo(-r * 0.45, r * 0.20)
      ..lineTo(0, 0)
      ..lineTo(r * 0.18, r * 0.20)
      ..moveTo(0, 0)
      ..lineTo(r * 0.10, -r * 0.18)
      ..moveTo(r * 0.10, -r * 0.18)
      ..lineTo(r * 0.40, -r * 0.18)
      ..moveTo(r * 0.18, r * 0.20)
      ..lineTo(r * 0.45, r * 0.20);
    canvas.drawPath(frame, stroke);

    // كرسي
    final seat = Paint()
      ..color = iconColor
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(-r * 0.05, -r * 0.10),
      Offset(r * 0.10, -r * 0.10),
      seat,
    );
  }

  canvas.restore();

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.toInt(), size.toInt());
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
}
