import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onStartConsultation;
  const HomeScreen({super.key, required this.onStartConsultation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.psychology, color: theme.primaryColor),
            const SizedBox(width: 8),
            Text(
              'TobaccoExpert',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified, size: 16, color: Colors.green),
                  SizedBox(width: 4),
                  Text(
                    'Sistem Pakar Berbasis Sains',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Diagnosa Cerdas Tanaman Tembakau Anda',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Optimalkan kualitas panen dengan analisis Forward Chaining yang presisi. Identifikasi penyakit, hama, dan defisiensi nutrisi secara instan.',
              style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onStartConsultation,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Mulai Konsultasi'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Pelajari Sistem'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Hero Image Placeholder
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: const DecorationImage(
                  image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuAHFu8-dmReqtc9frBQmPPZkVE0YglXxOs53FdG6XRKv4_P1KM9FUxtu6sSkJe-cYpZu3OvAgknl6jgwJ8a6F7zf6htv6O98xX9LtBXnFpsjymyZ69bIZu2NiGI66JNByLvlLf6vXS-OAWHH2cQ4nmsFpxhPpbV5kvFxHshjPSDWGTzC5Y4mdQkPvs1jpc86K1fuz39bvkgvzs4shCkGK2OZ_0qHA1MVrtVqdE8Kjk9I0i5xURff2xmPuoYEcciCyl68d9RzPUKZqY'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(Icons.monitor_heart, color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Real-time Analysis', style: TextStyle(fontSize: 12, color: Colors.grey)),
                              const Text('Precision Farming', style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Stats Section
            const Row(
              children: [
                Expanded(
                  child: StatCard(
                    icon: Icons.storage,
                    value: '50+',
                    label: 'Basis Pengetahuan',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    icon: Icons.track_changes,
                    value: '95%',
                    label: 'Akurasi Diagnosa',
                    isPrimary: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final bool isPrimary;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isPrimary ? Theme.of(context).primaryColor : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: isPrimary ? Colors.white : Theme.of(context).primaryColor, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isPrimary ? Colors.white : Colors.black,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: isPrimary ? Colors.white70 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
