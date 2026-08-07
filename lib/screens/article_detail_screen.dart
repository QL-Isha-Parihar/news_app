import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/article.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  Future<void> _openInBrowser(BuildContext context) async {
    final uri = Uri.tryParse(article.url);
    if (uri == null || !await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open article link')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: article.imageUrl != null ? 240 : 100,
            flexibleSpace: FlexibleSpaceBar(
              background: article.imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: article.imageUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(color: Colors.grey[300]),
                    )
                  : Container(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.3),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        article.sourceName,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600),
                      ),
                      if (article.author != null && article.author!.isNotEmpty)
                        Text('  •  ${article.author}', style: TextStyle(color: Colors.grey[600])),
                      // if (article.publishedAt != null)
                      Text(
                        '  •  ${DateFormat('MMM d, yyyy · h:mm a').format(article.publishedAt!)}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  if (article.description != null)
                    Text(
                      article.description!,
                      style:
                          const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w600, height: 1.4),
                    ),
                  const SizedBox(height: 12),
                  if (article.content != null)
                    Text(
                      // NewsAPI free tier truncates content; strip the
                      // "[+123 chars]" suffix for a cleaner look.
                      article.content!.replaceAll(RegExp(r'\[\+\d+ chars\]$'), ''),
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => _openInBrowser(context),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('Read full article'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
