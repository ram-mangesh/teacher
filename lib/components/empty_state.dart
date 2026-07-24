import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum EmptyStateType {
  noData,
  noNotifications,
  noAttendance,
  noPTM,
  noAssignments,
  noTopics,
  noTimetable,
  noPeriods,
}

class EmptyStateWidget extends StatelessWidget {
  final EmptyStateType type;
  final String? customMessage;

  const EmptyStateWidget({
    super.key,
    required this.type,
    this.customMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 160,
              height: 160,
              child: CustomPaint(
                painter: _EmptyIllustrationPainter(type),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              customMessage ?? _getMessage(),
              style: AppTextStyles.emptyStateTitle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _getMessage() {
    switch (type) {
      case EmptyStateType.noData:
        return 'No Data Available';
      case EmptyStateType.noNotifications:
        return 'There are no Notifications';
      case EmptyStateType.noAttendance:
        return 'No data Available';
      case EmptyStateType.noPTM:
        return 'No Data Found';
      case EmptyStateType.noAssignments:
        return 'No Assignment found';
      case EmptyStateType.noTopics:
        return 'No Topics Found';
      case EmptyStateType.noTimetable:
        return 'No Time Table Found';
      case EmptyStateType.noPeriods:
        return 'No Periods Found';
    }
  }
}

class _EmptyIllustrationPainter extends CustomPainter {
  final EmptyStateType type;
  _EmptyIllustrationPainter(this.type);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    switch (type) {
      case EmptyStateType.noNotifications:
        _paintBell(canvas, w, h);
        break;
      case EmptyStateType.noAttendance:
        _paintCalendar(canvas, w, h);
        break;
      case EmptyStateType.noAssignments:
        _paintNotebook(canvas, w, h);
        break;
      case EmptyStateType.noTopics:
        _paintChatBubble(canvas, w, h);
        break;
      case EmptyStateType.noTimetable:
        _paintClock(canvas, w, h);
        break;
      case EmptyStateType.noPeriods:
        _paintSchedule(canvas, w, h);
        break;
      case EmptyStateType.noPTM:
        _paintPeople(canvas, w, h);
        break;
      case EmptyStateType.noData:
      default:
        _paintInbox(canvas, w, h);
        break;
    }
  }

  void _paintBell(Canvas canvas, double w, double h) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Bell body
    paint.color = const Color(0xFFE8E8E8);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.5, h * 0.45), width: w * 0.45, height: h * 0.4), paint);

    // Bell top knob
    paint.color = const Color(0xFFD0D0D0);
    canvas.drawCircle(Offset(w * 0.5, h * 0.22), w * 0.06, paint);

    // Bell bottom rim
    paint.color = const Color(0xFFD0D0D0);
    canvas.drawRect(Rect.fromLTWH(w * 0.27, h * 0.58, w * 0.46, h * 0.06), paint);

    // Clapper
    paint.color = const Color(0xFFBDBDBD);
    canvas.drawCircle(Offset(w * 0.5, h * 0.68), w * 0.05, paint);

    // X mark (no notifications)
    final xPaint = Paint()
      ..color = const Color(0xFFE8342A)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.65, h * 0.28), Offset(w * 0.8, h * 0.43), xPaint);
    canvas.drawLine(Offset(w * 0.8, h * 0.28), Offset(w * 0.65, h * 0.43), xPaint);
  }

  void _paintCalendar(Canvas canvas, double w, double h) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Calendar body
    paint.color = Colors.white;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(w * 0.5, h * 0.5), width: w * 0.6, height: h * 0.5), const Radius.circular(12)),
      paint,
    );

    // Calendar header
    paint.color = const Color(0xFFE8342A);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.2, h * 0.22, w * 0.6, h * 0.12), const Radius.circular(12)),
      paint,
    );

    // Calendar rings
    final ringPaint = Paint()..color = const Color(0xFFBDBDBD)..strokeWidth = 2;
    canvas.drawLine(Offset(w * 0.38, h * 0.22), Offset(w * 0.38, h * 0.28), ringPaint);
    canvas.drawLine(Offset(w * 0.62, h * 0.22), Offset(w * 0.62, h * 0.28), ringPaint);

    // Calendar grid lines
    final gridPaint = Paint()..color = const Color(0xFFE0E0E0)..strokeWidth = 1;
    for (int i = 1; i <= 3; i++) {
      double y = h * 0.38 + (i * h * 0.06);
      canvas.drawLine(Offset(w * 0.25, y), Offset(w * 0.75, y), gridPaint);
    }

    // Sad face on calendar
    final facePaint = Paint()..color = const Color(0xFFBDBDBD)..style = PaintingStyle.stroke..strokeWidth = 2;
    canvas.drawCircle(Offset(w * 0.43, h * 0.5), w * 0.02, Paint()..color = const Color(0xFFBDBDBD));
    canvas.drawCircle(Offset(w * 0.57, h * 0.5), w * 0.02, Paint()..color = const Color(0xFFBDBDBD));
    // Sad mouth
    canvas.drawArc(Rect.fromCenter(center: Offset(w * 0.5, h * 0.55), width: w * 0.12, height: w * 0.08), 0.2, 2.7, false, facePaint);
  }

  void _paintNotebook(Canvas canvas, double w, double h) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Notebook body
    paint.color = Colors.white;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(w * 0.5, h * 0.5), width: w * 0.5, height: h * 0.6), const Radius.circular(8)),
      paint,
    );

    // Notebook cover
    paint.color = const Color(0xFFFFF3E0);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(w * 0.5, h * 0.5), width: w * 0.5, height: h * 0.6), const Radius.circular(8)),
      Paint()..style = PaintingStyle.stroke..color = const Color(0xFFE8342A)..strokeWidth = 2,
    );

    // Spiral binding
    paint.color = const Color(0xFFBDBDBD);
    for (int i = 0; i < 5; i++) {
      double y = h * 0.28 + (i * h * 0.1);
      canvas.drawCircle(Offset(w * 0.25, y), w * 0.025, paint);
    }

    // Pencil on top
    paint.color = const Color(0xFFFFF176);
    canvas.drawRect(Rect.fromLTWH(w * 0.55, h * 0.18, w * 0.06, h * 0.2), paint);
    paint.color = const Color(0xFFFF8A65);
    final pencilTip = Path()
      ..moveTo(w * 0.55, h * 0.18)
      ..lineTo(w * 0.58, h * 0.1)
      ..lineTo(w * 0.61, h * 0.18)
      ..close();
    canvas.drawPath(pencilTip, paint);

    // Lines on notebook
    final linePaint = Paint()..color = const Color(0xFFE0E0E0)..strokeWidth = 1;
    for (int i = 0; i < 4; i++) {
      double y = h * 0.4 + (i * h * 0.06);
      canvas.drawLine(Offset(w * 0.35, y), Offset(w * 0.65, y), linePaint);
    }
  }

  void _paintChatBubble(Canvas canvas, double w, double h) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Main bubble
    paint.color = const Color(0xFFE8E8E8);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(w * 0.5, h * 0.4), width: w * 0.5, height: h * 0.3), const Radius.circular(16)),
      paint,
    );

    // Bubble tail
    final path = Path()
      ..moveTo(w * 0.35, h * 0.52)
      ..lineTo(w * 0.3, h * 0.65)
      ..lineTo(w * 0.45, h * 0.52);
    canvas.drawPath(path, paint);

    // Dots inside bubble
    paint.color = const Color(0xFFBDBDBD);
    canvas.drawCircle(Offset(w * 0.4, h * 0.4), w * 0.03, paint);
    canvas.drawCircle(Offset(w * 0.5, h * 0.4), w * 0.03, paint);
    canvas.drawCircle(Offset(w * 0.6, h * 0.4), w * 0.03, paint);
  }

  void _paintClock(Canvas canvas, double w, double h) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Clock face
    paint.color = Colors.white;
    canvas.drawCircle(Offset(w * 0.5, h * 0.45), w * 0.3, paint);
    Paint()..color = const Color(0xFFE8342A)..style = PaintingStyle.stroke..strokeWidth = 2;
    canvas.drawCircle(Offset(w * 0.5, h * 0.45), w * 0.3, Paint()..color = const Color(0xFFE8342A)..style = PaintingStyle.stroke..strokeWidth = 3);

    // Clock hands
    final handPaint = Paint()..color = const Color(0xFF424242)..strokeWidth = 2.5..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.5, h * 0.45), Offset(w * 0.5, h * 0.25), handPaint);
    canvas.drawLine(Offset(w * 0.5, h * 0.45), Offset(w * 0.65, h * 0.45), handPaint);

    // Center dot
    canvas.drawCircle(Offset(w * 0.5, h * 0.45), 3, Paint()..color = const Color(0xFFE8342A));

    // Question mark
    final textPainter = TextPainter(text: const TextSpan(text: '?', style: TextStyle(color: Color(0xFFBDBDBD), fontSize: 28, fontWeight: FontWeight.w700)), textDirection: TextDirection.ltr);
    textPainter.layout();
    textPainter.paint(canvas, Offset(w * 0.7, h * 0.55));
  }

  void _paintSchedule(Canvas canvas, double w, double h) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Board
    paint.color = const Color(0xFFF5F5F5);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(w * 0.5, h * 0.45), width: w * 0.6, height: h * 0.45), const Radius.circular(8)),
      paint,
    );

    // Header
    paint.color = const Color(0xFFE8342A);
    canvas.drawRect(Rect.fromLTWH(w * 0.2, h * 0.22, w * 0.6, h * 0.06), paint);

    // Time slots
    final slotPaint = Paint()..color = const Color(0xFFE0E0E0);
    for (int i = 0; i < 3; i++) {
      double y = h * 0.32 + (i * h * 0.09);
      canvas.drawRect(Rect.fromLTWH(w * 0.25, y, w * 0.5, h * 0.06), slotPaint);
    }

    // Empty slots indicator
    paint.color = const Color(0xFFBDBDBD);
    canvas.drawCircle(Offset(w * 0.5, h * 0.65), w * 0.06, paint);
    final dashPaint = Paint()..color = Colors.white..strokeWidth = 2;
    canvas.drawLine(Offset(w * 0.46, h * 0.65), Offset(w * 0.54, h * 0.65), dashPaint);
  }

  void _paintPeople(Canvas canvas, double w, double h) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Person 1
    paint.color = const Color(0xFFE0E0E0);
    canvas.drawCircle(Offset(w * 0.35, h * 0.3), w * 0.08, paint);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(w * 0.35, h * 0.5), width: w * 0.18, height: h * 0.22), const Radius.circular(10)),
      paint,
    );

    // Person 2
    paint.color = const Color(0xFFBDBDBD);
    canvas.drawCircle(Offset(w * 0.65, h * 0.3), w * 0.08, paint);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(w * 0.65, h * 0.5), width: w * 0.18, height: h * 0.22), const Radius.circular(10)),
      paint,
    );

    // Dotted connection
    final dotPaint = Paint()..color = const Color(0xFFE8342A);
    canvas.drawCircle(Offset(w * 0.5, h * 0.42), 3, dotPaint);
    canvas.drawCircle(Offset(w * 0.53, h * 0.42), 3, dotPaint);
    canvas.drawCircle(Offset(w * 0.47, h * 0.42), 3, dotPaint);
  }

  void _paintInbox(Canvas canvas, double w, double h) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Inbox body
    paint.color = const Color(0xFFE8E8E8);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(w * 0.5, h * 0.5), width: w * 0.55, height: h * 0.35), const Radius.circular(10)),
      paint,
    );

    // Inbox flap
    final path = Path()
      ..moveTo(w * 0.225, h * 0.325)
      ..lineTo(w * 0.5, h * 0.48)
      ..lineTo(w * 0.775, h * 0.325)
      ..close();
    paint.color = const Color(0xFFD0D0D0);
    canvas.drawPath(path, paint);

    // Inbox front
    paint.color = const Color(0xFFBDBDBD);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(w * 0.5, h * 0.58), width: w * 0.55, height: h * 0.18), const Radius.circular(8)),
      paint,
    );

    // Question mark
    paint.color = Colors.white;
    final textPainter = TextPainter(text: const TextSpan(text: '?', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)), textDirection: TextDirection.ltr);
    textPainter.layout();
    textPainter.paint(canvas, Offset(w * 0.46, h * 0.52));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
