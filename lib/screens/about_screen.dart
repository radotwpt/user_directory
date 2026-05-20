import 'package:flutter/material.dart';
import '../widgets/animations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang'),
      ),
      body: SingleChildScrollView(
        child: FadeInAnimation(
          duration: const Duration(milliseconds: 500),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 24),

                // Icon
                ScaleInAnimation(
                  duration: const Duration(milliseconds: 600),
                  child: Icon(
                    Icons.people,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 24),

                // App name
                SlideInAnimation(
                  duration: const Duration(milliseconds: 700),
                  direction: SlideDirection.up,
                  child: Text(
                    'Direktori Pengguna',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),

                // Version
                SlideInAnimation(
                  duration: const Duration(milliseconds: 750),
                  direction: SlideDirection.up,
                  child: Text(
                    'v1.0.0',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 32),

                // Description
                SlideInAnimation(
                  duration: const Duration(milliseconds: 800),
                  direction: SlideDirection.up,
                  child: Text(
                    'Aplikasi Direktori Pengguna yang dirancang untuk memberikan pengalaman terbaik dalam mengelola dan melihat data pengguna. Dengan antarmuka yang bersih dan mudah digunakan, aplikasi ini memungkinkan Anda untuk menjelajahi informasi pengguna dengan cepat dan efisien.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Features section
                SlideInAnimation(
                  duration: const Duration(milliseconds: 900),
                  direction: SlideDirection.up,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Fitur Utama',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _FeatureItem(
                            icon: Icons.cloud_download,
                            title: 'Integrasi API',
                            description: 'Mengambil data pengguna secara real-time dari API',
                          ),
                          const SizedBox(height: 12),
                          _FeatureItem(
                            icon: Icons.tune,
                            title: 'Manajemen Status',
                            description: 'Pengelolaan status yang efisien dengan Provider',
                          ),
                          const SizedBox(height: 12),
                          _FeatureItem(
                            icon: Icons.navigate_next,
                            title: 'Navigasi Mulus',
                            description: 'Transisi antar layar yang halus dan responsif',
                          ),
                          const SizedBox(height: 12),
                          _FeatureItem(
                            icon: Icons.design_services,
                            title: 'Desain Modern',
                            description: 'Antarmuka yang rapi dan intuitif dengan dukungan mode gelap',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Developer Section
                SlideInAnimation(
                  duration: const Duration(milliseconds: 1000),
                  direction: SlideDirection.up,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person_rounded,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Pengembang',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Radot WP Tambunan',
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'NIM: 411222006',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Teknik Informatika',
                                  style: Theme.of(context).textTheme.bodySmall,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'Universitas Dian Nusantara',
                                  style: Theme.of(context).textTheme.bodySmall,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Stack teknologi
                SlideInAnimation(
                  duration: const Duration(milliseconds: 1100),
                  direction: SlideDirection.up,
                  child: Text(
                    'Dibangun dengan Flutter & Provider',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
