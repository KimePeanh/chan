import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/category/bloc/index.dart';

import 'widgets/category_tile.dart';

//
class CategoryPageWrapper extends StatefulWidget {
  // final String text;

  // FirstPage({this.text}) : super();

  @override
  _CategoryPageWrapperState createState() => _CategoryPageWrapperState();
}

class _CategoryPageWrapperState extends State<CategoryPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return CategoryPage();
  }
}

class CategoryPage extends StatefulWidget {
  @override
  CategoryPageState createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        // backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.translate("category"),
          style: TextStyle(color: Colors.black),
          textScaleFactor: 1.2,
        ),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is FetchingCategory) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorFetchingCategory) {
            return Container();
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1,
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15),
                        itemCount: BlocProvider.of<CategoryBloc>(context)
                            .category
                            .length,
                        itemBuilder: (context, index) {
                          return categoryTile(
                              context: context,
                              category: BlocProvider.of<CategoryBloc>(context)
                                  .category[index]);
                        }),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
