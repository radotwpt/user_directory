import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/skeleton_loader.dart';
import '../widgets/animations.dart';
import 'detail_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<UserProvider>().fetchUsers(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Directory'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.isLoading) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: SlideInAnimation(
                    duration: Duration(milliseconds: 300 + (index * 50)),
                    direction: SlideDirection.up,
                    child: const SkeletonCard(),
                  ),
                );
              },
            );
          }

          if (userProvider.errorMessage.isNotEmpty) {
            return FadeInAnimation(
              duration: const Duration(milliseconds: 400),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PulseAnimation(
                        child: Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Oops! Something went wrong',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        userProvider.errorMessage,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<UserProvider>().fetchUsers();
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (userProvider.users.isEmpty) {
            return FadeInAnimation(
              duration: const Duration(milliseconds: 400),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No users found',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: userProvider.users.length,
            itemBuilder: (context, index) {
              final user = userProvider.users[index];
              final initials = user.name.isNotEmpty
                  ? user.name.split(' ').map((e) => e.isEmpty ? '' : e[0]).join()
                  : '?';

              return SlideInAnimation(
                duration: Duration(milliseconds: 300 + (index * 50)),
                direction: SlideDirection.up,
                curve: Curves.easeOut,
                child: Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: ScaleInAnimation(
                      duration: Duration(milliseconds: 400 + (index * 50)),
                      curve: Curves.elasticOut,
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        child: Text(
                          initials.isEmpty ? '?' : initials,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    title: Text(
                      user.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        user.email,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(user: user),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}