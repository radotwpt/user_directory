import 'package:flutter/material.dart';
import '../models/user.dart';
import '../widgets/animations.dart';

class DetailScreen extends StatelessWidget {
  final User user;

  const DetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initials = user.name.isNotEmpty
        ? user.name.split(' ').map((e) => e.isEmpty ? '' : e[0]).join()
        : '?';

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: SingleChildScrollView(
        child: FadeInAnimation(
          duration: const Duration(milliseconds: 500),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Avatar
                ScaleInAnimation(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.elasticOut,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    child: Text(
                      initials.isEmpty ? '?' : initials,
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // User name
                SlideInAnimation(
                  duration: const Duration(milliseconds: 600),
                  direction: SlideDirection.up,
                  child: Text(
                    user.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                const SizedBox(height: 32),

                // Details card
                SlideInAnimation(
                  duration: const Duration(milliseconds: 700),
                  direction: SlideDirection.up,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        children: [
                          // Name
                          ListTile(
                            leading: Icon(
                              Icons.person,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(
                              'Name',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                            subtitle: Text(
                              user.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: Theme.of(context).dividerColor,
                          ),

                          // Email
                          ListTile(
                            leading: Icon(
                              Icons.email,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(
                              'Email',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                            subtitle: Text(
                              user.email,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: Theme.of(context).dividerColor,
                          ),

                          // Phone
                          ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(
                              'Phone',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                            subtitle: Text(
                              user.phone.isEmpty ? 'N/A' : user.phone,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Back button
                SlideInAnimation(
                  duration: const Duration(milliseconds: 800),
                  direction: SlideDirection.up,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Go Back'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}