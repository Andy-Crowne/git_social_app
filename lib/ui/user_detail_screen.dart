import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:git_social_app/data/model/repository_model.dart';
import 'package:git_social_app/data/repositories/api_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UserDetail extends StatelessWidget {
  final FetchAllUserRepositoriesList _repositoriesListList =
      FetchAllUserRepositoriesList();

  //late final Items items;
  final userLogin;

  UserDetail({required this.userLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userLogin),
      ),
      body: FutureBuilder<List<Repo>>(
          future:
              _repositoriesListList.getUserRepositoriesList(query: userLogin),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Repo>? data = snapshot.data;
            return Hero(
              tag: 'hero1',
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                    itemCount: data?.length,
                    itemBuilder: (context, index) {
                      DateTime? _dateToDateTime = data?[index].updatedAt;
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 8, 0),
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: Colors.white,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12, 4, 12, 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Flexible(
                                                  child: Padding(
                                                    padding: EdgeInsetsDirectional
                                                        .fromSTEB(0, 4, 0, 0),
                                                    child: Text(
                                                      '${data?[index].fullName}',
                                                      style: TextStyle(
                                                        color: Color(0xFF619DD2),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85,
                                            height: 1,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFDBE2E7),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12, 4, 12, 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                    child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    if (data?[index]
                                                            .description !=
                                                        null) ...[
                                                      Expanded(
                                                        child: Text(
                                                          '${data?[index].description}',
                                                          style:
                                                              GoogleFonts.roboto(
                                                            color:
                                                                Color(0xFF8B97A2),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ] else ...[
                                                      Expanded(
                                                        child: Text(
                                                          'The user has not added a description to their project or repository',
                                                          style:
                                                              GoogleFonts.roboto(
                                                            color:
                                                                Color(0xFFDB3786),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.normal,
                                                          ),
                                                        ),
                                                      ),
                                                    ]
                                                  ],
                                                )),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(12, 4, 12, 3),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 4),
                                                      child: Icon(
                                                        Icons.schedule,
                                                        color: Color(0xFF4B39EF),
                                                        size: 16,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  4, 0, 0, 0),
                                                      child: Text(
                                                        'Last update: ',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF4B39EF),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      _dateToDateTime == null
                                                          ? 'We no have date'
                                                          : DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .format(
                                                                  _dateToDateTime),
                                                      style: TextStyle(
                                                        color: Color(0xFF4B39EF),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(12, 1, 12, 3),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  3, 0, 0, 4),
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .codeBranch,
                                                        color: Color(0xFF4B39EF),
                                                        size: 16,
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    4, 0, 0, 0),
                                                        child: Row(
                                                          children: [
                                                            if (data?[index]
                                                                    .defaultBranch !=
                                                                null) ...[
                                                              Text(
                                                                'Default Branch: ${data?[index].defaultBranch}',
                                                                style: TextStyle(
                                                                  color: Color(
                                                                      0xFF4B39EF),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ] else ...[
                                                              const Text(
                                                                  'Users do not have a branch'),
                                                            ]
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsetsDirectional
                                                        .fromSTEB(12, 1, 12, 3),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0, 0, 0, 4),
                                                          child: Icon(
                                                            Icons.device_hub,
                                                            color:
                                                                Color(0xFF4B39EF),
                                                            size: 16,
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(4,
                                                                        0, 0, 0),
                                                            child: Row(
                                                              children: [
                                                                if (data?[index]
                                                                        .forksCount !=
                                                                    null) ...[
                                                                  Text(
                                                                    'Forks: ${data?[index].forksCount}',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xFF4B39EF),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ] else ...[
                                                                  const Text(
                                                                      'Users do not have a forks'),
                                                                ]
                                                              ],
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional
                                                        .fromSTEB(12, 1, 12, 3),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0, 0, 0, 4),
                                                          child: Icon(
                                                            Icons.star,
                                                            color:
                                                                Color(0xFF4B39EF),
                                                            size: 16,
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(4,
                                                                        0, 0, 0),
                                                            child: Row(
                                                              children: [
                                                                if (data?[index]
                                                                        .stargazersCount !=
                                                                    null) ...[
                                                                  Text(
                                                                    'Stars: ${data?[index].stargazersCount}',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xFF4B39EF),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ] else ...[
                                                                  const Text(
                                                                      'Users do not have a stars'),
                                                                ]
                                                              ],
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(12, 1, 12, 3),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    if (data?[index].language !=
                                                        null) ...[
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 4),
                                                        child: Icon(
                                                          Icons.language,
                                                          color:
                                                              Color(0xFF4B39EF),
                                                          size: 16,
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      4, 0, 0, 0),
                                                          child: Text(
                                                            'Language: ${data?[index].language}',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF4B39EF),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                            ),
                                                          )),
                                                    ]
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            );
          }),
    );
  }
}
