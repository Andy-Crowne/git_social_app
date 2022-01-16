import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:git_social_app/data/repositories/api_service.dart';
import 'package:git_social_app/ui/search_screen.dart';
import 'package:git_social_app/data/model/top_repos_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FetchTopRepositoriesList _reposList = FetchTopRepositoriesList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GitHub social'),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchUser());
              },
              icon: const Icon(Icons.search_sharp),
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(5),
          child: FutureBuilder<List<Example>>(
              future: _reposList.getTopRepositoriesList(),
              builder: (context, snapshot) {
                var data = snapshot.data;
                return ListView.builder(
                    itemCount: data?.length,
                    itemBuilder: (context, index) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: ListTile(
                            title: Row(
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.collections_bookmark,
                                            color: Color(0xFF4B39EF),
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${data?[index].fullName}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${data?[index].htmlUrl}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Color(0xFF4B39EF),
                                            size: 15,
                                          ),
                                          Text(
                                            '${data?[index].stargazersCount}K',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          FaIcon(
                                            FontAwesomeIcons
                                                .codeBranch,
                                            color: Color(0xFF4B39EF),
                                            size: 15,
                                          ),
                                          Text(
                                            '${data?[index].forksCount}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Row(
                                            children: [
                                              if(data?[index].language != null)...[
                                                const Icon(
                                                  Icons.language,
                                                  color: Color(0xFF4B39EF),
                                                  size: 15,
                                                ),
                                                Text(
                                                  '${data?[index].language}',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ]
                                            ],
                                          ),
                                        ],
                                      )
                                    ])
                              ],
                            ),
                            // trailing: Text('More Info'),
                          ),
                        ),
                      );
                    });
              }),
        ),
      ),
    );
  }
}
