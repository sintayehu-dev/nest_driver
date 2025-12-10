import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nest_driver/core/di/dependancy_manager.dart';
import 'package:nest_driver/features/driver/location/application/location_bloc.dart';
import 'package:nest_driver/features/driver/location/application/location_event.dart';
import 'package:nest_driver/features/driver/location/application/location_state.dart';
import 'widgets/location_header_card.dart';
import 'widgets/availability_card.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<LocationBloc>(),
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LocationHeaderCard(
                    currentLocation: 'Your current location',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: AvailabilityCard(
                      isAvailable: state.isAvailable,
                      onChanged: (val) {
                        dev.log('Availability toggled: $val');
                        context.read<LocationBloc>().add(
                              LocationAvailabilityToggled(val, context),
                            );
                      },
                    ),
                  ),
                  if (state.isLoading ||
                      state.locations.isNotEmpty ||
                      state.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          state.isLoading
                              ? 'Fetching location...'
                              : state.errorMessage ??
                                  'Latest: ${state.locations.isNotEmpty ? state.locations.last : 'N/A'}',
                          style: theme.textTheme.bodySmall?.copyWith(
                                color: state.errorMessage != null
                                    ? theme.colorScheme.error
                                    : theme.colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ),
                    ),
                  if (state.locations.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recent locations (max 10, resets after 10):',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 6),
                          ...state.locations
                              .asMap()
                              .entries
                              .map(
                                (e) => Text(
                                  '${e.key + 1}. ${e.value}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Driver Home (mock screen)',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

