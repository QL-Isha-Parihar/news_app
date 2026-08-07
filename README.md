# Daily News — Flutter News App

A simple, clean news reader built with Flutter, using the free tier of
[NewsAPI.org](https://newsapi.org).

## Features
- Top headlines by category (Top, Business, Tech, Science, Health, Sports, Entertainment)
- Keyword search across all news
- Pull-to-refresh
- Article detail view with "Read full article" (opens in browser)
- Cached network images, graceful loading/error states

## 1. Get a free API key
1. Go to https://newsapi.org/register
2. Sign up (free, no credit card) — you'll get an API key instantly.
3. Free tier limits: 100 requests/day, articles from the last month,
   `top-headlines` only works for local development (not production web/CORS
   without a proxy — fine for a mobile app).

## 2. Add your key
Open `lib/services/news_service.dart` and replace:

```dart
static const String apiKey = 'YOUR_NEWSAPI_KEY_HERE';
```

with your actual key.

## 3. Install & run

```bash
flutter pub get
flutter run
```

## Project structure
```
lib/
  main.dart                        # App entry point
  models/
    article.dart                   # Article data model
  services/
    news_service.dart              # NewsAPI.org HTTP client
  screens/
    home_screen.dart               # Category tabs + search + list
    article_detail_screen.dart     # Full article view
  widgets/
    article_card.dart              # Reusable list item
```

## Swapping in a different free API
The `NewsService` class isolates all networking — if you'd rather use
[GNews](https://gnews.io/) or [Currents API](https://currentsapi.services/)
(both also have free tiers), just rewrite the two methods in
`news_service.dart` to hit the new endpoint and keep mapping results into
the same `Article` model; nothing else in the app needs to change.

## Notes
- Uses Material 3.
- `url_launcher` opens the original article in the device browser (NewsAPI's
  free tier only gives a truncated article body, not full text).
- Images are cached via `cached_network_image`.
