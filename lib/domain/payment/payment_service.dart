import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:travel_smartapp/.env.dart';
import 'payment_exception.dart';

class PaymentService {
  final _apiUrl = 'https://api.stripe.com/v1/payment_intents';

  Map<String, dynamic>? _paymentIntentData;

  PaymentService._();
  static PaymentService instance = PaymentService._();

  static void init() {
    Stripe.publishableKey = Config.publishedKey;
  }

  Future<void> makePayment({
    required double amount,
    String currency = 'USD',
  }) async {
    _paymentIntentData = await _createPaymentIntent(amount, currency);

    await Stripe.instance
        .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: _paymentIntentData!['client_secret'],
            applePay: true,
            googlePay: true,
            testEnv: true,
            style: ThemeMode.dark,
            currencyCode: "LKR",
            merchantCountryCode: 'LK',
            merchantDisplayName: 'Travel Smart',
          ),
        )
        .then((value) {});

    await _displayPaymentSheet();
  }

  Future<void> _displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) {
        _paymentIntentData = null;
      }).catchError((e) => throw PaymentCancelException());
    } on StripeException catch (e) {
      log('Exception/DISPLAYPAYMENTSHEET==> $e');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> _createPaymentIntent(
      double amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(Uri.parse(_apiUrl), body: body, headers: {
        'Authorization': 'Bearer ${Config.secretKey}',
        'Content-Type': 'application/x-www-form-urlencoded'
      });

      return jsonDecode(response.body);
    } catch (err) {
      throw PaymentChargingUserException();
    }
  }

  String calculateAmount(double amount) {
    final a = amount * 100;
    return a.toInt().toString();
  }
}
