import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/di/dependancy_manager.dart';
import 'package:nest_driver/core/router/route_name.dart';
import 'package:nest_driver/core/presentation/widgets/app_helpers.dart';
import 'package:nest_driver/features/driver/registration/application/bloc/driver_registration_bloc.dart';
import 'package:nest_driver/features/driver/registration/presentation/widgets/driver_profile_page.dart';
import 'package:nest_driver/features/driver/registration/presentation/widgets/vehicle_information_page.dart';
import 'package:nest_driver/features/driver/registration/presentation/widgets/mirrors_wipers_page.dart';
import 'package:nest_driver/features/driver/registration/presentation/widgets/exterior_photos_page.dart';
import 'package:nest_driver/features/driver/registration/presentation/widgets/interior_photos_page.dart';

class DriverRegistrationScreen extends StatefulWidget {
  final String? phoneNumber;

  const DriverRegistrationScreen({
    super.key,
    this.phoneNumber,
  });

  @override
  State<DriverRegistrationScreen> createState() =>
      _DriverRegistrationScreenState();
}

class _DriverRegistrationScreenState extends State<DriverRegistrationScreen> {
  final PageController _pageController = PageController();

  final List<DriverRegistrationPageData> _pages = [
    DriverRegistrationPageData(
      title: 'Complete Your Driver Profile',
      description: '',
      pageIndex: 0,
    ),
    DriverRegistrationPageData(
      title: 'Enter your vehicle information',
      description: '',
      pageIndex: 1,
    ),
    DriverRegistrationPageData(
      title: 'Mirrors & Wipers',
      description: 'Capture photos of mirrors and windshield wipers',
      pageIndex: 2,
    ),
    DriverRegistrationPageData(
      title: 'Exterior Photos',
      description: 'Take photos of all four sides of your vehicle',
      pageIndex: 3,
    ),
    DriverRegistrationPageData(
      title: 'Interior Photos',
      description: 'Take photos of the dashboard and all seats',
      pageIndex: 4,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) {
        final bloc = getIt<DriverRegistrationBloc>();
        // Initialize with phone number
        bloc.add(DriverRegistrationEvent.initialized(
          phoneNumber: widget.phoneNumber,
        ));
        return bloc;
      },
      child: BlocConsumer<DriverRegistrationBloc, DriverRegistrationState>(
        listenWhen: (previous, current) =>
            previous.isLoading != current.isLoading ||
            (previous.isError != current.isError &&
                current.isError) || // Only when error becomes true
            previous.isSuccess != current.isSuccess ||
            previous.shouldNavigateNext != current.shouldNavigateNext ||
            previous.shouldNavigatePrevious != current.shouldNavigatePrevious ||
            previous.currentPage != current.currentPage,
        listener: (context, state) {
          // Handle navigation
          if (state.shouldNavigateNext == true) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            // Reset navigation flag
            context.read<DriverRegistrationBloc>().add(
                  DriverRegistrationEvent.pageChanged(state.currentPage),
                );
          }

          if (state.shouldNavigatePrevious == true) {
            _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            // Reset navigation flag
            context.read<DriverRegistrationBloc>().add(
                  DriverRegistrationEvent.pageChanged(state.currentPage),
                );
          }

          // Handle page changes from swipe
          if (state.currentPage != _pageController.page?.round()) {
            _pageController.jumpToPage(state.currentPage);
          }

          // Handle success/error
          if (!state.isLoading && state.isSuccess) {
            AppHelpers.showCheckFlash(
              context,
              'Registration successful! Welcome aboard.',
            );
            context.goNamed(RouteName.onboarding);
          } else if (!state.isLoading &&
              state.isError &&
              state.errorMessage.isNotEmpty) {
            AppHelpers.showErrorFlash(context, state.errorMessage);
            // Clear error state after showing toast to prevent re-showing
            context.read<DriverRegistrationBloc>().add(
                  const DriverRegistrationEvent.clearError(),
                );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            body: SafeArea(
              top: true,
              bottom: true,
              child: Column(
                children: [
                  // Page View
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      physics:
                          const NeverScrollableScrollPhysics(), // Disable swipe gesture
                      onPageChanged: (index) {
                        context.read<DriverRegistrationBloc>().add(
                              DriverRegistrationEvent.pageChanged(index),
                            );
                      },
                      itemCount: _pages.length,
                      itemBuilder: (context, index) {
                        return _DriverRegistrationPage(
                          data: _pages[index],
                          currentPage: state.currentPage,
                          totalPages: _pages.length,
                          title: _pages[index].title,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DriverRegistrationPageData {
  final String title;
  final String description;
  final int pageIndex;

  DriverRegistrationPageData({
    required this.title,
    required this.description,
    required this.pageIndex,
  });
}

class _DriverRegistrationPage extends StatelessWidget {
  final DriverRegistrationPageData data;
  final int currentPage;
  final int totalPages;
  final String title;

  const _DriverRegistrationPage({
    required this.data,
    required this.currentPage,
    required this.totalPages,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverRegistrationBloc, DriverRegistrationState>(
      builder: (context, state) {
        return _buildPageContent(context, data.pageIndex, state);
      },
    );
  }

  Widget _buildPageContent(
    BuildContext context,
    int pageIndex,
    DriverRegistrationState state,
  ) {
    switch (pageIndex) {
      case 0:
        return DriverProfilePage(
          currentPage: currentPage,
          totalPages: totalPages,
          title: title,
        );
      case 1:
        return VehicleInformationPage(
          currentPage: currentPage,
          totalPages: totalPages,
          title: title,
        );
      case 2:
        return MirrorsWipersPage(
          currentPage: currentPage,
          totalPages: totalPages,
          title: title,
        );
      case 3:
        return ExteriorPhotosPage(
          currentPage: currentPage,
          totalPages: totalPages,
          title: title,
        );
      case 4:
        return InteriorPhotosPage(
          currentPage: currentPage,
          totalPages: totalPages,
          title: title,
        );
      default:
        final theme = Theme.of(context);
        return Center(
          child: Text(
            'Page ${pageIndex + 1}',
            style: theme.textTheme.bodyLarge,
          ),
        );
    }
  }
}
