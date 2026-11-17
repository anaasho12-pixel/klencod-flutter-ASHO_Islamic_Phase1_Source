import 'package:flutter/material.dart';
import '../../core/theme/asho_theme.dart';
import '../tasbeeh/tasbeeh_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const _sections = [
    'الرئيسية',
    'القرآن',
    'الأذكار',
    'المكتبة',
    'حسابي',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Icon(Icons.nightlight_round, color: AshoColors.gold),
              SizedBox(width: 9),
              Text('أشو', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'تغيير المظهر',
              onPressed: widget.onToggleTheme,
              icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
            children: [
              _WelcomeCard(),
              const SizedBox(height: 16),
              const _SectionTitle('رفيق يومك'),
              const SizedBox(height: 10),
              const _PrayerCard(),
              const SizedBox(height: 12),
              const _VerseCard(),
              const SizedBox(height: 12),
              const _DhikrCard(),
              const SizedBox(height: 18),
              const _SectionTitle('مساحتك الإيمانية'),
              const SizedBox(height: 10),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.45,
                children: [
                  _FeatureTile(
                    icon: Icons.menu_book_rounded,
                    title: 'القرآن الكريم',
                    subtitle: 'افتح المصحف',
                    onTap: () => _showComingSoon(context, 'القرآن الكريم'),
                  ),
                  _FeatureTile(
                    icon: Icons.headphones_rounded,
                    title: 'المكتبة الصوتية',
                    subtitle: 'تلاوات ومحاضرات',
                    onTap: () => _showComingSoon(context, 'المكتبة الصوتية'),
                  ),
                  _FeatureTile(
                    icon: Icons.explore_rounded,
                    title: 'القبلة',
                    subtitle: 'اتجاه القبلة',
                    onTap: () => _showComingSoon(context, 'القبلة'),
                  ),
                  _FeatureTile(
                    icon: Icons.library_books_rounded,
                    title: 'المكتبة الإسلامية',
                    subtitle: 'كتب وأحاديث',
                    onTap: () => _showComingSoon(context, 'المكتبة الإسلامية'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _FeatureTile(
                icon: Icons.fingerprint_rounded,
                title: 'المسبحة الإلكترونية',
                subtitle: 'ابدأ التسبيح واحفظ تقدمك',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const TasbeehScreen()),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() => _selectedIndex = index);
            if (index != 0) _showComingSoon(context, _sections[index]);
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'الرئيسية'),
            NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'القرآن'),
            NavigationDestination(icon: Icon(Icons.favorite_border), label: 'الأذكار'),
            NavigationDestination(icon: Icon(Icons.library_books_outlined), label: 'المكتبة'),
            NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'حسابي'),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$name – سيتم تفعيل القسم في المرحلة القادمة')),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          colors: [AshoColors.emeraldLight, AshoColors.emerald],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        border: Border.all(color: AshoColors.gold.withValues(alpha: .5)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('السلام عليك 🌙',
              style: TextStyle(color: AshoColors.cream, fontSize: 15)),
          SizedBox(height: 8),
          Text('أهلاً بك في أشو',
              style: TextStyle(
                color: AshoColors.gold,
                fontSize: 27,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 8),
          Text('نورٌ لقلبك، وذكرٌ لروحك',
              style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}

class _PrayerCard extends StatelessWidget {
  const _PrayerCard();

  @override
  Widget build(BuildContext context) => const _InfoCard(
        icon: Icons.mosque_rounded,
        title: 'مواقيت الصلاة',
        value: 'اضبط مدينتك لعرض المواقيت',
        note: 'لن نعرض موعداً غير محسوب أو غير موثوق',
      );
}

class _VerseCard extends StatelessWidget {
  const _VerseCard();

  @override
  Widget build(BuildContext context) => const _InfoCard(
        icon: Icons.auto_stories_rounded,
        title: 'آية اليوم',
        value: 'سيظهر هنا نص قرآني موثّق',
        note: 'لم تتم إضافة مصدر المصحف بعد',
      );
}

class _DhikrCard extends StatelessWidget {
  const _DhikrCard();

  @override
  Widget build(BuildContext context) => const _InfoCard(
        icon: Icons.spa_rounded,
        title: 'ذكر اليوم',
        value: 'ابدأ يومك بذكر الله',
        note: 'سيتم ربط النصوص بمصادرها المعتمدة',
      );
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.note,
  });

  final IconData icon;
  final String title;
  final String value;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AshoColors.gold.withValues(alpha: .15),
              child: Icon(icon, color: AshoColors.gold),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(value),
                  const SizedBox(height: 3),
                  Text(note,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).hintColor,
                          )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      );
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AshoColors.gold, size: 27),
              const SizedBox(height: 9),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
