// Licensed under the Apache License, Version 2.0
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:otel_unit/otel_unit.dart';

/// Traces Unit calls with OpenTelemetry.
///
/// `otel_unit` depends on the OpenTelemetry API only, so the application
/// initializes an SDK once at startup. Wrap each Unit call in
/// [tracedUnit]; the `invoke` callback makes the real call and reports what
/// came back, which is recorded on the span.
Future<void> main() async {
  await OTel.initialize(serviceName: 'unit-example');

  // Traces a Unit call.
  final unitId = await tracedUnit<String>(
    operation: 'create',
    invoke: () async {
      // Make the Unit call here, then report what it returned.
      const id = 'unit_8f3a2c';
      return const UnitCallResult(
          value: id,
          result: UnitResult(
              environment: 'example',
              orgId: 'org_8f3a2c',
              surface: 'example',
              resourceType: 'standard',
              resourceId: 'resource_8f3a2c',
              customerId: 'customer_8f3a2c',
              customerType: 'standard',
              customerStatus: 'succeeded',
              applicationStatus: 'succeeded',
              applicationKind: 'example',
              accountId: 'account_8f3a2c',
              accountType: 'standard',
              accountStatus: 'succeeded',
              cardId: 'card_8f3a2c',
              cardStatus: 'succeeded',
              cardKind: 'example',
              transactionId: 'transaction_8f3a2c',
              transactionDirection: 'example',
              transactionStatus: 'succeeded',
              paymentId: 'payment_8f3a2c',
              paymentKind: 'example',
              paymentStatus: 'succeeded',
              amountMicros: 1999,
              currencyCode: 'usd',
              statusCode: 201,
              errorCode: 'example',
              errorMessage: 'example'));
    },
  );
  OTelLog.info('tracedUnit create returned $unitId');

  // Calls that should not be traced, such as health checks, run inside
  // runWithoutUnitInstrumentationAsync.
  await runWithoutUnitInstrumentationAsync(
    () => tracedUnit<String>(
      operation: 'create',
      invoke: () async {
        const id = 'unit_8f3a2c';
        return const UnitCallResult(
            value: id,
            result: UnitResult(
                environment: 'example',
                orgId: 'org_8f3a2c',
                surface: 'example',
                resourceType: 'standard',
                resourceId: 'resource_8f3a2c',
                customerId: 'customer_8f3a2c',
                customerType: 'standard',
                customerStatus: 'succeeded',
                applicationStatus: 'succeeded',
                applicationKind: 'example',
                accountId: 'account_8f3a2c',
                accountType: 'standard',
                accountStatus: 'succeeded',
                cardId: 'card_8f3a2c',
                cardStatus: 'succeeded',
                cardKind: 'example',
                transactionId: 'transaction_8f3a2c',
                transactionDirection: 'example',
                transactionStatus: 'succeeded',
                paymentId: 'payment_8f3a2c',
                paymentKind: 'example',
                paymentStatus: 'succeeded',
                amountMicros: 1999,
                currencyCode: 'usd',
                statusCode: 201,
                errorCode: 'example',
                errorMessage: 'example'));
      },
    ),
  );

  await OTel.shutdown();
}
