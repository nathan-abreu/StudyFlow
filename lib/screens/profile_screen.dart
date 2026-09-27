import 'package:flutter/material.dart';

import '../models/study_user.dart';
import '../widgets/content_area.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.user});

  final StudyUser user;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: ContentArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Seu perfil', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 24),
          const Center(
            child: CircleAvatar(
              radius: 44,
              child: Icon(Icons.person, size: 48),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text('Nome'),
                  subtitle: Text(user.name),
                ),
                ListTile(
                  leading: const Icon(Icons.mail_outline),
                  title: const Text('E-mail'),
                  subtitle: Text(user.email),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Nesta demonstração, os dados não são salvos ao sair ou recarregar.',
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (_) => false,
            ),
            icon: const Icon(Icons.logout),
            label: const Text('Sair'),
          ),
        ],
      ),
    ),
  );
}
