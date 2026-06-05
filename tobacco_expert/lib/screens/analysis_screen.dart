import 'package:flutter/material.dart';
import '../services/inference_engine.dart';
import 'result_screen.dart';

class AnalysisScreen extends StatefulWidget {
  final List<String> selectedSymptomIds;
  const AnalysisScreen({super.key, required this.selectedSymptomIds});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> with TickerProviderStateMixin {
  late AnimationController _rotateController;
  late AnimationController _pulseController;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _rotateController = AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 2), lowerBound: 0.9, upperBound: 1.0)..repeat(reverse: true);

    _startAnalysis();
  }

  void _startAnalysis() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) setState(() => _currentStep = 1);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _currentStep = 2);
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      final results = InferenceEngine.diagnose(widget.selectedSymptomIds);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            results: results,
            selectedSymptomIds: widget.selectedSymptomIds,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _rotateController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    RotationTransition(
                      turns: _rotateController,
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green.withValues(alpha: 0.2), style: BorderStyle.none),
                        ),
                        child: CustomPaint(painter: _DashedCirclePainter()),
                      ),
                    ),
                    ScaleTransition(
                      scale: _pulseController,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 20,
                              spreadRadius: 5,
                            )
                          ],
                        ),
                        child: const Icon(Icons.biotech, size: 80, color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              const Text(
                'Menganalisis Spesimen',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 12),
              Text(
                'Sistem sedang melakukan penelusuran maju (forward chaining) berdasarkan ${widget.selectedSymptomIds.length} gejala yang dipilih.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 48),
              _buildStep(0, 'Mencocokkan fakta', 'Validasi input data gejala lapangan.'),
              _buildStep(1, 'Menemukan aturan', 'Mengevaluasi basis aturan botani...'),
              _buildStep(2, 'Menarik kesimpulan', 'Menunggu hasil inferensi mesin.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(int step, String title, String desc) {
    bool isCompleted = _currentStep > step;
    bool isActive = _currentStep == step;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Opacity(
        opacity: isCompleted || isActive ? 1.0 : 0.5,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isActive ? Colors.green : Colors.transparent, width: 2),
              boxShadow: isActive ? [BoxShadow(color: Colors.green.withValues(alpha: 0.1), blurRadius: 10)] : null,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: isCompleted ? Colors.green : (isActive ? Colors.green : Colors.grey),
                child: isCompleted
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : (isActive ? const SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const SizedBox()),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.withValues(alpha: 0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5;
    const double dashSpace = 5;
    double startAngle = 0;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    while (startAngle < 2 * 3.14159) {
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, dashWidth / radius, false, paint);
      startAngle += (dashWidth + dashSpace) / radius;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
