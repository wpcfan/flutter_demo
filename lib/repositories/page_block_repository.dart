import 'package:demo/models/all.dart';
import 'package:dio/dio.dart';

class PageBlockRepository {
  final String _url = 'localhost:3000';
  final Dio dio;

  PageBlockRepository(this.dio);

  Future<List<PageBlock>> getPageBlocks([String platform = 'mobile']) async {
    final response =
        await dio.getUri(Uri.http(_url, '/pages', {'platform': platform}));
    if (response.statusCode == 200) {
      final json = response.data as List;
      // 区块排序
      json.sort((a, b) => a['sort'] - b['sort']);
      final pages = json.map((e) => PageBlock.fromJson(e)).toList();
      return pages;
    }
    throw Exception('Failed to load pages');
  }
}
