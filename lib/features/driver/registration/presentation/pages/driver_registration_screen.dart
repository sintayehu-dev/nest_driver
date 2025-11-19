import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/router/route_name.dart';
import 'package:nest_driver/features/driver/registration/presentation/pages/widgets/pages/driver_profile_page.dart';
import 'package:nest_driver/features/driver/registration/presentation/pages/widgets/pages/vehicle_information_page.dart';
import 'package:nest_driver/features/driver/registration/presentation/pages/widgets/pages/mirrors_wipers_page.dart';
import 'package:nest_driver/features/driver/registration/presentation/pages/widgets/pages/exterior_photos_page.dart';
import 'package:nest_driver/features/driver/registration/presentation/pages/widgets/pages/interior_photos_page.dart';

class DriverRegistrationScreen extends StatefulWidget {
  const DriverRegistrationScreen({super.key});

  @override
  State<DriverRegistrationScreen> createState() =>
      _DriverRegistrationScreenState();
}

class _DriverRegistrationScreenState extends State<DriverRegistrationScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

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

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _onSubmit();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onSubmit() {
    // TODO: Implement submission logic
    // After successful registration, navigate to onboarding or home
    context.goNamed(RouteName.onboarding);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _DriverRegistrationPage(
                    data: _pages[index],
                    currentPage: _currentPage,
                    totalPages: _pages.length,
                    onBackPressed: _currentPage == 0
                        ? () => context.pop()
                        : _previousPage,
                    onNextPressed: _nextPage,
                  );
                },
              ),
            ),
          ],
        ),
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
  final VoidCallback onBackPressed;
  final VoidCallback onNextPressed;

  const _DriverRegistrationPage({
    required this.data,
    required this.currentPage,
    required this.totalPages,
    required this.onBackPressed,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return _buildPageContent(context, data.pageIndex);
  }

  Widget _buildPageContent(BuildContext context, int pageIndex) {
    switch (pageIndex) {
      case 0:
        return DriverProfilePage(
          currentPage: currentPage,
          totalPages: totalPages,
          onBackPressed: onBackPressed,
          onNextPressed: onNextPressed,
          title: data.title,
        );
      case 1:
        return VehicleInformationPage(
          currentPage: currentPage,
          totalPages: totalPages,
          onBackPressed: onBackPressed,
          onNextPressed: onNextPressed,
          title: data.title,
        );
      case 2:
        return MirrorsWipersPage(
          currentPage: currentPage,
          totalPages: totalPages,
          onBackPressed: onBackPressed,
          onNextPressed: onNextPressed,
          title: data.title,
        );
      case 3:
        return ExteriorPhotosPage(
          currentPage: currentPage,
          totalPages: totalPages,
          onBackPressed: onBackPressed,
          onNextPressed: onNextPressed,
          title: data.title,
        );
      case 4:
        return InteriorPhotosPage(
          currentPage: currentPage,
          totalPages: totalPages,
          onBackPressed: onBackPressed,
          onNextPressed: onNextPressed,
          title: data.title,
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
