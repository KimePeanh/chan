import 'package:flutter/material.dart';
import 'package:lady_skin/src/features/search/bloc/index.dart';
import 'package:lady_skin/src/features/search/screens/widgets/search_result.dart';

late SearchBloc searchBloc;

class SearchPage extends SearchDelegate {
  final String auth;
  SearchPage({required this.auth});

  @override
  ThemeData appBarTheme(BuildContext context) {
    // ignore: unnecessary_null_comparison
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    // ignore: unnecessary_null_comparison
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.black),
      primaryColorBrightness: Brightness.dark,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];

    // throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.black,),
      onPressed: () {
        searchBloc.close();
        Navigator.pop(context);
      },
    );
    // throw UnimplementedError();
  }

  late String seletedResult;
  @override
  Widget buildResults(BuildContext context) {
    return SearchResult(query: query, auth: auth,);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchBloc = SearchBloc();
    return Container();
  }
}
