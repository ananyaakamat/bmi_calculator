import 'package:flutter/material.dart';

void main() => runApp(const BMICalculatorApp());

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2F6BFF),
        scaffoldBackgroundColor: Colors.transparent,
        fontFamily: 'Roboto',
      ),
      home: const BMIScreen(),
    );
  }
}

enum UnitSystem { metric, imperial }

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> with TickerProviderStateMixin {
  final TextEditingController _heightCtrl = TextEditingController();
  final TextEditingController _weightCtrl = TextEditingController();
  final FocusNode _heightFocus = FocusNode();
  final FocusNode _weightFocus = FocusNode();

  UnitSystem _unit = UnitSystem.metric;
  double? _bmi;
  String _category = '';
  Color _categoryColor = Colors.grey;

  late final AnimationController _animCtrl;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn);

    // Auto-focus height at start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _heightFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _heightFocus.dispose();
    _weightFocus.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  void _reset() {
    _heightCtrl.clear();
    _weightCtrl.clear();
    setState(() {
      _bmi = null;
      _category = '';
      _categoryColor = Colors.grey;
    });
    _animCtrl.reset();
    _heightFocus.requestFocus();
  }

  void _calculate() {
    final hTxt = _heightCtrl.text.trim();
    final wTxt = _weightCtrl.text.trim();
    final h = double.tryParse(hTxt);
    final w = double.tryParse(wTxt);

    if (h == null || w == null) {
      _snack('Please enter valid numbers for height and weight.');
      return;
    }

    if (h <= 0 || w <= 0) {
      _snack('Please enter positive numbers for height and weight.');
      return;
    }

    // Check height limits based on unit system
    if (_unit == UnitSystem.metric && h >= 275) {
      _snack('Please enter a valid height.');
      return;
    }
    if (_unit == UnitSystem.imperial && h >= 108) {
      // 275 cm = ~108 inches
      _snack('Please enter a valid height.');
      return;
    }

    // Check weight limits based on unit system
    if (_unit == UnitSystem.metric && w >= 650) {
      _snack('Please enter a valid weight.');
      return;
    }
    if (_unit == UnitSystem.imperial && w >= 1433) {
      // 650 kg = ~1433 lbs
      _snack('Please enter a valid weight.');
      return;
    }

    double bmi;
    if (_unit == UnitSystem.metric) {
      // height in cm -> meters
      bmi = w / ((h / 100) * (h / 100));
    } else {
      // imperial: inches & lbs
      bmi = (w * 703) / (h * h);
    }

    final rounded = double.parse(bmi.toStringAsFixed(1));
    final cat = _categoryFor(rounded);
    final col = _colorFor(rounded);

    setState(() {
      _bmi = rounded;
      _category = cat;
      _categoryColor = col;
    });
    _animCtrl.forward(from: 0);
  }

  String _categoryFor(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal weight';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  Color _colorFor(double bmi) {
    if (bmi < 18.5) return const Color(0xFFFFA000); // amber
    if (bmi < 25) return const Color(0xFF2E7D32); // green
    if (bmi < 30) return const Color(0xFFFFB300); // amber bright
    return const Color(0xFFD32F2F); // red
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _showInfo() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('What is BMI?'),
        content: const Text(
          'Body Mass Index (BMI) is a simple index of weight-for-height used '
          'to classify underweight, normal weight, overweight, and obesity in adults.\n\n'
          'Formula:\n'
          '• Metric: weight(kg) / [height(m)]²\n'
          '• Imperial: 703 × weight(lbs) / [height(in)]²\n\n'
          'Note: BMI is a screening tool and does not account for muscle mass, age, or distribution of fat.',
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Got it')),
        ],
      ),
    );
  }

  void _showRecommendations() {
    String title = '';
    List<String> recommendations = [];

    switch (_category) {
      case 'Underweight':
        title = 'Diet Recommendations for Underweight';
        recommendations = [
          '• Eat calorie-dense, nutrient-rich foods (nuts, seeds, avocados, whole milk, cheese).',
          '• Increase protein intake (lean meats, eggs, lentils, beans).',
          '• Include healthy carbs (whole grains, potatoes, rice, oats).',
          '• Add healthy fats (olive oil, peanut butter, coconut).',
          '• Frequent small meals + snacks.',
          '• Strength training + protein for lean muscle gain.',
        ];
        break;
      case 'Overweight':
        title = 'Diet Recommendations for Overweight';
        recommendations = [
          '• Focus on portion control, balanced meals.',
          '• High-protein, moderate-carb, high-fiber foods (lean meats, legumes, veggies, whole grains).',
          '• Avoid sugary drinks, refined carbs, and fried foods.',
          '• Increase fruits & vegetables.',
          '• Drink plenty of water before meals.',
          '• Moderate physical activity (30–45 mins daily).',
        ];
        break;
      case 'Obese':
        title = 'Diet Recommendations for Obese';
        recommendations = [
          '• Adopt calorie deficit diet under medical guidance.',
          '• Prioritize high-fiber & high-protein foods for satiety.',
          '• Cut refined sugars, processed foods, saturated fats.',
          '• Prefer steamed, grilled, or baked meals over fried.',
          '• Track calories & practice mindful eating.',
          '• Gradual, sustainable weight loss (not crash diets).',
          '• Regular physical activity + medical monitoring.',
        ];
        break;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: recommendations
                .map((rec) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        rec,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ))
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  bool get _hasInputValues {
    return _heightCtrl.text.trim().isNotEmpty ||
        _weightCtrl.text.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    // Responsive max width for large screens
    final maxW =
        MediaQuery.of(context).size.width > 520 ? 420.0 : double.infinity;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // dismiss keyboard
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3559FF), Color(0xFF7EA6FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('BMI Calculator'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                tooltip: 'What is BMI?',
                onPressed: _showInfo,
                icon: const Icon(Icons.info_outline),
              )
            ],
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxW),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _unitToggle(),
                    const SizedBox(height: 16),
                    _inputCard(
                      icon: Icons.height,
                      label: _unit == UnitSystem.metric
                          ? 'Height (cm)'
                          : 'Height (inches)',
                      controller: _heightCtrl,
                      focusNode: _heightFocus,
                      onSubmitted: (_) => _weightFocus.requestFocus(),
                    ),
                    const SizedBox(height: 12),
                    _inputCard(
                      icon: Icons.fitness_center,
                      label: _unit == UnitSystem.metric
                          ? 'Weight (kg)'
                          : 'Weight (lbs)',
                      controller: _weightCtrl,
                      focusNode: _weightFocus,
                      onSubmitted: (_) => _calculate(),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: _calculate,
                            icon: const Icon(Icons.calculate),
                            label: const Text('Calculate'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _hasInputValues ? _reset : null,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Reset'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _hasInputValues
                                  ? const Color(0xFFD32F2F)
                                  : Colors.grey,
                              side: BorderSide(
                                color: _hasInputValues
                                    ? const Color(0xFFD32F2F)
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (_bmi != null) _animatedResultCard(),
                    if (_bmi != null && _category != 'Normal weight')
                      const SizedBox(height: 12),
                    if (_bmi != null && _category != 'Normal weight')
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _showRecommendations,
                          icon: const Icon(Icons.restaurant_menu),
                          label: const Text('Recommendations'),
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _unitToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: ChoiceChip(
              label:
                  const Text('Metric (cm/kg)', style: TextStyle(fontSize: 12)),
              selected: _unit == UnitSystem.metric,
              onSelected: (v) {
                if (v) {
                  setState(() => _unit = UnitSystem.metric);
                  _reset();
                }
              },
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: ChoiceChip(
              label: const Text('Imperial (in/lbs)',
                  style: TextStyle(fontSize: 12)),
              selected: _unit == UnitSystem.imperial,
              onSelected: (v) {
                if (v) {
                  setState(() => _unit = UnitSystem.imperial);
                  _reset();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputCard({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    required Function(String) onSubmitted,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textInputAction: TextInputAction.next,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          icon: Icon(icon, color: const Color(0xFF2F6BFF)),
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _animatedResultCard() {
    return SlideTransition(
      position: _slideAnim,
      child: FadeTransition(
        opacity: _fadeAnim,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 16,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Your BMI',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '$_bmi',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _categoryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  _category,
                  style: TextStyle(
                    color: _categoryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _bmiScale(),
            ],
          ),
        ),
      ),
    );
  }

  // Mini visual scale to show where user falls
  Widget _bmiScale() {
    // thresholds: 18.5, 25, 30
    final double value = _bmi ?? 0;
    const double min = 12; // visual min
    const double max = 40; // visual max
    final double clamped = value.clamp(min, max);
    final double pct = (clamped - min) / (max - min); // 0..1

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Scale (Underweight → Obese)'),
        const SizedBox(height: 6),
        Stack(
          children: [
            Container(
              height: 12,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFA000), // under
                    Color(0xFF2E7D32), // normal
                    Color(0xFFFFB300), // over
                    Color(0xFFD32F2F), // obese
                  ],
                ),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            Positioned(
              left: pct *
                  (MediaQuery.of(context).size.width.clamp(0, 420) -
                      32 -
                      16), // subtract padding/margins for better alignment
              child: Container(
                width: 2,
                height: 18,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text('12', style: TextStyle(fontSize: 12))),
            Flexible(child: Text('18.5', style: TextStyle(fontSize: 12))),
            Flexible(child: Text('25', style: TextStyle(fontSize: 12))),
            Flexible(child: Text('30', style: TextStyle(fontSize: 12))),
            Flexible(child: Text('40', style: TextStyle(fontSize: 12))),
          ],
        ),
      ],
    );
  }
}
