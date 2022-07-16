class Repository {
  final String name;
  final String ownerIconUrl;
  final String language;
  final int starCount;
  final int watcherCount;
  final int forkCount;
  final int issueCount;

  Repository({
    required this.name,
    required this.ownerIconUrl,
    required this.language,
    required this.starCount,
    required this.watcherCount,
    required this.forkCount,
    required this.issueCount,
  });

  factory Repository.fromJson(Map<String, dynamic> item) {
    return Repository(
        name: item['name'],
        ownerIconUrl: item['owner']['avatar_url'],
        language: item['language'] ?? '',
        starCount: item['stars_count'] ?? 0,
        watcherCount: item['watchers_count'] ?? 0,
        forkCount: item['forks_count'] ?? 0,
        issueCount: item['issues_count'] ?? 0,
    );
  }
}