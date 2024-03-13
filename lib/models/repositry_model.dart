class GithubRepository {
  final int id;
  final String nodeId;
  final String name;
  final String fullName;
  final bool private;
  final Owner owner;
  final String htmlUrl;
  final String? description;
  final bool fork;
  final String url;

  GithubRepository({
    required this.id,
    required this.nodeId,
    required this.name,
    required this.fullName,
    required this.private,
    required this.owner,
    required this.htmlUrl,
    this.description,
    required this.fork,
    required this.url,
  });

  factory GithubRepository.fromJson(Map<String, dynamic> json) =>
      GithubRepository(
        id: json['id'] as int,
        nodeId: json['node_id'] as String,
        name: json['name'] as String,
        fullName: json['full_name'] as String,
        private: json['private'] as bool,
        owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
        htmlUrl: json['html_url'] as String,
        description: json['description'] as String?,
        fork: json['fork'] as bool,
        url: json['url'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'node_id': nodeId,
        'name': name,
        'full_name': fullName,
        'private': private,
        'owner': owner.toJson(),
        'html_url': htmlUrl,
        'description': description,
        'fork': fork,
        'url': url,
      };
}

class Owner {
  final String login;
  final int id;
  final String nodeId;
  final String avatarUrl;
  final String url;
  final String htmlUrl;

  Owner({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.url,
    required this.htmlUrl,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        login: json['login'] as String,
        id: json['id'] as int,
        nodeId: json['node_id'] as String,
        avatarUrl: json['avatar_url'] as String,
        url: json['url'] as String,
        htmlUrl: json['html_url'] as String,
      );

  Map<String, dynamic> toJson() => {
        'login': login,
        'id': id,
        'node_id': nodeId,
        'avatar_url': avatarUrl,
        'url': url,
        'html_url': htmlUrl,
      };
}
