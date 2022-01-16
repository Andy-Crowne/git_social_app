import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:git_social_app/data/model/user_model.dart';
import 'package:git_social_app/data/model/top_repos_model.dart';
import 'package:git_social_app/data/model/repository_model.dart';

class FetchUserList {
  Future<List<Items>> getUserList({String? query}) async {
    List<Items> results = [];
    var url = Uri.parse('https://api.github.com/search/users?q=$query');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        for (var u in jsonResponse['items']) {
          var count = await getFollowersCount(u['login']);
          Items item = Items(
              login: u["login"],
              id: u["id"],
              avatarUrl: u["avatar_url"],
              url: u["url"],
              htmlUrl: u["htmlUrl"],
              followersUrl: u["followers_url"],
              countFollowers: count);
          results.add(item);
        }
      } else {
        print("fetch error");
      }
    } catch (e) {
      print(e);
    }
    return results;
  }
}

getFollowersCount(String arguments) async {
  int count = 0;
  var url = Uri.parse('https://api.github.com/users/$arguments/followers');
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      count = jsonResponse.length;
    } else {
      print("fetch error2");
    }
  } catch (e) {
    print(e);
  }
  return count;
}

class FetchTopRepositoriesList {
  Future<List<Example>> getTopRepositoriesList() async {
    List<Example> results = [];
    var url = Uri.parse(
        'https://api.github.com/search/repositories?q=stars:%3E150000&sort=stars');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        for (var u in jsonResponse['items']) {
          var star_count = u['stargazers_count'].toString();
          Example item = Example(
              id: u['id'],
              name: u['name'],
              fullName : u['full_name'],
              htmlUrl: u['html_url'],
              description: u['description'],
              stargazersCount: star_count.substring(0,3),
              language: u['language'],
              forksCount: u['forks_count']
          );
          results.add(item);
        }
      } else {
        print("fetch error");
      }
    } catch (e) {
      print(e);
    }
    return results;
  }
}

class FetchAllUserRepositoriesList {
  Future<List<Repo>> getUserRepositoriesList({String? query}) async {
    List<Repo> results = [];
    var url = Uri.parse(
        'https://api.github.com/users/$query/repos');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse =
        convert.jsonDecode(response.body) as List<dynamic>;
        for (var u in jsonResponse) {
          DateTime stringToDate = DateTime.parse(u['updated_at']);
          Repo repo = Repo(
              id : u['id'],
              name : u['name'],
              fullName : u['full_name'],
              htmlUrl : u['html_url'],
              description : u['description'],
              url : u['url'],
              updatedAt : stringToDate,
              stargazersCount : u['stargazers_count'],
              language : u['language'],
              forksCount : u['forks_count'],
              defaultBranch : u['default_branch'],
          );
          results.add(repo);
        }
      } else {
        print("fetch error");
      }
    } catch (e) {
      print(e);
    }
    return results;
  }
}
