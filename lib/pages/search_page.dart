import 'package:auto_route/auto_route.dart';
import 'package:demo/bloc/all.dart';
import 'package:demo/config.dart';
import 'package:demo/router/app_router.dart';
import 'package:demo/widgets/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_widget/styled_widget.dart';

part 'search_page_history.dart';
part 'search_page_suggestion.dart';

class SearchPage extends StatelessWidget implements AutoRouteWrapper {
  const SearchPage({required this.query, super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SearchBloc>().add(SearchEventAddQuery(query));
    context.read<SearchBloc>().add(SearchEventLoadHistory());
    final screenWidth = MediaQuery.of(context).size.width;
    final width = screenWidth - 32;
    page({required Widget child}) => Styled.widget(child: child)
        .padding(
            vertical: listVerticalPadding, horizontal: screenHorizontalPadding)
        .safeArea()
        .scrollable();
    history({required List<String> historyList}) => SearchHistoryWidget(
          title: '搜索历史',
          tags: historyList.map((el) => TagWidget(title: el)).toList(),
          isExpanded: false,
          onToggleExpand: () {},
          onClearHistory: () {
            context.read<SearchBloc>().add(SearchEventClearHistory());
          },
        );

    final historyList =
        context.select<SearchBloc, List<String>>((bloc) => bloc.state.history);
    return Scaffold(
      appBar: AppBar(
        title: SearchBoxWidget(
          width: width,
          height: 32,
          hints: [query],
          right2IconData: null,
          onChanged: (value) {
            context.read<SearchBloc>().add(SearchEventAddQuery(value ?? query));
            return;
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                context.read<SearchBloc>().add(SearchEventAddHistory());
                final value = context.read<SearchBloc>().state.query ?? query;
                context.router.replace(Result(query: value));
              },
              child: const Text('搜索', style: TextStyle(color: Colors.white))),
        ],
      ),
      body: history(historyList: historyList).parent(page),
    );
  }

  final String query;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return this;
      },
    );
  }
}
