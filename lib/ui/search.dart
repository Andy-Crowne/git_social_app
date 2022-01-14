import 'package:flutter/material.dart';

import '../data/repositories/api_service.dart';
import 'package:git_social_app/data/model/user_model.dart';

class SearchUser extends SearchDelegate {
  FetchUserList _userList = FetchUserList();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Items>>(
        future: _userList.getUserList(query: query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Items>? data = snapshot.data;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Color(0xCCCCCCCC),
                            offset: Offset(2, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                        shape: BoxShape.rectangle,
                      ),
                      child: ListTile(
                        title: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  child: Center(
                                    child: CircleAvatar(
                                      maxRadius: 30,
                                      minRadius: 20,
                                      backgroundColor: Colors.grey,
                                      backgroundImage:
                                          '${data?[index].avatarUrl}'.isNotEmpty
                                              ? NetworkImage(
                                                  '${data?[index].avatarUrl}')
                                              : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${data?[index].login}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '${data?[index].url}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ]),
                            ),
                            Column(
                              children: [
                                Text(
                                  '${data?[index].countFollowers}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.chevron_right_outlined,
                                  color: Color(0xFF111111),
                                  size: 24,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search Users'),
    );
  }
}
