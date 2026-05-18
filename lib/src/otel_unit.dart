// Licensed under the Dartastic Pro Software License Agreement.
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:dartastic_opentelemetry_api/dartastic_opentelemetry_api.dart';

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
    span.setStringAttribute('rpc.system', 'unit');
    span.setStringAttribute('rpc.method', operation);
    final r = await invoke();
    final res = r.result;
    if (res != null) {
      if (res.environment != null) {
        span.setStringAttribute('unit.environment', res.environment!);
      }
      if (res.orgId != null) {
        span.setStringAttribute('unit.org.id', res.orgId!);
      }
      if (res.surface != null) {
        span.setStringAttribute('unit.surface', res.surface!);
      }
      if (res.resourceType != null) {
        span.setStringAttribute('unit.resource.type', res.resourceType!);
      }
      if (res.resourceId != null) {
        span.setStringAttribute('unit.resource.id', res.resourceId!);
      }
      if (res.customerId != null) {
        span.setStringAttribute('unit.customer.id', res.customerId!);
      }
      if (res.customerType != null) {
        span.setStringAttribute('unit.customer.type', res.customerType!);
      }
      if (res.customerStatus != null) {
        span.setStringAttribute('unit.customer.status', res.customerStatus!);
      }
      if (res.applicationStatus != null) {
        span.setStringAttribute(
            'unit.application.status', res.applicationStatus!);
      }
      if (res.applicationKind != null) {
        span.setStringAttribute('unit.application.kind', res.applicationKind!);
      }
      if (res.accountId != null) {
        span.setStringAttribute('unit.account.id', res.accountId!);
      }
      if (res.accountType != null) {
        span.setStringAttribute('unit.account.type', res.accountType!);
      }
      if (res.accountStatus != null) {
        span.setStringAttribute('unit.account.status', res.accountStatus!);
      }
      if (res.cardId != null) {
        span.setStringAttribute('unit.card.id', res.cardId!);
      }
      if (res.cardStatus != null) {
        span.setStringAttribute('unit.card.status', res.cardStatus!);
      }
      if (res.cardKind != null) {
        span.setStringAttribute('unit.card.kind', res.cardKind!);
      }
      if (res.transactionId != null) {
        span.setStringAttribute('unit.transaction.id', res.transactionId!);
      }
      if (res.transactionDirection != null) {
        span.setStringAttribute(
            'unit.transaction.direction', res.transactionDirection!);
      }
      if (res.transactionStatus != null) {
        span.setStringAttribute(
            'unit.transaction.status', res.transactionStatus!);
      }
      if (res.paymentId != null) {
        span.setStringAttribute('unit.payment.id', res.paymentId!);
      }
      if (res.paymentKind != null) {
        span.setStringAttribute('unit.payment.kind', res.paymentKind!);
      }
      if (res.paymentStatus != null) {
        span.setStringAttribute('unit.payment.status', res.paymentStatus!);
      }
      if (res.amountMicros != null) {
        span.setIntAttribute('unit.amount.micros', res.amountMicros!);
      }
      if (res.currencyCode != null) {
        span.setStringAttribute('unit.currency', res.currencyCode!);
      }
      if (res.statusCode != null) {
        span.setIntAttribute('http.response.status_code', res.statusCode!);
      }
      if (res.errorCode != null) {
        span.setStringAttribute('unit.error.code', res.errorCode!);
      }
      final fail = res.errorCode != null ||
          (res.statusCode != null && res.statusCode! >= 400) ||
          res.applicationStatus == 'Denied' ||
          res.paymentStatus == 'Rejected';
      if (fail) {
        span.setStringAttribute(
            ErrorResource.errorType.key, res.errorCode ?? 'unit.error');
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
