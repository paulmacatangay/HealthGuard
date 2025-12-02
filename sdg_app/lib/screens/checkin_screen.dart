import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../services/health_service.dart';
import '../theme/app_theme.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  static const routeName = '/checkin';

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final HealthService _healthService = HealthService();
  String _selectedMood = 'happy';
  int _energyLevel = 5;
  int _waterGlasses = 0;
  int _sleepHours = 8;
  final _notesController = TextEditingController();
  bool _isLoading = false;
  bool _hasCheckedInToday = false;

  final Map<String, Map<String, dynamic>> _moods = {
    'happy': {'icon': Icons.sentiment_very_satisfied, 'color': Colors.green, 'label': 'Happy'},
    'good': {'icon': Icons.sentiment_satisfied, 'color': Colors.lightGreen, 'label': 'Good'},
    'neutral': {'icon': Icons.sentiment_neutral, 'color': Colors.grey, 'label': 'Neutral'},
    'sad': {'icon': Icons.sentiment_dissatisfied, 'color': Colors.orange, 'label': 'Sad'},
    'stressed': {'icon': Icons.sentiment_very_dissatisfied, 'color': Colors.red, 'label': 'Stressed'},
  };

  @override
  void initState() {
    super.initState();
    _loadTodayCheckIn();
  }

  Future<void> _loadTodayCheckIn() async {
    final checkIn = await _healthService.getTodayCheckIn();
    if (checkIn != null && mounted) {
      setState(() {
        _selectedMood = checkIn['mood'] ?? 'happy';
        _energyLevel = checkIn['energyLevel'] ?? 5;
        _waterGlasses = checkIn['waterGlasses'] ?? 0;
        _sleepHours = checkIn['sleepHours'] ?? 8;
        _notesController.text = checkIn['notes'] ?? '';
        _hasCheckedInToday = true;
      });
    }
  }

  Future<void> _saveCheckIn() async {
    setState(() => _isLoading = true);

    try {
      await _healthService.saveDailyCheckIn(
        mood: _selectedMood,
        energyLevel: _energyLevel,
        waterGlasses: _waterGlasses,
        sleepHours: _sleepHours,
        notes: _notesController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_hasCheckedInToday ? 'Check-in updated!' : 'Check-in saved!'),
            backgroundColor: AppTheme.successColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        setState(() => _hasCheckedInToday = true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: AppTheme.errorColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

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
                  'Daily Check-In',
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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMoodSection(),
                        const SizedBox(height: 32),
                        _buildEnergySection(),
                        const SizedBox(height: 32),
                        _buildWaterSection(),
                        const SizedBox(height: 32),
                        _buildSleepSection(),
                        const SizedBox(height: 32),
                        _buildNotesSection(),
                        const SizedBox(height: 32),
                        _buildSaveButton(),
                      ],
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

  Widget _buildMoodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How are you feeling today?',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _moods.entries.map((entry) {
            final isSelected = _selectedMood == entry.key;
            return GestureDetector(
              onTap: () => setState(() => _selectedMood = entry.key),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? entry.value['color'].withOpacity(0.2)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? entry.value['color'] : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      entry.value['icon'],
                      color: entry.value['color'],
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      entry.value['label'],
                      style: TextStyle(
                        color: isSelected ? entry.value['color'] : Colors.black87,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildEnergySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Energy Level',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              '$_energyLevel/10',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Slider(
          value: _energyLevel.toDouble(),
          min: 1,
          max: 10,
          divisions: 9,
          activeColor: AppTheme.primaryColor,
          onChanged: (value) => setState(() => _energyLevel = value.toInt()),
        ),
      ],
    );
  }

  Widget _buildWaterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Water Intake (Glasses)',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: _waterGlasses > 0
                  ? () => setState(() => _waterGlasses--)
                  : null,
              iconSize: 32,
              color: AppTheme.primaryColor,
            ),
            Expanded(
              child: Center(
                child: Text(
                  '$_waterGlasses',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () => setState(() => _waterGlasses++),
              iconSize: 32,
              color: AppTheme.primaryColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSleepSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sleep Hours',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              '$_sleepHours hours',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Slider(
          value: _sleepHours.toDouble(),
          min: 0,
          max: 12,
          divisions: 24,
          activeColor: AppTheme.primaryColor,
          onChanged: (value) => setState(() => _sleepHours = value.toInt()),
        ),
      ],
    );
  }

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes (Optional)',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _notesController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'How was your day? Any thoughts?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _saveCheckIn,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                _hasCheckedInToday ? 'Update Check-In' : 'Save Check-In',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}

