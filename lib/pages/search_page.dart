import 'package:auto_route/auto_route.dart';
import 'package:demo/bloc/all.dart';
import 'package:demo/config.dart';
import 'package:demo/models/all.dart';
import 'package:demo/router/app_router.dart';
import 'package:demo/widgets/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:styled_widget/styled_widget.dart';

part 'search_page_category_ranking.dart';
part 'search_page_history.dart';

class SearchPage extends StatelessWidget {
  final String query;
  const SearchPage({@pathParam required this.query, super.key});

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.read<SearchBloc>();
    searchBloc.add(SearchEventAddQuery(query));
    searchBloc.add(SearchEventLoadHistory());
    searchBloc.add(const SearchEventLoadSuggestions('mobile'));
    final screenWidth = MediaQuery.of(context).size.width;
    final width = screenWidth - 32;
    // 构建 body 页面，此函数一般用来设置整体的布局
    page({required Widget child}) => Styled.widget(child: child)
        .padding(
            vertical: listVerticalPadding, horizontal: screenHorizontalPadding)
        .safeArea()
        .scrollable();
    // 构建搜索历史模块
    history({
      required List<String> historyList,
      required bool isExpanded,
    }) =>
        SearchHistoryWidget(
          title: AppLocalizations.of(context)!.search_history,
          tags: historyList,
          isExpanded: isExpanded,
          tagColor: Colors.grey[200]!,
          textColor: Colors.grey,
          onToggleExpand: () {
            searchBloc.add(SearchEventToggleHistoryExpand());
          },
          onClearHistory: () {
            searchBloc.add(SearchEventClearHistory());
          },
          onTapTag: (value) {
            searchBloc.add(SearchEventAddQuery(value));
            searchBloc.add(SearchEventAddHistory());
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
            searchBloc.add(SearchEventAddQuery(value ?? query));
            return;
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                searchBloc.add(SearchEventAddHistory());
                final value = searchBloc.state.query ?? query;
                context.router.replace(Result(query: value));
              },
              child: Text(AppLocalizations.of(context)!.btn_search,
                  style: const TextStyle(color: Colors.black87))),
        ],
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, searchState) {
          Widget? historyWidget, categoryRankingWidget;
          if (searchState.historyStatus == SearchStatus.success) {
            final historyList = searchState.history;
            final isExpanded = searchState.isHistoryExpanded;
            historyWidget = history(
              historyList: historyList,
              isExpanded: isExpanded,
            );
          }

          if (searchState.suggestionsStatus == SearchStatus.success) {
            final pageBlocks = searchState.pageBlocks;

            final CategoryRankingPageBlock categoryRankingPageBlock =
                pageBlocks.firstWhere(
                        (el) => el.type == PageBlockType.categoryRanking)
                    as CategoryRankingPageBlock;
            categoryRankingWidget =
                CategoryRankingWidget(pageBlock: categoryRankingPageBlock);
          }

          if (historyWidget != null && categoryRankingWidget != null) {
            return [
              historyWidget,
              categoryRankingWidget,
            ].toColumn().parent(page);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
