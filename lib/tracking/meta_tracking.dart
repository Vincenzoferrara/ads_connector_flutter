import 'package:flutter_meta_sdk/flutter_meta_sdk.dart';

/// Meta (Facebook) tracking wrapper using flutter_meta_sdk package
///
/// This class provides a simplified interface for logging events to Meta (Facebook) Analytics.
/// It wraps the official flutter_meta_sdk package.
class MetaTracking {
  static final _metaSdk = FlutterMetaSdk();

  /// Activate the Meta SDK app events
  static Future<void> activateApp() async {
    await _metaSdk.activateApp();
  }

  /// Log a custom event with optional parameters
  static Future<void> logEvent(String name, {Map<String, dynamic>? params}) async {
    await _metaSdk.logEvent(
      name: name,
      parameters: params,
    );
  }

  /// Log a purchase event
  static Future<void> logPurchase(double value, String currency, {Map<String, dynamic>? params}) async {
    await _metaSdk.logPurchase(
      amount: value,
      currency: currency,
      parameters: params,
    );
  }

  /// Log when user views content
  static Future<void> logViewContent({
    Map<String, dynamic>? content,
    String? id,
    String? type,
    String? currency,
    double? price,
  }) async {
    await _metaSdk.logViewContent(
      content: content,
      id: id,
      type: type,
      currency: currency,
      price: price,
    );
  }

  /// Log when user adds item to cart
  static Future<void> logAddToCart({
    Map<String, dynamic>? content,
    required String id,
    required String type,
    required String currency,
    required double price,
  }) async {
    await _metaSdk.logAddToCart(
      content: content,
      id: id,
      type: type,
      currency: currency,
      price: price,
    );
  }

  /// Log when user initiates checkout
  static Future<void> logInitiateCheckout({
    double? totalPrice,
    String? currency,
    String? contentType,
    String? contentId,
    int? numItems,
    bool paymentInfoAvailable = false,
  }) async {
    await _metaSdk.logInitiatedCheckout(
      totalPrice: totalPrice,
      currency: currency,
      contentType: contentType,
      contentId: contentId,
      numItems: numItems,
      paymentInfoAvailable: paymentInfoAvailable,
    );
  }

  /// Log a custom event (alias for logEvent)
  static Future<void> logCustom(String event, {Map<String, dynamic>? params}) async {
    await logEvent(event, params: params);
  }

  /// Set user data for tracking
  static Future<void> setUserData({
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    String? dateOfBirth,
    String? gender,
    String? city,
    String? state,
    String? zip,
    String? country,
  }) async {
    await _metaSdk.setUserData(
      email: email,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      dateOfBirth: dateOfBirth,
      gender: gender,
      city: city,
      state: state,
      zip: zip,
      country: country,
    );
  }

  /// Clear user data
  static Future<void> clearUserData() async {
    await _metaSdk.clearUserData();
  }

  /// Set user ID
  static Future<void> setUserID(String id) async {
    await _metaSdk.setUserID(id);
  }

  /// Clear user ID
  static Future<void> clearUserID() async {
    await _metaSdk.clearUserID();
  }

  /// Get anonymous ID
  static Future<String?> getAnonymousId() async {
    return await _metaSdk.getAnonymousId();
  }
}
