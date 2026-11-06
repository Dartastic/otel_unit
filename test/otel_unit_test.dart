// Licensed under the Apache License, Version 2.0
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:dartastic_opentelemetry/testing.dart';
import 'package:otel_unit/otel_unit.dart';
import 'package:test/test.dart';

void main() {
  late TestHarness harness;
  late InMemorySpanExporter spans;

  setUpAll(() async {
    harness = await maybeInitializeOtelForTest(
      serviceName: 'otel_unit-test',
    );
    spans = harness.spans;
  });

  setUp(() => harness.clear());

  Map<String, Object> attrsOf(Span s) =>
      {for (final a in s.attributes.toList()) a.key: a.value};

  test('accounts.create records type + status', () async {
    await tracedUnit<String>(
      operation: 'accounts.create',
      invoke: () async => const UnitCallResult(
        value: 'ok',
        result: UnitResult(
          customerType: 'individual',
          accountType: 'depositAccount',
          accountStatus: 'Open',
        ),
      ),
    );
    final a = attrsOf(spans.findSpanByName('unit accounts.create')!);
    expect(a['unit.account.type'], 'depositAccount');
    expect(a['unit.account.status'], 'Open');
  });

  test('application Denied sets span error', () async {
    await tracedUnit<String>(
      operation: 'applications.create',
      invoke: () async => const UnitCallResult(
        value: 'ok',
        result: UnitResult(
          applicationKind: 'individualApplication',
          applicationStatus: 'Denied',
        ),
      ),
    );
    expect(
      spans.findSpanByName('unit applications.create')!.status,
      SpanStatusCode.Error,
    );
  });

  test('payment Rejected sets span error', () async {
    await tracedUnit<String>(
      operation: 'payments.create',
      invoke: () async => const UnitCallResult(
        value: 'ok',
        result: UnitResult(
          paymentKind: 'achPayment',
          paymentStatus: 'Rejected',
          amountMicros: 100000000,
          currencyCode: 'USD',
        ),
      ),
    );
    expect(
      spans.findSpanByName('unit payments.create')!.status,
      SpanStatusCode.Error,
    );
  });

  test('suppression skips spans', () async {
    await runWithoutUnitInstrumentationAsync(() async {
      await tracedUnit<String>(
        operation: 'accounts.list',
        invoke: () async => const UnitCallResult(value: 'v'),
      );
    });
    expect(spans.findSpansStartingWith('unit '), isEmpty);
  });
}
