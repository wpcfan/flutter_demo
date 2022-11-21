import 'package:demo/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryRepository {
  final SharedPreferences sharedPreferences;

  HistoryRepository(this.sharedPreferences);

  Future<List<String>> getHistory() async {
    final history = sharedPreferences.getStringList('history') ?? [];
    return history;
  }

  Future<void> addHistory(String query) async {
    final history = await getHistory();
    List<String> newHistory = [];
    int pos = history.indexOf(query);
    if (pos == -1) {
      // 如果没有找到，就添加到最前面
      newHistory = [query, ...history];
    } else {
      // 如果已经存在，就把它移到最前面
      newHistory = [
        query,
        ...history.sublist(0, pos),
        ...history.sublist(pos + 1)
      ];
    }
    // 保留最近的 30 个搜索记录
    if (newHistory.length > maxHistoryLength) {
      newHistory.removeLast();
    }
    await sharedPreferences.setStringList('history', newHistory);
  }

  Future<void> clearHistory() async {
    await sharedPreferences.remove('history');
  }
}
