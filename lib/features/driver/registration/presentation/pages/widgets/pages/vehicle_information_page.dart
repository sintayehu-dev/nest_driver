import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/presentation/widgets/app_back_button.dart';
import 'package:nest_driver/features/driver/registration/presentation/pages/widgets/driver_registration_progress_indicator.dart';

class VehicleInformationPage extends StatefulWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onNextPressed;
  final int currentPage;
  final int totalPages;
  final String title;

  const VehicleInformationPage({
    super.key,
    required this.onBackPressed,
    required this.onNextPressed,
    required this.currentPage,
    required this.totalPages,
    required this.title,
  });

  @override
  State<VehicleInformationPage> createState() => _VehicleInformationPageState();
}

class _VehicleInformationPageState extends State<VehicleInformationPage> {
  final _formKey = GlobalKey<FormState>();
  final _carMakeController = TextEditingController();
  final _yearOfManufactureController = TextEditingController();
  final _carModelController = TextEditingController();
  final _plateNumberController = TextEditingController();
  final _colorController = TextEditingController();
  final _capacityController = TextEditingController();
  String? _selectedVehicleType;

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
  void dispose() {
    _carMakeController.dispose();
    _yearOfManufactureController.dispose();
    _carModelController.dispose();
    _plateNumberController.dispose();
    _colorController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back button and progress
              Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        AppBackButton(
                          onPressed: widget.onBackPressed ?? () => context.pop(),
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
                    // Progress indicator
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
            RichText(
              text: TextSpan(
                text: 'Car Make',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF212121),
                  fontSize: 14.sp,
                ),
                children: [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _carMakeController,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                color: const Color(0xFF212121),
              ),
              decoration: InputDecoration(
                hintText: 'Eg. "Toyota"',
                hintStyle: TextStyle(
                  color: const Color(0xFFBDBDBD),
                  fontSize: 14.sp,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter car make';
                }
                return null;
              },
            ),

            SizedBox(height: 20.h),

            // Year of Manufacture
            RichText(
              text: TextSpan(
                text: 'Year of Manufacture',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF212121),
                  fontSize: 14.sp,
                ),
                children: [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _yearOfManufactureController,
              keyboardType: TextInputType.number,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                color: const Color(0xFF212121),
              ),
              decoration: InputDecoration(
                hintText: 'Eg. "2020"',
                hintStyle: TextStyle(
                  color: const Color(0xFFBDBDBD),
                  fontSize: 14.sp,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter year of manufacture';
                }
                return null;
              },
            ),

            SizedBox(height: 20.h),

            // Car Model
            RichText(
              text: TextSpan(
                text: 'Car Model',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF212121),
                  fontSize: 14.sp,
                ),
                children: [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _carModelController,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                color: const Color(0xFF212121),
              ),
              decoration: InputDecoration(
                hintText: 'Eg. "Corolla"',
                hintStyle: TextStyle(
                  color: const Color(0xFFBDBDBD),
                  fontSize: 14.sp,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter car model';
                }
                return null;
              },
            ),

            SizedBox(height: 20.h),

            // Plate Number
            RichText(
              text: TextSpan(
                text: 'Plate Number',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF212121),
                  fontSize: 14.sp,
                ),
                children: [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _plateNumberController,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                color: const Color(0xFF212121),
              ),
              decoration: InputDecoration(
                hintText: 'ABC-1234',
                hintStyle: TextStyle(
                  color: const Color(0xFFBDBDBD),
                  fontSize: 14.sp,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter plate number';
                }
                return null;
              },
            ),

            SizedBox(height: 20.h),

            // Color
            RichText(
              text: TextSpan(
                text: 'Color',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF212121),
                  fontSize: 14.sp,
                ),
                children: [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _colorController,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                color: const Color(0xFF212121),
              ),
              decoration: InputDecoration(
                hintText: 'Eg. "Red"',
                hintStyle: TextStyle(
                  color: const Color(0xFFBDBDBD),
                  fontSize: 14.sp,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter color';
                }
                return null;
              },
            ),

            SizedBox(height: 20.h),

            // Capacity
            RichText(
              text: TextSpan(
                text: 'Capacity',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF212121),
                  fontSize: 14.sp,
                ),
                children: [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _capacityController,
              keyboardType: TextInputType.number,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                color: const Color(0xFF212121),
              ),
              decoration: InputDecoration(
                hintText: 'Eg. 4',
                hintStyle: TextStyle(
                  color: const Color(0xFFBDBDBD),
                  fontSize: 14.sp,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter capacity';
                }
                return null;
              },
            ),

            SizedBox(height: 20.h),

            // Vehicle Type
            RichText(
              text: TextSpan(
                text: 'Vehicle Type',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF212121),
                  fontSize: 14.sp,
                ),
                children: [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            DropdownButtonFormField<String>(
              value: _selectedVehicleType,
              decoration: InputDecoration(
                hintText: 'Select vehicle category',
                hintStyle: TextStyle(
                  color: const Color(0xFFBDBDBD),
                  fontSize: 14.sp,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
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
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                color: const Color(0xFF212121),
              ),
              items: _vehicleTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedVehicleType = newValue;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select vehicle type';
                }
                return null;
              },
            ),

              SizedBox(height: 24.h),

              // Navigation Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.onNextPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  child: Text(
                    widget.currentPage == widget.totalPages - 1 ? 'Submit' : 'Next',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
