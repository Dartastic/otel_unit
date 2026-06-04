// Licensed under the Dartastic Pro Software License Agreement.
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';

import 'otel_unit_suppression.dart';

class UnitResult {
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

class UnitCallResult<T> {
  const UnitCallResult({required this.value, this.result});
  final T value;
  final UnitResult? result;
}

Future<T> tracedUnit<T>({
  required String operation,
  required Future<UnitCallResult<T>> Function() invoke,
  Tracer? tracer,
}) async {
  if (unitInstrumentationSuppressed()) {
    final r = await invoke();
    return r.value;
  }
  final t = tracer ?? OTel.tracerProvider().getTracer('otel_unit');
  final span = t.startSpan('unit $operation', kind: SpanKind.client);
  try {
    span.addAttributes(
        OTel.attributes([OTel.attributeString('rpc.system', 'unit')]));
    span.addAttributes(
        OTel.attributes([OTel.attributeString('rpc.method', operation)]));
    final r = await invoke();
    final res = r.result;
    if (res != null) {
      if (res.environment != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('unit.environment', res.environment!)]));
      }
      if (res.orgId != null) {
        span.addAttributes(
            OTel.attributes([OTel.attributeString('unit.org.id', res.orgId!)]));
      }
      if (res.surface != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('unit.surface', res.surface!)]));
      }
      if (res.resourceType != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('unit.resource.type', res.resourceType!)]));
      }
      if (res.resourceId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('unit.resource.id', res.resourceId!)]));
      }
      if (res.customerId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('unit.customer.id', res.customerId!)]));
      }
      if (res.customerType != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('unit.customer.type', res.customerType!)]));
      }
      if (res.customerStatus != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('unit.customer.status', res.customerStatus!)
        ]));
      }
      if (res.applicationStatus != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              'unit.application.status', res.applicationStatus!)
        ]));
      }
      if (res.applicationKind != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('unit.application.kind', res.applicationKind!)
        ]));
      }
      if (res.accountId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('unit.account.id', res.accountId!)]));
      }
      if (res.accountType != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('unit.account.type', res.accountType!)]));
      }
      if (res.accountStatus != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('unit.account.status', res.accountStatus!)]));
      }
      if (res.cardId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('unit.card.id', res.cardId!)]));
      }
      if (res.cardStatus != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('unit.card.status', res.cardStatus!)]));
      }
      if (res.cardKind != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('unit.card.kind', res.cardKind!)]));
      }
      if (res.transactionId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('unit.transaction.id', res.transactionId!)]));
      }
      if (res.transactionDirection != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              'unit.transaction.direction', res.transactionDirection!)
        ]));
      }
      if (res.transactionStatus != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              'unit.transaction.status', res.transactionStatus!)
        ]));
      }
      if (res.paymentId != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('unit.payment.id', res.paymentId!)]));
      }
      if (res.paymentKind != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('unit.payment.kind', res.paymentKind!)]));
      }
      if (res.paymentStatus != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('unit.payment.status', res.paymentStatus!)]));
      }
      if (res.amountMicros != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeInt('unit.amount.micros', res.amountMicros!)]));
      }
      if (res.currencyCode != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('unit.currency', res.currencyCode!)]));
      }
      if (res.statusCode != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeInt('http.response.status_code', res.statusCode!)]));
      }
      if (res.errorCode != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('unit.error.code', res.errorCode!)]));
      }
      final fail = res.errorCode != null ||
          (res.statusCode != null && res.statusCode! >= 400) ||
          res.applicationStatus == 'Denied' ||
          res.paymentStatus == 'Rejected';
      if (fail) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              ErrorResource.errorType.key, res.errorCode ?? 'unit.error')
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
