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

class SearchPage extends StatelessWidget {
  final String query;
  const SearchPage({@pathParam required this.query, super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SearchBloc>();
    bloc.add(SearchEventAddQuery(query));
    bloc.add(SearchEventLoadHistory());
    final screenWidth = MediaQuery.of(context).size.width;
    final width = screenWidth - 32;
    page({required Widget child}) => Styled.widget(child: child)
        .padding(
            vertical: listVerticalPadding, horizontal: screenHorizontalPadding)
        .safeArea()
        .scrollable();
    history({required List<String> historyList, required bool isExpanded}) =>
        SearchHistoryWidget(
          title: '搜索历史',
          tags: historyList,
          isExpanded: isExpanded,
          tagColor: Colors.grey[200]!,
          textColor: Colors.grey,
          onToggleExpand: () {
            bloc.add(SearchEventToggleHistoryExpand());
          },
          onClearHistory: () {
            bloc.add(SearchEventClearHistory());
          },
          onTapTag: (value) {
            bloc.add(SearchEventAddQuery(value));
            bloc.add(SearchEventAddHistory());
            context.router.replace(Result(query: value));
          },
        );

    return Scaffold(
      appBar: AppBar(
        elevation: double.minPositive,
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white,
        title: SearchBoxWidget(
          width: width,
          height: 32,
          hints: [query],
          right2IconData: null,
          onChanged: (value) {
            bloc.add(SearchEventAddQuery(value ?? query));
            return;
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                bloc.add(SearchEventAddHistory());
                final value = bloc.state.query ?? query;
                context.router.replace(Result(query: value));
              },
              child: const Text('搜索', style: TextStyle(color: Colors.black87))),
        ],
      ),
      body: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
        final historyList = state.history;
        final isExpanded = state.isHistoryExpanded;
        return history(historyList: historyList, isExpanded: isExpanded)
            .parent(page);
      }),
    );
  }
}
