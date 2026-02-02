import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nest_driver/core/presentation/widgets/app_back_button.dart';
import 'package:nest_driver/core/presentation/widgets/input_validation_message.dart';
import 'package:nest_driver/features/driver/registration/application/bloc/driver_registration_bloc.dart';
import 'package:nest_driver/features/driver/registration/presentation/widgets/driver_registration_progress_indicator.dart';
import 'package:nest_driver/features/driver/registration/presentation/widgets/driver_registration_button.dart';

class VehicleInformationPage extends StatefulWidget {
  final int currentPage;
  final int totalPages;
  final String title;

  const VehicleInformationPage({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.title,
  });

  @override
  State<VehicleInformationPage> createState() => _VehicleInformationPageState();
}

class _VehicleInformationPageState extends State<VehicleInformationPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _carMakeController;
  late final TextEditingController _yearOfManufactureController;
  late final TextEditingController _carModelController;
  late final TextEditingController _plateNumberController;
  late final TextEditingController _colorController;
  late final TextEditingController _capacityController;

  final List<String> _vehicleTypes = [
    'Sedan',
    'SUV',
    'Hatchback',
    'Coupe',
    'Convertible',
    'Truck',
    'Van',
    'Motorcycle',
  ];

  @override
  void initState() {
    super.initState();
    // Initialize controllers from BLoC state
    final state = context.read<DriverRegistrationBloc>().state;
    _carMakeController = TextEditingController(
      text: state.carMake.getOrElse(''),
    );
    _yearOfManufactureController = TextEditingController(
      text: state.yearOfManufacture.getOrElse(0).toString(),
    );
    _carModelController = TextEditingController(
      text: state.carModel.getOrElse(''),
    );
    _plateNumberController = TextEditingController(
      text: state.plateNumber.getOrElse(''),
    );
    _colorController = TextEditingController(
      text: state.color.getOrElse(''),
    );
    _capacityController = TextEditingController(
      text: state.capacity.getOrElse(0).toString(),
    );

    // Add listeners to dispatch BLoC events
    _carMakeController.addListener(() {
      context.read<DriverRegistrationBloc>().add(
            DriverRegistrationEvent.carMakeChanged(_carMakeController.text),
          );
    });
    _yearOfManufactureController.addListener(() {
      final text = _yearOfManufactureController.text.trim();
      if (text.isEmpty) {
        context.read<DriverRegistrationBloc>().add(
              const DriverRegistrationEvent.yearOfManufactureChanged(0),
            );
      } else {
        final year = int.tryParse(text);
        if (year != null) {
          context.read<DriverRegistrationBloc>().add(
                DriverRegistrationEvent.yearOfManufactureChanged(year),
              );
        }
      }
    });
    _carModelController.addListener(() {
      context.read<DriverRegistrationBloc>().add(
            DriverRegistrationEvent.carModelChanged(_carModelController.text),
          );
    });
    _plateNumberController.addListener(() {
      context.read<DriverRegistrationBloc>().add(
            DriverRegistrationEvent.plateNumberChanged(
                _plateNumberController.text),
          );
    });
    _colorController.addListener(() {
      context.read<DriverRegistrationBloc>().add(
            DriverRegistrationEvent.colorChanged(_colorController.text),
          );
    });
    _capacityController.addListener(() {
      final text = _capacityController.text.trim();
      if (text.isEmpty) {
        context.read<DriverRegistrationBloc>().add(
              const DriverRegistrationEvent.capacityChanged(0),
            );
      } else {
        final capacity = int.tryParse(text);
        if (capacity != null) {
          context.read<DriverRegistrationBloc>().add(
                DriverRegistrationEvent.capacityChanged(capacity),
              );
        }
      }
    });
  }

  @override
  void dispose() {
    _carMakeController.dispose();
    _yearOfManufactureController.dispose();
    _carModelController.dispose();
    _plateNumberController.dispose();
    _colorController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  Widget _buildField({
    required String label,
    required bool isRequired,
    required Widget child,
    String? fieldName,
    required DriverRegistrationState state,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            children: isRequired
                ? [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ]
                : [],
          ),
        ),
        SizedBox(height: 8.h),
        child,
        if (fieldName != null &&
            state.showErrorMessages &&
            state.firstInvalidField == fieldName)
          _buildValidationMessage(state, fieldName),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildValidationMessage(
    DriverRegistrationState state,
    String fieldName,
  ) {
    switch (fieldName) {
      case 'carMake':
        return state.carMake.value.fold(
          (failure) => InputValidationMessage(
            message: failure.failedValue.toString(),
          ),
          (_) => const SizedBox.shrink(),
        );
      case 'carModel':
        return state.carModel.value.fold(
          (failure) => InputValidationMessage(
            message: failure.failedValue.toString(),
          ),
          (_) => const SizedBox.shrink(),
        );
      case 'yearOfManufacture':
        return state.yearOfManufacture.value.fold(
          (failure) => InputValidationMessage(
            message: failure.failedValue.toString(),
          ),
          (_) => const SizedBox.shrink(),
        );
      case 'plateNumber':
        return state.plateNumber.value.fold(
          (failure) => InputValidationMessage(
            message: failure.failedValue.toString(),
          ),
          (_) => const SizedBox.shrink(),
        );
      case 'color':
        return state.color.value.fold(
          (failure) => InputValidationMessage(
            message: failure.failedValue.toString(),
          ),
          (_) => const SizedBox.shrink(),
        );
      case 'capacity':
        return state.capacity.value.fold(
          (failure) => InputValidationMessage(
            message: failure.failedValue.toString(),
          ),
          (_) => const SizedBox.shrink(),
        );
      case 'vehicleType':
        return state.vehicleType.value.fold(
          (failure) => InputValidationMessage(
            message: failure.failedValue.toString(),
          ),
          (_) => const SizedBox.shrink(),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: theme.textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
        filled: true,
        fillColor: theme.inputDecorationTheme.fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 14.h,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<DriverRegistrationBloc, DriverRegistrationState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            AppBackButton(
                              onPressed: () {
                                context.read<DriverRegistrationBloc>().add(
                                      const DriverRegistrationEvent
                                          .previousPage(),
                                    );
                              },
                            ),
                            const Spacer(),
                            Text(
                              '${widget.currentPage + 1}/${widget.totalPages}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        DriverRegistrationProgressIndicator(
                          currentPage: widget.currentPage,
                          totalPages: widget.totalPages,
                        ),
                      ],
                    ),
                  ),

                  // Title
                  Padding(
                    padding: EdgeInsets.only(top: 32.h),
                    child: Text(
                      widget.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Car Make
                  _buildField(
                    label: 'Car Make',
                    isRequired: true,
                    child: _buildTextField(
                      controller: _carMakeController,
                      hintText: 'Eg. "Toyota"',
                    ),
                    fieldName: 'carMake',
                    state: state,
                  ),

                  // Year of Manufacture
                  _buildField(
                    label: 'Year of Manufacture',
                    isRequired: true,
                    child: _buildTextField(
                      controller: _yearOfManufactureController,
                      hintText: 'Eg. "2020"',
                      keyboardType: TextInputType.number,
                    ),
                    fieldName: 'yearOfManufacture',
                    state: state,
                  ),

                  // Car Model
                  _buildField(
                    label: 'Car Model',
                    isRequired: true,
                    child: _buildTextField(
                      controller: _carModelController,
                      hintText: 'Eg. "Corolla"',
                    ),
                    fieldName: 'carModel',
                    state: state,
                  ),

                  // Plate Number
                  _buildField(
                    label: 'Plate Number',
                    isRequired: true,
                    child: _buildTextField(
                      controller: _plateNumberController,
                      hintText: 'ABC-1234',
                    ),
                    fieldName: 'plateNumber',
                    state: state,
                  ),

                  // Color
                  _buildField(
                    label: 'Color',
                    isRequired: true,
                    child: _buildTextField(
                      controller: _colorController,
                      hintText: 'Eg. "Red"',
                    ),
                    fieldName: 'color',
                    state: state,
                  ),

                  // Capacity
                  _buildField(
                    label: 'Capacity',
                    isRequired: true,
                    child: _buildTextField(
                      controller: _capacityController,
                      hintText: 'Eg. 4',
                      keyboardType: TextInputType.number,
                    ),
                    fieldName: 'capacity',
                    state: state,
                  ),

                  // Vehicle Type
                  _buildField(
                    label: 'Vehicle Type',
                    isRequired: true,
                    child: DropdownButtonFormField<String>(
                      value: state.vehicleType.isValid()
                          ? state.vehicleType.getOrElse('')
                          : null,
                      decoration: InputDecoration(
                        hintText: 'Select vehicle category',
                        hintStyle: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        filled: true,
                        fillColor: theme.inputDecorationTheme.fillColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down,
                          color: theme.colorScheme.onSurfaceVariant,
                          size: 24.sp,
                        ),
                      ),
                      style: theme.textTheme.bodyMedium,
                      items: _vehicleTypes.map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null && newValue.isNotEmpty) {
                          context.read<DriverRegistrationBloc>().add(
                                DriverRegistrationEvent.vehicleTypeChanged(
                                    newValue),
                              );
                        }
                      },
                    ),
                    fieldName: 'vehicleType',
                    state: state,
                  ),

                  SizedBox(height: 24.h),

                  // Next Button
                  DriverRegistrationButton(
                    onPressed: () {
                      context.read<DriverRegistrationBloc>().add(
                            const DriverRegistrationEvent.nextPage(),
                          );
                    },
                    isLastPage: false,
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
