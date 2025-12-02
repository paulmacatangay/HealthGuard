import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../services/health_service.dart';
import '../theme/app_theme.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  static const routeName = '/stats';

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final HealthService _healthService = HealthService();
  List<Map<String, dynamic>> _weeklyData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    setState(() => _isLoading = true);
    final data = await _healthService.getWeeklyStats();
    setState(() {
      _weeklyData = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().currentUser;

    return Scaffold(
      body: Container(
        decoration: AppTheme.gradientDecoration,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Your Statistics',
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
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : RefreshIndicator(
                          onRefresh: _loadStats,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildWelcomeCard(user?.fullName ?? 'User'),
                                const SizedBox(height: 24),
                                _buildSummaryCards(),
                                const SizedBox(height: 24),
                                _buildEnergyChart(),
                                const SizedBox(height: 24),
                                _buildWaterChart(),
                                const SizedBox(height: 24),
                                _buildSleepChart(),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(String name) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, $name!',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Here\'s your wellness overview for the past week',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    if (_weeklyData.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text('No data available yet. Start checking in daily!'),
        ),
      );
    }

    final avgEnergy = _weeklyData
            .map((e) => (e['energyLevel'] as num?)?.toDouble() ?? 0.0)
            .fold(0.0, (a, b) => a + b) /
        _weeklyData.length;
    final totalWater = _weeklyData
        .fold(0, (sum, e) => sum + ((e['waterGlasses'] as num?)?.toInt() ?? 0));
    final avgSleep = _weeklyData
            .map((e) => (e['sleepHours'] as num?)?.toDouble() ?? 0.0)
            .fold(0.0, (a, b) => a + b) /
        _weeklyData.length;

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'Avg Energy',
            value: avgEnergy.toStringAsFixed(1),
            unit: '/10',
            icon: Icons.battery_charging_full,
            color: AppTheme.successColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            title: 'Total Water',
            value: totalWater.toString(),
            unit: ' glasses',
            icon: Icons.water_drop,
            color: AppTheme.accentColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            title: 'Avg Sleep',
            value: avgSleep.toStringAsFixed(1),
            unit: ' hrs',
            icon: Icons.bedtime,
            color: AppTheme.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildEnergyChart() {
    if (_weeklyData.isEmpty) {
      return _buildEmptyChart('Energy Level Trend', 'No data available. Start checking in daily!');
    }

    final energyData = _weeklyData
        .map((e) => (e['energyLevel'] as num?)?.toDouble() ?? 0.0)
        .where((e) => e > 0)
        .toList();

    if (energyData.isEmpty) {
      return _buildEmptyChart('Energy Level Trend', 'No energy data available.');
    }

    return _buildChart(
      title: 'Energy Level Trend',
      data: energyData,
      color: AppTheme.successColor,
      maxY: 10,
    );
  }

  Widget _buildWaterChart() {
    if (_weeklyData.isEmpty) {
      return _buildEmptyChart('Water Intake Trend', 'No data available. Start checking in daily!');
    }

    final waterData = _weeklyData
        .map((e) => (e['waterGlasses'] as num?)?.toDouble() ?? 0.0)
        .toList();

    return _buildChart(
      title: 'Water Intake Trend',
      data: waterData,
      color: AppTheme.accentColor,
      maxY: 12,
    );
  }

  Widget _buildSleepChart() {
    if (_weeklyData.isEmpty) {
      return _buildEmptyChart('Sleep Hours Trend', 'No data available. Start checking in daily!');
    }

    final sleepData = _weeklyData
        .map((e) => (e['sleepHours'] as num?)?.toDouble() ?? 0.0)
        .where((e) => e > 0)
        .toList();

    if (sleepData.isEmpty) {
      return _buildEmptyChart('Sleep Hours Trend', 'No sleep data available.');
    }

    return _buildChart(
      title: 'Sleep Hours Trend',
      data: sleepData,
      color: AppTheme.primaryColor,
      maxY: 12,
    );
  }

  Widget _buildChart({
    required String title,
    required List<double> data,
    required Color color,
    required double maxY,
  }) {
    // Ensure we have at least 2 points for a line chart
    final chartData = data.length == 1 ? [data[0], data[0]] : data;
    
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                      chartData.length,
                      (index) => FlSpot(index.toDouble(), chartData[index]),
                    ),
                    isCurved: chartData.length > 2,
                    color: color,
                    barWidth: 3,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: color.withOpacity(0.1),
                    ),
                  ),
                ],
                minY: 0,
                maxY: maxY,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyChart(String title, String message) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: Center(
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              text: value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
              children: [
                TextSpan(
                  text: unit,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color.withOpacity(0.7),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

