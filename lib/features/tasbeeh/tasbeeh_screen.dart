import 'package:flutter/material.dart';
import '../../core/theme/asho_theme.dart';

class TasbeehScreen extends StatefulWidget {
  const TasbeehScreen({super.key});

  @override
  State<TasbeehScreen> createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  int _count = 0;
  String _phrase = 'سبحان الله';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('المسبحة الإلكترونية')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: _phrase,
                  items: const [
                    DropdownMenuItem(value: 'سبحان الله', child: Text('سبحان الله')),
                    DropdownMenuItem(value: 'الحمد لله', child: Text('الحمد لله')),
                    DropdownMenuItem(value: 'الله أكبر', child: Text('الله أكبر')),
                    DropdownMenuItem(value: 'أستغفر الله', child: Text('أستغفر الله')),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _phrase = value);
                  },
                ),
                const SizedBox(height: 24),
                Text(_phrase, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 30),
                InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => setState(() => _count++),
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AshoColors.emerald,
                      border: Border.all(color: AshoColors.gold, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: AshoColors.gold.withValues(alpha: .15),
                          blurRadius: 28,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '$_count',
                        style: const TextStyle(
                          color: AshoColors.gold,
                          fontSize: 58,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('اضغط للزيادة'),
                const SizedBox(height: 22),
                OutlinedButton.icon(
                  onPressed: () => setState(() => _count = 0),
                  icon: const Icon(Icons.refresh),
                  label: const Text('تصفير العداد'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
