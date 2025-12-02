import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  static const routeName = '/tips';

  final List<Map<String, dynamic>> _tips = const [
    {
      'title': 'Stay Hydrated',
      'description': 'Drink at least 8 glasses of water daily to maintain optimal health and energy levels.',
      'icon': Icons.water_drop,
      'color': AppTheme.accentColor,
    },
    {
      'title': 'Get Enough Sleep',
      'description': 'Aim for 7-9 hours of quality sleep each night to support physical and mental well-being.',
      'icon': Icons.bedtime,
      'color': AppTheme.primaryColor,
    },
    {
      'title': 'Regular Exercise',
      'description': 'Engage in at least 30 minutes of moderate physical activity most days of the week.',
      'icon': Icons.fitness_center,
      'color': AppTheme.successColor,
    },
    {
      'title': 'Balanced Nutrition',
      'description': 'Eat a variety of fruits, vegetables, whole grains, and lean proteins for optimal nutrition.',
      'icon': Icons.restaurant,
      'color': AppTheme.warningColor,
    },
    {
      'title': 'Mindfulness & Meditation',
      'description': 'Practice mindfulness or meditation for 10-15 minutes daily to reduce stress and improve focus.',
      'icon': Icons.self_improvement,
      'color': AppTheme.secondaryColor,
    },
    {
      'title': 'Social Connections',
      'description': 'Maintain meaningful relationships and social connections for emotional well-being.',
      'icon': Icons.people,
      'color': AppTheme.accentColor,
    },
    {
      'title': 'Limit Screen Time',
      'description': 'Take regular breaks from screens to reduce eye strain and improve sleep quality.',
      'icon': Icons.phone_android,
      'color': Colors.purple,
    },
    {
      'title': 'Regular Health Checkups',
      'description': 'Schedule regular health checkups and screenings to catch potential issues early.',
      'icon': Icons.medical_services,
      'color': AppTheme.errorColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.gradientDecoration,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Wellness Tips',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: _tips.length,
                    itemBuilder: (context, index) {
                      final tip = _tips[index];
                      return _TipCard(
                        title: tip['title'] as String,
                        description: tip['description'] as String,
                        icon: tip['icon'] as IconData,
                        color: tip['color'] as Color,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

