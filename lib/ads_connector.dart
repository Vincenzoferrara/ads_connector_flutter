/// Ads Connector - Enterprise Flutter Library
///
/// A comprehensive, secure, and modular library for integrating with major advertising platforms.
///
/// Features:
/// - Multi-platform OAuth (Meta, Google, TikTok)
/// - RAW API access to Meta Ads, Instagram, Google Ads, TikTok Ads
/// - Meta event tracking via official SDK
/// - Advanced rate limiting with circuit breaker
/// - Centralized logging with listeners
/// - Automatic scheduler for data refresh
/// - Secure token storage per provider
/// - Cross-platform support (Android, iOS, Desktop, Web)
///
/// Security principles:
/// - No client secrets in app
/// - OAuth via external browser (most secure)
/// - Separate token storage per provider
/// - Read-only APIs accessible via user access token
/// - No server-side conversion API or admin API exposure
library ads_connector;

// OAuth & Authentication
export 'oauth/oauth_manager.dart';
export 'oauth/token_storage.dart';

// Meta Ads API (RAW)
export 'meta/meta_client.dart';
export 'meta/meta_endpoints.dart';

// Instagram API (RAW)
export 'instagram/instagram_client.dart';
export 'instagram/instagram_endpoints.dart';

// Google Ads API (RAW)
export 'googleads/googleads_client.dart';
export 'googleads/googleads_endpoints.dart';

// TikTok Ads API (RAW)
export 'tiktokads/tiktokads_client.dart';
export 'tiktokads/tiktokads_endpoints.dart';

// Tracking
export 'tracking/meta_tracking.dart';

// Common utilities
export 'common/http_client.dart';
export 'common/logger.dart';
export 'common/error_callbacks.dart';
export 'common/rate_limit.dart';
export 'common/scheduler.dart';
