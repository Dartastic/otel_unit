// Licensed under the Apache License, Version 2.0
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry_api/dartastic_opentelemetry_api.dart';

import 'otel_unit_suppression.dart';

class UnitResult {
  /// Creates a result.
  const UnitResult({
    this.environment,
    this.orgId,
    this.surface,
    this.resourceType,
    this.resourceId,
    this.customerId,
    this.customerType,
    this.customerStatus,
    this.applicationStatus,
    this.applicationKind,
    this.accountId,
    this.accountType,
    this.accountStatus,
    this.cardId,
    this.cardStatus,
    this.cardKind,
    this.transactionId,
    this.transactionDirection,
    this.transactionStatus,
    this.paymentId,
    this.paymentKind,
    this.paymentStatus,
    this.amountMicros,
    this.currencyCode,
    this.statusCode,
    this.errorCode,
    this.errorMessage,
  });

  final String? environment;
  final String? orgId;
  final String? surface;
  final String? resourceType;
  final String? resourceId;
  final String? customerId;
  final String? customerType;
  final String? customerStatus;
  final String? applicationStatus;
  final String? applicationKind;
  final String? accountId;
  final String? accountType;
  final String? accountStatus;
  final String? cardId;
  final String? cardStatus;
  final String? cardKind;
  final String? transactionId;
  final String? transactionDirection;
  final String? transactionStatus;
  final String? paymentId;
  final String? paymentKind;
  final String? paymentStatus;
  final int? amountMicros;
  final String? currencyCode;
  final int? statusCode;
  final String? errorCode;
  final String? errorMessage;
}

/// What a traced call returned: the value for the caller plus fields
/// recorded on the span.
class UnitCallResult<T> {
  /// Creates a call result.
  const UnitCallResult({required this.value, this.result});

  /// The value returned to the caller.
  final T value;
  final UnitResult? result;
}

Future<T> tracedUnit<T>({
  required String operation,
  required Future<UnitCallResult<T>> Function() invoke,
  APITracer? tracer,
}) async {
  if (unitInstrumentationSuppressed()) {
    final r = await invoke();
    return r.value;
  }
  final t = tracer ?? OTelAPI.tracerProvider().getTracer('otel_unit');
  final span = t.startSpan('unit $operation', kind: SpanKind.client);
  try {
    span.addAttributes(
        OTelAPI.attributes([OTelAPI.attributeString('rpc.system', 'unit')]));
    span.addAttributes(
        OTelAPI.attributes([OTelAPI.attributeString('rpc.method', operation)]));
    final r = await invoke();
    final res = r.result;
    if (res != null) {
      if (res.environment != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('unit.environment', res.environment!)]));
      }
      if (res.orgId != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('unit.org.id', res.orgId!)]));
      }
      if (res.surface != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('unit.surface', res.surface!)]));
      }
      if (res.resourceType != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('unit.resource.type', res.resourceType!)
        ]));
      }
      if (res.resourceId != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('unit.resource.id', res.resourceId!)]));
      }
      if (res.customerId != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('unit.customer.id', res.customerId!)]));
      }
      if (res.customerType != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('unit.customer.type', res.customerType!)
        ]));
      }
      if (res.customerStatus != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('unit.customer.status', res.customerStatus!)
        ]));
      }
      if (res.applicationStatus != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'unit.application.status', res.applicationStatus!)
        ]));
      }
      if (res.applicationKind != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('unit.application.kind', res.applicationKind!)
        ]));
      }
      if (res.accountId != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('unit.account.id', res.accountId!)]));
      }
      if (res.accountType != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('unit.account.type', res.accountType!)]));
      }
      if (res.accountStatus != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('unit.account.status', res.accountStatus!)
        ]));
      }
      if (res.cardId != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('unit.card.id', res.cardId!)]));
      }
      if (res.cardStatus != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('unit.card.status', res.cardStatus!)]));
      }
      if (res.cardKind != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('unit.card.kind', res.cardKind!)]));
      }
      if (res.transactionId != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('unit.transaction.id', res.transactionId!)
        ]));
      }
      if (res.transactionDirection != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'unit.transaction.direction', res.transactionDirection!)
        ]));
      }
      if (res.transactionStatus != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'unit.transaction.status', res.transactionStatus!)
        ]));
      }
      if (res.paymentId != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('unit.payment.id', res.paymentId!)]));
      }
      if (res.paymentKind != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('unit.payment.kind', res.paymentKind!)]));
      }
      if (res.paymentStatus != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('unit.payment.status', res.paymentStatus!)
        ]));
      }
      if (res.amountMicros != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeInt('unit.amount.micros', res.amountMicros!)]));
      }
      if (res.currencyCode != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('unit.currency', res.currencyCode!)]));
      }
      if (res.statusCode != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('http.response.status_code', res.statusCode!)
        ]));
      }
      if (res.errorCode != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('unit.error.code', res.errorCode!)]));
      }
      final fail = res.errorCode != null ||
          (res.statusCode != null && res.statusCode! >= 400) ||
          res.applicationStatus == 'Denied' ||
          res.paymentStatus == 'Rejected';
      if (fail) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              ErrorAttributes.errorType.key, res.errorCode ?? 'unit.error')
        ]));
        span.setStatus(SpanStatusCode.Error, res.errorMessage);
      }
    }
    return r.value;
  } catch (e, st) {
    span.recordException(e, stackTrace: st);
    span.setStatus(SpanStatusCode.Error, e.toString());
    rethrow;
  } finally {
    span.end();
  }
}
