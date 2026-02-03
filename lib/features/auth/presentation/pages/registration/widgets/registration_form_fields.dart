import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_picker/country_picker.dart';
import 'package:nest_driver/core/theme/app_colors.dart';
import 'package:nest_driver/core/theme/app_theme.dart';
import 'package:nest_driver/core/presentation/widgets/input_validation_message.dart';
import 'package:nest_driver/features/auth/application/otplogin/bloc/otp_login_bloc.dart';

class RegistrationFormFields extends StatefulWidget {
  final TextEditingController phoneController;
  final ValueChanged<String>? onPhoneChanged;
  final ValueChanged<Country>? onCountryChanged;

  const RegistrationFormFields({
    super.key,
    required this.phoneController,
    this.onPhoneChanged,
    this.onCountryChanged,
  });

  @override
  State<RegistrationFormFields> createState() => _RegistrationFormFieldsState();
}

class _RegistrationFormFieldsState extends State<RegistrationFormFields> {
  Country _selectedCountry = Country.parse('ET');
  bool _isDropdownOpen = false;
  OverlayEntry? _overlayEntry;
  final List<Country> _allCountries = CountryService().getAll();
  final GlobalKey _fieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onCountryChanged?.call(_selectedCountry);
    });
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox =
        _fieldKey.currentContext!.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var position = renderBox.localToGlobal(Offset.zero);

    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight - position.dy - size.height;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            left: position.dx,
            top: position.dy + size.height,
            width: size.width,
            height: availableHeight - 20.h,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r),
                  ),
                  border: Border(
                    left: BorderSide(color: AppColors.divider),
                    right: BorderSide(color: AppColors.divider),
                    bottom: BorderSide(color: AppColors.divider),
                  ),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _allCountries.length,
                  itemBuilder: (context, index) {
                    final country = _allCountries[index];
                    final isSelected =
                        country.countryCode == _selectedCountry.countryCode;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCountry = country;
                        });
                        widget.onCountryChanged?.call(country);
                        _removeOverlay();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withOpacity(0.1)
                              : null,
                        ),
                        child: Row(
                          children: [
                            Text(
                              country.flagEmoji,
                              style: TextStyle(fontSize: 20.sp),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              '+${country.phoneCode}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                country.name,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputFillColor =
        theme.inputDecorationTheme.fillColor ?? AppColors.inputBackground;
    final dividerColor = theme.colorScheme.outlineVariant.withOpacity(0.5);
    final hintColor =
        theme.inputDecorationTheme.hintStyle?.color ?? theme.hintColor;
    final otpState = context.watch<OtpLoginBloc>().state;
    final String validationMessage =
        otpState.showErrorMessages && !otpState.phoneNumber.isValid()
            ? otpState.phoneNumber.value.fold(
                (failure) => failure.failedValue.toString(),
                (_) => '',
              )
            : '';
    final bool hasError = validationMessage.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone number',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          key: _fieldKey,
          height: 56.h,
          decoration: BoxDecoration(
            color: inputFillColor,
            border: Border.all(
              color: hasError ? theme.colorScheme.error : Colors.transparent,
            ),
            borderRadius: _isDropdownOpen
                ? BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  )
                : BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: _toggleDropdown,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  bottomLeft: Radius.circular(8.r),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedCountry.flagEmoji,
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '+${_selectedCountry.phoneCode}',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        _isDropdownOpen
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: theme.colorScheme.onSurface,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1,
                color: dividerColor,
              ),
              Expanded(
                child: TextFormField(
                  controller: widget.phoneController,
                  keyboardType: TextInputType.none,
                  readOnly: true,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  onChanged: widget.onPhoneChanged,
                  decoration: InputDecoration(
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 16.w,
                    ),
                    hintText: '123 4567 890',
                    hintStyle: theme.textTheme.bodyLarge?.copyWith(
                      color: hintColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (hasError) ...[
          SizedBox(height: 8.h),
          InputValidationMessage(
            message: validationMessage,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          ),
        ],
        SizedBox(height: 16.h),
        Row(
          children: [
            Icon(
              Icons.info_outline,
              size: theme.iconSizes.sm,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            SizedBox(width: 8.w),
            Text(
              'The code expires in 30 minutes',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
