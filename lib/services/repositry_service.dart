import 'package:mohamed_mounir_assesment/models/repositry_model.dart';
import 'package:mohamed_mounir_assesment/services/http_service.dart';

class RepositryService {
  final HttpService _httpService = HttpService();

  String? nextPageUrl;
  String? nextSearchPageUrl;

  Future<List<GithubRepository>> getAllRepositries() async {
    List<GithubRepository> repositries = [];
    await _httpService
        .fetchData(
            url: nextPageUrl ?? "https://api.github.com/repositories?since=0")
        .then((value) {
      for (var repositry in value.data) {
        repositries.add(GithubRepository.fromJson(repositry));
      }
      if (value.links['next'] != null) {
        nextPageUrl = value.links['next'];
      } else {
        repositries = [];
      }
    });
    return repositries;
  }

  Future<List<GithubRepository>> searchRepositries(
      {required String query}) async {
    List<GithubRepository> repositries = [];
    await _httpService
        .fetchData(
            url: nextSearchPageUrl ??
                "https://api.github.com/search/repositories?q=$query&page=1")
        .then((value) {
      for (var repositry in value.data['items']) {
        repositries.add(GithubRepository.fromJson(repositry));
      }
      if (value.links['next'] != null) {
        nextSearchPageUrl = value.links['next'];
      } else {
        repositries = [];
      }
    });
    return repositries;
  }

  clearSearch() {
    nextSearchPageUrl = null;
  }
}
