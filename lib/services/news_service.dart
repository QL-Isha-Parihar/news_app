import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/article.dart';

/// Thin wrapper around NewsAPI.org's free "Developer" tier.
///
/// Get a free API key at https://newsapi.org/register (takes ~1 minute,
/// no credit card required). Free tier limits: 100 requests/day,
/// top-headlines only work with `country`/`category`, and results
/// are capped to articles from the last month.
class NewsService {
  static const String _baseUrl = 'https://newsapi.org/v2';

  // TODO: Replace with your own free API key from https://newsapi.org
  static const String apiKey = 'fefeed98470b4f93990ab10ae5bcb86f';

  Future<List<Article>> getTopHeadlines({
    String country = 'us',
    String? category,
    int page = 1,
    int pageSize = 20,
  }) async {
    final params = {
      'country': country,
      'page': '$page',
      'pageSize': '$pageSize',
      'apiKey': apiKey,
    };
    if (category != null && category != 'general') {
      params['category'] = category;
    }

    final uri = Uri.parse('$_baseUrl/top-headlines').replace(queryParameters: params);

    return _fetchArticles(uri);
  }

  Future<List<Article>> searchNews(String query, {int page = 1}) async {
    final uri = Uri.parse('$_baseUrl/everything').replace(queryParameters: {
      'q': query,
      'page': '$page',
      'pageSize': '20',
      'sortBy': 'publishedAt',
      'language': 'en',
      'apiKey': apiKey,
    });

    return _fetchArticles(uri);
  }

  Future<List<Article>> _fetchArticles(Uri uri) async {
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final articlesJson = data['articles'] as List<dynamic>? ?? [];
      return articlesJson
          .map((json) => Article.fromJson(json as Map<String, dynamic>))
          .where((a) => a.title != '[Removed]')
          .toList();
    } else {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final message = data['message'] ?? 'Failed to load news';
      throw NewsApiException(message, response.statusCode);
    }
  }
}

class NewsApiException implements Exception {
  final String message;
  final int statusCode;
  NewsApiException(this.message, this.statusCode);

  @override
  String toString() => 'NewsApiException($statusCode): $message';
}
