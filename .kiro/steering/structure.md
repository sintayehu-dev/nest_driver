# Project Structure

## Overview
The project follows **Clean Architecture** with a **feature-first** approach, organizing code by business domains rather than technical layers.

## Root Structure
```
lib/
├── core/           # Shared infrastructure and utilities
├── features/       # Business features (bounded contexts)
├── app_widget.dart # Main app widget
├── bootstrap.dart  # App initialization
└── main*.dart     # Environment-specific entry points
```

## Core Module (`lib/core/`)
Shared infrastructure used across all features:

```
core/
├── application/    # App-level BLoCs and state
├── config/         # Environment and app configuration
├── constants/      # App-wide constants and environment variables
├── di/            # Dependency injection setup
├── errors/        # Error handling utilities
├── handlers/      # HTTP service, network exceptions, interceptors
├── navigation/    # Navigation service
├── presentation/  # Shared UI components and shell pages
├── router/        # Go router configuration
├── services/      # Cross-cutting services (file picker, image picker, etc.)
├── theme/         # App theme and colors
├── utils/         # Utilities and helpers
├── validation_pipe/ # Input validation
├── value_failures/ # Domain validation failures
└── value_object/  # Value objects and common interfaces
```

## Features Module (`lib/features/`)
Business features organized by domain:

```
features/
├── auth/          # Authentication domain
│   ├── application/   # BLoCs and use cases
│   ├── domain/       # Entities, repositories, value objects
│   ├── infrastructure/ # Data sources, repositories implementation
│   └── presentation/ # UI pages and widgets
└── driver/        # Driver operations domain
    ├── earnings/     # Earnings tracking
    ├── food/         # Food delivery features
    ├── home/         # Driver dashboard
    ├── message/      # Messaging system
    ├── profile/      # Profile management
    ├── registration/ # Driver registration
    └── trip_history/ # Trip tracking and history
```

## Feature Architecture Pattern
Each feature follows Clean Architecture layers:

```
feature/
├── application/    # BLoCs, events, states (presentation layer)
├── domain/         # Entities, repositories interfaces, value objects
├── infrastructure/ # Repository implementations, data sources
└── presentation/   # UI pages, widgets, screens
```

## Key Conventions

### File Naming
- Use snake_case for file names
- Suffix files with their type: `_bloc.dart`, `_state.dart`, `_event.dart`, `_page.dart`
- Repository interfaces in domain, implementations in infrastructure

### Folder Organization
- **Feature-first**: Group by business capability, not technical layer
- **Layer separation**: Clear boundaries between presentation, application, domain, infrastructure
- **Shared core**: Common utilities and services in `core/`

### Dependencies Flow
- **Presentation** → **Application** → **Domain** ← **Infrastructure**
- Domain layer has no dependencies on other layers
- Infrastructure depends on domain interfaces
- Use dependency injection to wire implementations

### State Management
- One BLoC per feature/screen
- Events and states defined using freezed unions
- BLoCs registered in dependency injection container

### Value Objects
- Domain validation encapsulated in value objects
- Failures defined using freezed unions in `value_failures/`
- Common validation logic in `validation_pipe/`