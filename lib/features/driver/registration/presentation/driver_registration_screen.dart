import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/di/dependancy_manager.dart';
import 'package:nest_driver/core/router/route_name.dart';
import 'package:nest_driver/core/utils/app_helpers.dart';
import 'package:nest_driver/features/driver/registration/application/bloc/driver_registration_bloc.dart';
import 'package:nest_driver/features/driver/registration/domain/entities/driver_registration_request.dart';
import 'package:nest_driver/features/driver/registration/presentation/models/driver_registration_form_data.dart';
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
  int _currentPage = 0;
  late final DriverRegistrationFormData _formData;

  @override
  void initState() {
    super.initState();
    _formData = DriverRegistrationFormData();
    // Set phone number from OTP login/registration
    if (widget.phoneNumber != null) {
      final trimmedPhone = widget.phoneNumber!.trim();
      if (trimmedPhone.isNotEmpty) {
        _formData.phoneNumber = trimmedPhone;
      }
    }
  }

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

  void _nextPage(BuildContext blocContext) {
    if (_currentPage < _pages.length - 1) {
      // Just navigate to next page - no API call, just collect data
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Final page - submit all collected data with single API call
      _onSubmit(blocContext);
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

  /// Submit all collected data from all 5 pages with a single API call
  /// This is only called on the final page (Interior Photos page)
  void _onSubmit(BuildContext blocContext) {
    // Validate form data
    final errors = _formData.validationErrors;
    if (errors.isNotEmpty) {
      AppHelpers.showErrorFlash(blocContext, errors.first);
      return;
    }

    // Build driver documents
    final driverDocuments = <DriverDocumentRequestData>[
      if (_formData.profileImage != null)
        DriverDocumentRequestData(
          docType: 'profile_picture',
          path: _formData.profileImage!.path,
        ),
      if (_formData.licenseImage != null)
        DriverDocumentRequestData(
          docType: 'driver_license',
          path: _formData.licenseImage!.path,
        ),
    ];

    // Build vehicle documents
    final vehicleDocuments = <VehicleDocumentRequestData>[
      // Mirrors & Wipers
      if (_formData.frontWiperPhoto != null)
        VehicleDocumentRequestData(
          docType: 'front_wiper',
          path: _formData.frontWiperPhoto!.path,
        ),
      if (_formData.rearWiperPhoto != null)
        VehicleDocumentRequestData(
          docType: 'rear_wiper',
          path: _formData.rearWiperPhoto!.path,
        ),
      if (_formData.sideMirror1Photo != null)
        VehicleDocumentRequestData(
          docType: 'side_mirror_1',
          path: _formData.sideMirror1Photo!.path,
        ),
      if (_formData.sideMirror2Photo != null)
        VehicleDocumentRequestData(
          docType: 'side_mirror_2',
          path: _formData.sideMirror2Photo!.path,
        ),
      if (_formData.rearViewMirrorPhoto != null)
        VehicleDocumentRequestData(
          docType: 'rear_view_mirror',
          path: _formData.rearViewMirrorPhoto!.path,
        ),
      // Exterior Photos
      if (_formData.frontPhoto != null)
        VehicleDocumentRequestData(
          docType: 'front_side',
          path: _formData.frontPhoto!.path,
        ),
      if (_formData.backPhoto != null)
        VehicleDocumentRequestData(
          docType: 'back_side',
          path: _formData.backPhoto!.path,
        ),
      if (_formData.leftPhoto != null)
        VehicleDocumentRequestData(
          docType: 'left_side',
          path: _formData.leftPhoto!.path,
        ),
      if (_formData.rightPhoto != null)
        VehicleDocumentRequestData(
          docType: 'right_side',
          path: _formData.rightPhoto!.path,
        ),
      // Interior Photos
      if (_formData.dashboardPhoto != null)
        VehicleDocumentRequestData(
          docType: 'dashboard',
          path: _formData.dashboardPhoto!.path,
        ),
      if (_formData.frontSeatsPhoto != null)
        VehicleDocumentRequestData(
          docType: 'front_seats',
          path: _formData.frontSeatsPhoto!.path,
        ),
      if (_formData.backSeatsPhoto != null)
        VehicleDocumentRequestData(
          docType: 'back_seats',
          path: _formData.backSeatsPhoto!.path,
        ),
      // Additional photos
      ..._formData.additionalPhotos.map(
        (photo) => VehicleDocumentRequestData(
          docType: 'other_seats',
          path: photo.path,
        ),
      ),
    ];

    final request = DriverRegistrationRequest(
      phoneNumber: _formData.phoneNumber,
      driver: DriverRequestData(
        fullName: _formData.fullName!,
        email: _formData.email!,
        finNumber: _formData.finNumber,
      ),
      vehicle: VehicleRequestData(
        carMake: _formData.carMake!,
        carModel: _formData.carModel!,
        yearOfManufacture: _formData.yearOfManufacture!,
        plateNumber: _formData.plateNumber!,
        color: _formData.color!,
        capacity: _formData.capacity!,
        vehicleType: _formData.vehicleType!,
      ),
      driverDocuments: driverDocuments,
      vehicleDocuments: vehicleDocuments,
    );
    
    // Dispatch event
    blocContext.read<DriverRegistrationBloc>().add(
          DriverRegistrationEvent.submitted(
            phoneNumber: _formData.phoneNumber,
            driverData: request.driver,
            vehicleData: request.vehicle,
            driverDocuments: driverDocuments,
            vehicleDocuments: vehicleDocuments,
          ),
        );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<DriverRegistrationBloc>(),
      child: BlocListener<DriverRegistrationBloc, DriverRegistrationState>(
        listenWhen: (previous, current) =>
            previous.isLoading != current.isLoading ||
            previous.isError != current.isError ||
            previous.isSuccess != current.isSuccess,
        listener: (context, state) {
          if (!state.isLoading && state.isSuccess) {
            AppHelpers.showCheckFlash(
              context,
              'Registration successful! Welcome aboard.',
            );
            // Navigate to onboarding or home
            context.goNamed(RouteName.onboarding);
          } else if (!state.isLoading && state.isError) {
            AppHelpers.showErrorFlash(context, state.errorMessage);
          }
        },
        child: Builder(
          builder: (blocContext) {
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
                            formData: _formData,
                            onBackPressed: _currentPage == 0
                                ? () => context.pop()
                                : _previousPage,
                            onNextPressed: () => _nextPage(blocContext),
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
  final DriverRegistrationFormData formData;
  final VoidCallback onBackPressed;
  final VoidCallback onNextPressed;

  const _DriverRegistrationPage({
    required this.data,
    required this.currentPage,
    required this.totalPages,
    required this.formData,
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
          formData: formData,
          onBackPressed: onBackPressed,
          onNextPressed: onNextPressed,
          title: data.title,
        );
      case 1:
        return VehicleInformationPage(
          currentPage: currentPage,
          totalPages: totalPages,
          formData: formData,
          onBackPressed: onBackPressed,
          onNextPressed: onNextPressed,
          title: data.title,
        );
      case 2:
        return MirrorsWipersPage(
          currentPage: currentPage,
          totalPages: totalPages,
          formData: formData,
          onBackPressed: onBackPressed,
          onNextPressed: onNextPressed,
          title: data.title,
        );
      case 3:
        return ExteriorPhotosPage(
          currentPage: currentPage,
          totalPages: totalPages,
          formData: formData,
          onBackPressed: onBackPressed,
          onNextPressed: onNextPressed,
          title: data.title,
        );
      case 4:
        return InteriorPhotosPage(
          currentPage: currentPage,
          totalPages: totalPages,
          formData: formData,
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
