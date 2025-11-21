import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nest_driver/core/handlers/app_connectivity.dart';
import 'package:nest_driver/core/handlers/network_exceptions.dart';
import 'package:nest_driver/core/utils/local_storage.dart';
import 'package:nest_driver/core/value_object/value_objects.dart';
import 'package:nest_driver/core/value_object/abstract_value_objects.dart';
import 'package:nest_driver/features/driver/registration/domain/entities/driver_registration_request.dart';
import 'package:nest_driver/features/driver/registration/domain/entities/driver_registration_response.dart';
import 'package:nest_driver/features/driver/registration/domain/repositories/driver_registration_repository.dart';

part 'driver_registration_bloc.freezed.dart';
part 'driver_registration_event.dart';
part 'driver_registration_state.dart';

@injectable
class DriverRegistrationBloc
    extends Bloc<DriverRegistrationEvent, DriverRegistrationState> {
  DriverRegistrationBloc(this._repository)
      : super(
          DriverRegistrationState(
            phoneNumber: PhoneNumber(''),
            fullName: FullName(''),
            email: EmailAddress(''),
            finNumber: FinNumber(''),
            profileImagePath: '',
            licenseImagePath: '',
            carMake: CarMake(''),
            carModel: CarModel(''),
            yearOfManufacture: YearOfManufacture(0),
            plateNumber: PlateNumber(''),
            color: VehicleColor(''),
            vehicleType: VehicleType(''),
            additionalPhotoPaths: [],
          ),
        ) {
    // Initialize
    on<DriverRegistrationInitialized>(_onInitialized);
    
    // Driver Profile Page
    on<FullNameChanged>(_onFullNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<FinNumberChanged>(_onFinNumberChanged);
    on<ProfileImageChanged>(_onProfileImageChanged);
    on<LicenseImageChanged>(_onLicenseImageChanged);
    
    // Vehicle Information Page
    on<CarMakeChanged>(_onCarMakeChanged);
    on<CarModelChanged>(_onCarModelChanged);
    on<YearOfManufactureChanged>(_onYearOfManufactureChanged);
    on<PlateNumberChanged>(_onPlateNumberChanged);
    on<ColorChanged>(_onColorChanged);
    on<CapacityChanged>(_onCapacityChanged);
    on<VehicleTypeChanged>(_onVehicleTypeChanged);
    
    // Photo pages
    on<FrontWiperPhotoChanged>(_onFrontWiperPhotoChanged);
    on<RearWiperPhotoChanged>(_onRearWiperPhotoChanged);
    on<SideMirror1PhotoChanged>(_onSideMirror1PhotoChanged);
    on<SideMirror2PhotoChanged>(_onSideMirror2PhotoChanged);
    on<RearViewMirrorPhotoChanged>(_onRearViewMirrorPhotoChanged);
    on<FrontPhotoChanged>(_onFrontPhotoChanged);
    on<BackPhotoChanged>(_onBackPhotoChanged);
    on<LeftPhotoChanged>(_onLeftPhotoChanged);
    on<RightPhotoChanged>(_onRightPhotoChanged);
    on<DashboardPhotoChanged>(_onDashboardPhotoChanged);
    on<FrontSeatsPhotoChanged>(_onFrontSeatsPhotoChanged);
    on<BackSeatsPhotoChanged>(_onBackSeatsPhotoChanged);
    on<AdditionalPhotosChanged>(_onAdditionalPhotosChanged);
    on<TermsAcceptedChanged>(_onTermsAcceptedChanged);
    
    // Navigation
    on<NextPage>(_onNextPage);
    on<PreviousPage>(_onPreviousPage);
    on<PageChanged>(_onPageChanged);
    
    // Submit
    on<SubmitForm>(_onSubmitForm);
    on<DriverRegistrationSubmitted>(_onSubmitted);
  }

  final DriverRegistrationRepository _repository;

  // Initialize
  void _onInitialized(
    DriverRegistrationInitialized event,
    Emitter<DriverRegistrationState> emit,
  ) {
    if (event.phoneNumber != null && event.phoneNumber!.trim().isNotEmpty) {
      emit(state.copyWith(
        phoneNumber: PhoneNumber(event.phoneNumber!.trim()),
      ));
    }
  }

  // Driver Profile Page handlers
  void _onFullNameChanged(
    FullNameChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    emit(state.copyWith(
      fullName: FullName(event.fullName.trim()),
    ));
  }

  void _onEmailChanged(
    EmailChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    emit(state.copyWith(
      email: EmailAddress(event.email.trim()),
    ));
  }

  void _onFinNumberChanged(
    FinNumberChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    final trimmed = event.finNumber.trim();
    // Always create FinNumber object so it can be validated
    emit(state.copyWith(
      finNumber: FinNumber(trimmed),
    ));
  }

  void _onProfileImageChanged(
    ProfileImageChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    final newImagePath = event.imagePath ?? '';
    emit(state.copyWith(
      profileImagePath: newImagePath,
      // Clear validation error if image is now valid
      firstInvalidField: (state.firstInvalidField == 'profileImage' && newImagePath.isNotEmpty)
          ? null
          : state.firstInvalidField,
    ));
  }

  void _onLicenseImageChanged(
    LicenseImageChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    final newImagePath = event.imagePath ?? '';
    emit(state.copyWith(
      licenseImagePath: newImagePath,
      // Clear validation error if image is now valid
      firstInvalidField: (state.firstInvalidField == 'licenseImage' && newImagePath.isNotEmpty)
          ? null
          : state.firstInvalidField,
    ));
  }

  // Vehicle Information Page handlers
  void _onCarMakeChanged(
    CarMakeChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    emit(state.copyWith(
      carMake: CarMake(event.carMake.trim()),
    ));
  }

  void _onCarModelChanged(
    CarModelChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    emit(state.copyWith(
      carModel: CarModel(event.carModel.trim()),
    ));
  }

  void _onYearOfManufactureChanged(
    YearOfManufactureChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    emit(state.copyWith(
      yearOfManufacture: YearOfManufacture(event.year),
    ));
  }

  void _onPlateNumberChanged(
    PlateNumberChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    emit(state.copyWith(
      plateNumber: PlateNumber(event.plateNumber.trim()),
    ));
  }

  void _onColorChanged(
    ColorChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    emit(state.copyWith(
      color: VehicleColor(event.color.trim()),
    ));
  }

  void _onCapacityChanged(
    CapacityChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    emit(state.copyWith(
      capacity: event.capacity > 0 ? VehicleCapacity(event.capacity) : null,
    ));
  }

  void _onVehicleTypeChanged(
    VehicleTypeChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    emit(state.copyWith(
      vehicleType: VehicleType(event.vehicleType.trim()),
    ));
  }

  // Photo pages handlers
  void _onFrontWiperPhotoChanged(
    FrontWiperPhotoChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    final newImagePath = event.imagePath ?? '';
    emit(state.copyWith(
      frontWiperPhotoPath: newImagePath,
      // Clear validation error if image is now valid
      firstInvalidField: (state.firstInvalidField == 'frontWiperPhoto' && newImagePath.isNotEmpty)
          ? null
          : state.firstInvalidField,
    ));
  }

  void _onRearWiperPhotoChanged(
    RearWiperPhotoChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    final newImagePath = event.imagePath ?? '';
    emit(state.copyWith(
      rearWiperPhotoPath: newImagePath,
      // Clear validation error if image is now valid
      firstInvalidField: (state.firstInvalidField == 'rearWiperPhoto' && newImagePath.isNotEmpty)
          ? null
          : state.firstInvalidField,
    ));
  }

  void _onSideMirror1PhotoChanged(
    SideMirror1PhotoChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    final newImagePath = event.imagePath ?? '';
    emit(state.copyWith(
      sideMirror1PhotoPath: newImagePath,
      // Clear validation error if image is now valid
      firstInvalidField: (state.firstInvalidField == 'sideMirror1Photo' && newImagePath.isNotEmpty)
          ? null
          : state.firstInvalidField,
    ));
  }

  void _onSideMirror2PhotoChanged(
    SideMirror2PhotoChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    final newImagePath = event.imagePath ?? '';
    emit(state.copyWith(
      sideMirror2PhotoPath: newImagePath,
      // Clear validation error if image is now valid
      firstInvalidField: (state.firstInvalidField == 'sideMirror2Photo' && newImagePath.isNotEmpty)
          ? null
          : state.firstInvalidField,
    ));
  }

  void _onRearViewMirrorPhotoChanged(
    RearViewMirrorPhotoChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    final newImagePath = event.imagePath ?? '';
    emit(state.copyWith(
      rearViewMirrorPhotoPath: newImagePath,
      // Clear validation error if image is now valid
      firstInvalidField: (state.firstInvalidField == 'rearViewMirrorPhoto' && newImagePath.isNotEmpty)
          ? null
          : state.firstInvalidField,
    ));
  }

  void _onFrontPhotoChanged(
    FrontPhotoChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    final newImagePath = event.imagePath ?? '';
    emit(state.copyWith(
      frontPhotoPath: newImagePath,
      // Clear validation error if image is now valid
      firstInvalidField: (state.firstInvalidField == 'frontPhoto' && newImagePath.isNotEmpty)
          ? null
          : state.firstInvalidField,
    ));
  }

  void _onBackPhotoChanged(
    BackPhotoChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    final newImagePath = event.imagePath ?? '';
    emit(state.copyWith(
      backPhotoPath: newImagePath,
      // Clear validation error if image is now valid
      firstInvalidField: (state.firstInvalidField == 'backPhoto' && newImagePath.isNotEmpty)
          ? null
          : state.firstInvalidField,
    ));
  }

  void _onLeftPhotoChanged(
    LeftPhotoChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    final newImagePath = event.imagePath ?? '';
    emit(state.copyWith(
      leftPhotoPath: newImagePath,
      // Clear validation error if image is now valid
      firstInvalidField: (state.firstInvalidField == 'leftPhoto' && newImagePath.isNotEmpty)
          ? null
          : state.firstInvalidField,
    ));
  }

  void _onRightPhotoChanged(
    RightPhotoChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    final newImagePath = event.imagePath ?? '';
    emit(state.copyWith(
      rightPhotoPath: newImagePath,
      // Clear validation error if image is now valid
      firstInvalidField: (state.firstInvalidField == 'rightPhoto' && newImagePath.isNotEmpty)
          ? null
          : state.firstInvalidField,
    ));
  }

  void _onDashboardPhotoChanged(
    DashboardPhotoChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    final newImagePath = event.imagePath ?? '';
    emit(state.copyWith(
      dashboardPhotoPath: newImagePath,
      // Clear validation error if image is now valid
      firstInvalidField: (state.firstInvalidField == 'dashboardPhoto' && newImagePath.isNotEmpty)
          ? null
          : state.firstInvalidField,
    ));
  }

  void _onFrontSeatsPhotoChanged(
    FrontSeatsPhotoChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    final newImagePath = event.imagePath ?? '';
    emit(state.copyWith(
      frontSeatsPhotoPath: newImagePath,
      // Clear validation error if image is now valid
      firstInvalidField: (state.firstInvalidField == 'frontSeatsPhoto' && newImagePath.isNotEmpty)
          ? null
          : state.firstInvalidField,
    ));
  }

  void _onBackSeatsPhotoChanged(
    BackSeatsPhotoChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    final newImagePath = event.imagePath ?? '';
    emit(state.copyWith(
      backSeatsPhotoPath: newImagePath,
      // Clear validation error if image is now valid
      firstInvalidField: (state.firstInvalidField == 'backSeatsPhoto' && newImagePath.isNotEmpty)
          ? null
          : state.firstInvalidField,
    ));
  }

  void _onAdditionalPhotosChanged(
    AdditionalPhotosChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    emit(state.copyWith(additionalPhotoPaths: event.imagePaths));
  }

  void _onTermsAcceptedChanged(
    TermsAcceptedChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    emit(state.copyWith(termsAccepted: event.accepted));
  }

  // Navigation handlers
  void _onNextPage(
    NextPage event,
    Emitter<DriverRegistrationState> emit,
  ) {
    // Mark current page as validated
    final validatedPages = Set<int>.from(state.validatedPages);
    validatedPages.add(state.currentPage);

    // Validate current page
    final firstInvalidField = _validateCurrentPage();

    if (firstInvalidField != null) {
      // Validation failed - show errors
      emit(state.copyWith(
        validatedPages: validatedPages,
        firstInvalidField: firstInvalidField,
        showErrorMessages: true,
        shouldNavigateNext: false,
      ));
      return;
    }

    // Validation passed - check if this is the last page
    final nextPage = state.currentPage + 1;
    final isLastPage = nextPage >= 5; // Total pages = 5 (0-4)

    if (isLastPage) {
      // Final page - submit form
      add(const DriverRegistrationEvent.submitForm());
    } else {
      // Navigate to next page
      emit(state.copyWith(
        currentPage: nextPage,
        validatedPages: validatedPages,
        firstInvalidField: null,
        shouldNavigateNext: true,
      ));
    }
  }

  void _onPreviousPage(
    PreviousPage event,
    Emitter<DriverRegistrationState> emit,
  ) {
    if (state.currentPage > 0) {
      emit(state.copyWith(
        currentPage: state.currentPage - 1,
        firstInvalidField: null,
        shouldNavigatePrevious: true,
      ));
    }
  }

  void _onPageChanged(
    PageChanged event,
    Emitter<DriverRegistrationState> emit,
  ) {
    emit(state.copyWith(
      currentPage: event.pageIndex,
      firstInvalidField: null,
      shouldNavigateNext: false,
      shouldNavigatePrevious: false,
    ));
  }

  // Submit handler
  Future<void> _onSubmitForm(
    SubmitForm event,
    Emitter<DriverRegistrationState> emit,
  ) async {
    // Validate all fields
    final firstInvalidField = _validateAllFields();
    if (firstInvalidField != null) {
      emit(state.copyWith(
        isError: true,
        errorMessage: firstInvalidField,
        isLoading: false,
        showErrorMessages: true,
      ));
      return;
    }

    if (!state.termsAccepted) {
      emit(state.copyWith(
        isError: true,
        errorMessage: 'You must agree to the terms and conditions',
        isLoading: false,
        showErrorMessages: true,
      ));
      return;
    }

    final connected = await AppConnectivity.connectivity();
    if (!connected) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: "No internet connection. Please check your network.",
      ));
      return;
    }

    emit(state.copyWith(isLoading: true, isError: false, errorMessage: ''));

    // Build driver documents
    final driverDocuments = _buildDriverDocuments();
    
    // Build vehicle documents
    final vehicleDocuments = _buildVehicleDocuments();

    // Build request
    final request = DriverRegistrationRequest(
      phoneNumber: state.phoneNumber.getOrCrash(),
      driver: DriverRequestData(
        fullName: state.fullName.getOrCrash(),
        email: state.email.getOrCrash(),
        finNumber: state.finNumber.getOrCrash(),
      ),
      vehicle: VehicleRequestData(
        carMake: state.carMake.getOrCrash(),
        carModel: state.carModel.getOrCrash(),
        yearOfManufacture: state.yearOfManufacture.getOrCrash(),
        plateNumber: state.plateNumber.getOrCrash(),
        color: state.color.getOrCrash(),
        capacity: state.capacity?.getOrCrash() ?? 0,
        vehicleType: state.vehicleType.getOrCrash(),
      ),
      driverDocuments: driverDocuments,
      vehicleDocuments: vehicleDocuments,
    );

    // Dispatch the submitted event with built request
    add(DriverRegistrationEvent.submitted(
      phoneNumber: state.phoneNumber.getOrCrash(),
      driverData: request.driver,
      vehicleData: request.vehicle,
      driverDocuments: driverDocuments,
      vehicleDocuments: vehicleDocuments,
    ));
  }

  // Legacy submit handler
  Future<void> _onSubmitted(
    DriverRegistrationSubmitted event,
    Emitter<DriverRegistrationState> emit,
  ) async {
    final connected = await AppConnectivity.connectivity();
    if (!connected) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: "No internet connection. Please check your network.",
      ));
      return;
    }

    emit(state.copyWith(isLoading: true, isError: false, errorMessage: ''));

    // Build request
    final request = DriverRegistrationRequest(
      phoneNumber: event.phoneNumber,
      driver: event.driverData,
      vehicle: event.vehicleData,
      driverDocuments: event.driverDocuments,
      vehicleDocuments: event.vehicleDocuments,
    );

    final result = await _repository.registerDriver(request);

    await result.fold(
      (failure) async {
        final error = NetworkExceptions.getRawErrorMessage(failure);
        emit(state.copyWith(
          isLoading: false,
          isError: true,
          errorMessage: error,
          isSuccess: false,
          sessionCreated: false,
        ));
      },
      (success) async {
        bool sessionCreated = false;
        final accessToken = success.data.token.accessToken;
        final refreshToken = success.data.token.refreshToken;

        if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
          await LocalStorage.instance.setAccessToken(accessToken);
          await LocalStorage.instance.setRefreshToken(refreshToken);
          sessionCreated = true;
        }

        emit(state.copyWith(
          isLoading: false,
          isError: false,
          errorMessage: '',
          isSuccess: true,
          response: success,
          sessionCreated: sessionCreated,
        ));
      },
    );
  }

  // Helper methods
  String? _validateCurrentPage() {
    switch (state.currentPage) {
      case 0: // Driver Profile Page
        if (state.profileImagePath.isEmpty) {
          return 'profileImage';
        }
        if (!state.fullName.isValid()) return 'fullName';
        if (!state.email.isValid()) return 'email';
        
        if (state.licenseImagePath.isEmpty) {
          return 'licenseImage';
        }
        if (!state.finNumber.isValid()) return 'finNumber';
        return null;

      case 1: // Vehicle Information Page
        if (!state.carMake.isValid()) return 'carMake';
        if (!state.carModel.isValid()) return 'carModel';
        if (!state.yearOfManufacture.isValid()) return 'yearOfManufacture';
        if (!state.plateNumber.isValid()) return 'plateNumber';
        if (!state.color.isValid()) return 'color';
        if (state.capacity != null && !state.capacity!.isValid()) {
          return 'capacity';
        }
        if (!state.vehicleType.isValid()) return 'vehicleType';
        return null;

      case 2: // Mirrors & Wipers Page
        if (state.frontWiperPhotoPath == null || state.frontWiperPhotoPath!.isEmpty) {
          return 'frontWiperPhoto';
        }
        if (state.rearWiperPhotoPath == null || state.rearWiperPhotoPath!.isEmpty) {
          return 'rearWiperPhoto';
        }
        if (state.sideMirror1PhotoPath == null || state.sideMirror1PhotoPath!.isEmpty) {
          return 'sideMirror1Photo';
        }
        if (state.sideMirror2PhotoPath == null || state.sideMirror2PhotoPath!.isEmpty) {
          return 'sideMirror2Photo';
        }
        if (state.rearViewMirrorPhotoPath == null || state.rearViewMirrorPhotoPath!.isEmpty) {
          return 'rearViewMirrorPhoto';
        }
        return null;

      case 3: // Exterior Photos Page
        if (state.frontPhotoPath == null || state.frontPhotoPath!.isEmpty) {
          return 'frontPhoto';
        }
        if (state.backPhotoPath == null || state.backPhotoPath!.isEmpty) {
          return 'backPhoto';
        }
        if (state.leftPhotoPath == null || state.leftPhotoPath!.isEmpty) {
          return 'leftPhoto';
        }
        if (state.rightPhotoPath == null || state.rightPhotoPath!.isEmpty) {
          return 'rightPhoto';
        }
        return null;

      case 4: // Interior Photos Page
        if (state.dashboardPhotoPath == null || state.dashboardPhotoPath!.isEmpty) {
          return 'dashboardPhoto';
        }
        if (state.frontSeatsPhotoPath == null || state.frontSeatsPhotoPath!.isEmpty) {
          return 'frontSeatsPhoto';
        }
        if (state.backSeatsPhotoPath == null || state.backSeatsPhotoPath!.isEmpty) {
          return 'backSeatsPhoto';
        }
        // additionalPhotoPaths is optional - no validation needed
        if (!state.termsAccepted) return 'terms';
        return null;

      default:
        return null;
    }
  }

  String? _validateAllFields() {
    // Validate all required fields - return first error found
    if (!state.phoneNumber.isValid()) {
      return _getValidationError(state.phoneNumber);
    }
    if (!state.fullName.isValid()) {
      return _getValidationError(state.fullName);
    }
    if (!state.email.isValid()) {
      return _getValidationError(state.email);
    }
    if (!state.finNumber.isValid()) {
      return _getValidationError(state.finNumber);
    }
    if (!state.carMake.isValid()) {
      return _getValidationError(state.carMake);
    }
    if (!state.carModel.isValid()) {
      return _getValidationError(state.carModel);
    }
    if (!state.yearOfManufacture.isValid()) {
      return _getValidationError(state.yearOfManufacture);
    }
    if (!state.plateNumber.isValid()) {
      return _getValidationError(state.plateNumber);
    }
    if (!state.color.isValid()) {
      return _getValidationError(state.color);
    }
    if (state.capacity != null && !state.capacity!.isValid()) {
      return _getValidationError(state.capacity!);
    }
    if (!state.vehicleType.isValid()) {
      return _getValidationError(state.vehicleType);
    }
    return null;
  }

  /// Helper method to extract error message from value object
  String? _getValidationError<T>(AbstractValueObject<T> valueObject) {
    return valueObject.value.fold(
      (failure) => failure.failedValue.toString(),
      (_) => null,
    );
  }

  /// Build driver documents list
  List<DriverDocumentRequestData> _buildDriverDocuments() {
    return [
      if (state.profileImagePath.isNotEmpty)
        DriverDocumentRequestData(
          docType: 'profile_picture',
          path: state.profileImagePath,
        ),
      if (state.licenseImagePath.isNotEmpty)
        DriverDocumentRequestData(
          docType: 'driver_license',
          path: state.licenseImagePath,
        ),
    ];
  }

  /// Build vehicle documents list
  List<VehicleDocumentRequestData> _buildVehicleDocuments() {
    final documents = <VehicleDocumentRequestData>[];
    
    // Mirrors & Wipers
    if (state.frontWiperPhotoPath != null) {
      documents.add(VehicleDocumentRequestData(
        docType: 'front_wiper',
        path: state.frontWiperPhotoPath!,
      ));
    }
    if (state.rearWiperPhotoPath != null) {
      documents.add(VehicleDocumentRequestData(
        docType: 'rear_wiper',
        path: state.rearWiperPhotoPath!,
      ));
    }
    if (state.sideMirror1PhotoPath != null) {
      documents.add(VehicleDocumentRequestData(
        docType: 'side_mirror_1',
        path: state.sideMirror1PhotoPath!,
      ));
    }
    if (state.sideMirror2PhotoPath != null) {
      documents.add(VehicleDocumentRequestData(
        docType: 'side_mirror_2',
        path: state.sideMirror2PhotoPath!,
      ));
    }
    if (state.rearViewMirrorPhotoPath != null) {
      documents.add(VehicleDocumentRequestData(
        docType: 'rear_view_mirror',
        path: state.rearViewMirrorPhotoPath!,
      ));
    }
    
    // Exterior Photos
    if (state.frontPhotoPath != null) {
      documents.add(VehicleDocumentRequestData(
        docType: 'front_side',
        path: state.frontPhotoPath!,
      ));
    }
    if (state.backPhotoPath != null) {
      documents.add(VehicleDocumentRequestData(
        docType: 'back_side',
        path: state.backPhotoPath!,
      ));
    }
    if (state.leftPhotoPath != null) {
      documents.add(VehicleDocumentRequestData(
        docType: 'left_side',
        path: state.leftPhotoPath!,
      ));
    }
    if (state.rightPhotoPath != null) {
      documents.add(VehicleDocumentRequestData(
        docType: 'right_side',
        path: state.rightPhotoPath!,
      ));
    }
    
    // Interior Photos
    if (state.dashboardPhotoPath != null) {
      documents.add(VehicleDocumentRequestData(
        docType: 'dashboard',
        path: state.dashboardPhotoPath!,
      ));
    }
    if (state.frontSeatsPhotoPath != null) {
      documents.add(VehicleDocumentRequestData(
        docType: 'front_seats',
        path: state.frontSeatsPhotoPath!,
      ));
    }
    if (state.backSeatsPhotoPath != null) {
      documents.add(VehicleDocumentRequestData(
        docType: 'back_seats',
        path: state.backSeatsPhotoPath!,
      ));
    }
    
    // Additional photos
    documents.addAll(
      state.additionalPhotoPaths.map(
        (path) => VehicleDocumentRequestData(
          docType: 'other_seats',
          path: path,
        ),
      ),
    );
    
    return documents;
  }
}
