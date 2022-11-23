import 'package:demo/config.dart';
import 'package:demo/models/all.dart';
import 'package:dio/dio.dart';

class PageBlockRepository {
  final Dio dio;

  PageBlockRepository(this.dio);

  Future<List<PageBlock>> getPageBlocks(
      [String platform = 'mobile', String target = 'home']) async {
    final response = await dio.getUri(Uri.https(lcApiBase, '/1.1/classes/Pages',
        {'where': '{"platform": "$platform", "target": "$target"}'}));
    if (response.statusCode == 200) {
      final json = response.data['results'] as List;
      // 区块排序
      json.sort((a, b) => a['sort'] - b['sort']);
      final pages = json.map((e) => PageBlock.fromJson(e)).toList();
      return pages;
    }
    throw Exception('Failed to load pages');
  }
}
