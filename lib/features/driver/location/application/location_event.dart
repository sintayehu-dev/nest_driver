import 'package:flutter/widgets.dart';

abstract class LocationEvent {}

class LocationAvailabilityToggled extends LocationEvent {
  LocationAvailabilityToggled(this.isAvailable, this.context);
  final bool isAvailable;
  final BuildContext context;
}

class LocationStreamUpdated extends LocationEvent {
  LocationStreamUpdated(this.locationText);
  final String locationText;
}

class LocationStreamError extends LocationEvent {
  LocationStreamError(this.message);
  final String message;
}

