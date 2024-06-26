import 'package:injectable/injectable.dart';
import 'package:legal_referral_ui/src/core/network/network.dart';
import 'package:legal_referral_ui/src/features/feed/domain/entities/feed.dart';

@singleton
class FeedDatasource {
  FeedDatasource({
    required APIClient apiClient,
  }) : _apiClient = apiClient;

  final APIClient _apiClient;

  Future<List<Feed?>> fetchFeeds({
    required String userId,
  }) async {
    try {
      final response = await _apiClient.fetchFeeds(userId);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
