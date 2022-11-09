import 'dart:convert';

import 'package:demo/models/all.dart';
import 'package:http/http.dart';

class PageBlockRepository {
  final String _url = 'localhost:3000';

  Future<List<PageBlock>> getPageBlocks([String platform = 'mobile']) async {
    final response =
        await get(Uri.http(_url, '/pages', {'platform': platform}));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final pages = json.map((e) => PageBlock.fromJson(e)).toList();
      return pages;
    }
    throw Exception('Failed to load pages');
  }
}
