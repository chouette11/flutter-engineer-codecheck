import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/models/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RepositoryDetailPage extends ConsumerWidget {
  const RepositoryDetailPage({
    Key? key,
    required this.repository,
  }) : super(key: key);
  final Repository repository;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Engineer CodeCheck")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(repository.ownerIconUrl),
            const SizedBox(height: 8),
            Text(
              repository.name,
              style: textTheme.titleLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(l10n!.repositoryLanguage(repository.language)),
                Column(
                  children: [
                    Text("${repository.starCount} stars"),
                    Text("${repository.watcherCount} watchers"),
                    Text("${repository.forkCount} forks"),
                    Text("${repository.issueCount} open issues"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
