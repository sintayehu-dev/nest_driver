---
inclusion: always
---

# Product Overview

**Nest Driver** is a Flutter mobile application for driver management and operations within a ride-sharing/delivery ecosystem. The app is the driver-side companion that enables drivers to manage their work, track earnings, communicate with the platform, and complete trips.

## Product Context

This is a **driver-focused application** in a multi-sided marketplace. Key stakeholders include:
- **Drivers**: Primary users who use the app to accept trips, navigate, track earnings
- **Platform/Admin**: Backend system that assigns trips and manages driver operations
- **Riders/Customers**: End users (not directly in this app, but referenced in trip data)

## Core Features

### Authentication & Onboarding
- **OTP-based authentication**: Phone number verification without passwords
- **Role selection**: Support for different driver types or operational modes
- **Profile management**: Driver information, documents, and verification status
- **Registration flow**: Multi-step onboarding for new drivers

### Driver Operations
- **Home dashboard**: Central hub for active trips, status, and quick actions
- **Trip management**: Accept, navigate, and complete trips
- **Trip history**: Historical record of completed trips with details
- **Earnings tracking**: Real-time and historical earnings data
- **Messaging system**: Communication channel with platform/support

### Real-time Features
- **Location tracking**: Background location updates during active trips
- **WebSocket communication**: Real-time trip updates and notifications
- **Live status updates**: Driver availability and trip status synchronization

## Key User Flows

### Primary Flows
1. **Driver Authentication**: Phone number → OTP verification → Dashboard
2. **Trip Lifecycle**: Trip notification → Accept → Navigate → Complete → Earnings update
3. **Earnings Review**: View daily/weekly/monthly earnings, transaction history
4. **Profile Updates**: Update personal info, documents, vehicle details

### Supporting Flows
- Registration and document verification for new drivers
- Message center for platform communications
- Trip history review and details
- Status management (online/offline/busy)

## Business Rules

### Driver States
- Drivers can be online (available for trips) or offline
- Active trip state prevents new trip assignments
- Location tracking required when online or during active trips

### Trip Management
- Trips are assigned by the platform (not driver-initiated)
- Drivers can accept or decline trip requests
- Trip completion triggers earnings calculation
- Trip history maintained for reporting and disputes

### Earnings
- Earnings calculated per trip based on platform rules
- Real-time earnings updates after trip completion
- Historical earnings aggregated by time periods

## Technical Considerations

### Multi-Environment Support
- **Development**: Testing and development with dev backend
- **Staging**: Pre-production testing with staging backend
- **Production**: Live environment with production backend

### Platform Support
- Primary targets: **iOS and Android** (mobile-first)
- Secondary targets: Web, Windows, macOS, Linux (for testing/admin use)

### Offline Capabilities
- App should handle intermittent connectivity gracefully
- Critical data cached locally (trip details, earnings)
- Queue location updates when offline, sync when online

## Domain Language

Use these terms consistently when working with the codebase:
- **Driver**: The user of this application
- **Trip**: A ride or delivery assignment from pickup to dropoff
- **Earnings**: Money earned by driver from completed trips
- **Registration**: Driver onboarding and verification process
- **Profile**: Driver account information and settings
- **Status**: Driver availability state (online/offline/busy)
- **Location**: GPS coordinates tracked during trips