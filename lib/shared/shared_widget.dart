import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';

import '../../Utilites/app_fonts/font.dart';

class CustomTitleOfBodyAuth extends StatelessWidget {
  const CustomTitleOfBodyAuth({
    required this.title,
    super.key,
    this.textAlign,
  });

  final String? title;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      overflow: TextOverflow.visible,
      textAlign: textAlign,
      title!,
     style:AppTextStyle.blackW700Size30
         .copyWith(fontSize: 20.sp, color: AppStyle.primaryColor.withValues(alpha: (1))),
    );
  }
}

class CustomTitleOfPhoneAuth extends StatelessWidget {
  const CustomTitleOfPhoneAuth({
    required this.title,
    super.key,
    this.textAlign,
  });

  final String? title;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      overflow: TextOverflow.visible,
      textAlign: textAlign,
      title!,
        style: AppTextStyle.whiteW500Size16.copyWith(
          fontSize: 30.sp,
          fontWeight: FontWeight.w800,
        )


    );
  }
}

class CustomTitleOfBodyAuthPrimary extends StatelessWidget {
  const CustomTitleOfBodyAuthPrimary({
    required this.title,
    super.key,
    this.textAlign,
  });

  final String? title;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      overflow: TextOverflow.visible,
      textAlign: TextAlign.center,
      style: AppTextStyle.blackW700Size18Roboto.copyWith(
        fontSize: 26.sp,
        color: AppStyle.primaryColor,
      ),
    );

  }
}

class CustomSubTitleOfBodyAuth extends StatelessWidget {
  const CustomSubTitleOfBodyAuth({
    super.key,
    required this.supTitle,
     this.mobile,
    this.textAlign,
    this.color,
  });

  final String? supTitle;
  final String? mobile;
  final Color? color;
  final TextAlign? textAlign;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          supTitle!,
          style: AppTextStyle.whiteW500Size16,
          textAlign: textAlign,
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Text(
            mobile??'',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color),
            textAlign: textAlign,
          ),
        ),
      ],
    );
  }
}
class CustomOtpSubTitle extends StatelessWidget {
  const CustomOtpSubTitle({
    super.key,
    required this.supTitle,
    this.mobile,
    this.textAlign,
    this.color,
  });

  final String? supTitle;
  final String? mobile;
  final Color? color;
  final TextAlign? textAlign;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          supTitle!,
          style: AppTextStyle.blackW400Size16Roboto,
          textAlign: textAlign,
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Text(
            mobile??'',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color),
            textAlign: textAlign,
          ),
        ),
      ],
    );
  }
}

class CustomLabel extends StatelessWidget {
  const CustomLabel({
    super.key,
    this.label,
  });

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label!,
      style: Theme.of(context).textTheme.labelSmall,
    );
  }
}

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {this.buttonTitle,
      super.key,
      this.onPressed,
      this.borderSideColor,
      this.backgroundColorButton,
      this.style,
      this.titleWidget,
      this.width,
        this.disableColor,
      this.height,
      this.isLoading,
      this.borderRadius, this.disableBorderColor});

  final String? buttonTitle;
  final Widget? titleWidget;
  final void Function()? onPressed;
  final Color? borderSideColor;
  final Color? disableColor;
  final Color? disableBorderColor;
  final Color? backgroundColorButton;
  final TextStyle? style;
  final double? width;
  final double? height;
  final bool? isLoading;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // Disable the button
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: disableColor ?? AppStyle.grey,
        backgroundColor: backgroundColorButton ?? AppStyle.primaryColor,
        minimumSize: Size(width ?? double.infinity, height ?? 48.h),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: onPressed == null
                ? disableBorderColor ?? AppStyle.offWhite
                : (borderSideColor ?? Colors.transparent),
          ),
          borderRadius: borderRadius ?? AppStyle.defaultBorderRadius,
        ),
      ),
      child:  buttonTitle == null
              ? titleWidget
              : Text(
                  buttonTitle!,
                  style: style ??
                      Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontFamily: AppStyle.cairoFont,
                        fontSize: 18.sp,
                          color: onPressed == null
                              ? AppStyle.white
                              : AppStyle.white),
                  textAlign: TextAlign.center,
                ),
    );
  }
}

class DefaultButtonWithIcon extends StatelessWidget {
  const DefaultButtonWithIcon(
      {required this.buttonTitle,
      super.key,
      this.onPressed,
      this.borderSideColor,
      this.backgroundColorButton,
      this.style,
      this.titleWidget,
      this.width,
      this.height,
      this.isLoading,
      required this.icon});

  final String? buttonTitle;
  final Widget? titleWidget;
  final void Function()? onPressed;
  final Color? borderSideColor;
  final Color? backgroundColorButton;
  final TextStyle? style;
  final double? width;
  final double? height;
  final bool? isLoading;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: icon!,
      onPressed: onPressed, // Disable the button
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: AppStyle.white,
        backgroundColor: backgroundColorButton ?? AppStyle.primaryColor,
        minimumSize: Size(width ?? double.infinity, height ?? 48.h),
        elevation: 1,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: onPressed == null
                ? AppStyle.offWhite
                : (borderSideColor ?? Colors.transparent),
          ),
          borderRadius: AppStyle.defaultBorderRadius,
        ),
      ),
      label:  buttonTitle == null
              ? titleWidget!
              : Text(
                  buttonTitle!,
                  style: style ??
                      Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: onPressed == null
                              ? AppStyle.greyColor
                              : AppStyle.white),
                  textAlign: TextAlign.center,
                ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final String? hintText;
  final String? counterText;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixWidgetIcon;
  final TextInputAction? textInputAction;
  final bool? password;
  final bool isUpperCase;
  final bool? enabled;
  final TextInputType? keyboardType;
  final AutovalidateMode autovalidateMode;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;
  final InputBorder? errorBorder;
  final int maxLines;
  final double? radius;
  final Color? color;
  final Color? colorBorder;
  final bool? autoCorrect;
  final TextStyle? style;
  final int? maxLength;
  final int? errorLines;
  final TextDirection? textDirection;
  final TextDirection? hintTextDirection;

  final void Function(String)? onFailedSubmit;
  final FocusNode? focusNode;
  const CustomTextFormField({
    required this.controller,
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onFailedSubmit,
    this.obscureText,
    this.hintText,
    this.inputFormatters,
    this.suffixWidgetIcon,
    this.textInputAction,
    this.counterText,
    this.password,
    this.isUpperCase = false,
    this.enabled,
    this.keyboardType,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.initialValue,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.errorBorder,
    this.maxLines = 1,
    this.errorLines = 2,
    this.maxLength,
    this.radius,
    this.color,
    this.colorBorder,
    this.autoCorrect,
    this.style, this.textDirection, this.hintTextDirection, this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(textDirection: textDirection,
      onFieldSubmitted: onFailedSubmit,
      focusNode: focusNode,
      controller: controller,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintTextDirection: hintTextDirection,
        counterText: counterText??'',
        hintText: hintText,
        hintStyle: AppTextStyle.greyW300Size12.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 12.0),
          borderSide: BorderSide(color: colorBorder ?? Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 12.0),
          borderSide: BorderSide(color: colorBorder ?? Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 12.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 12.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        filled: true,
        fillColor: color ?? Colors.white,
        contentPadding: const EdgeInsets.symmetric(
            vertical: 14, horizontal: 16), // Adjust padding for spacing
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
          height: 1, // Increases space between error text and TextFormField
        ),
        errorMaxLines: errorLines, // Ensures multi-line errors display properly
      ),
      obscureText: obscureText ?? false,
      validator: validator,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      autovalidateMode: autovalidateMode,
      initialValue: initialValue,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
      autocorrect: autoCorrect ?? false,
      enabled: enabled,
      style: style ?? AppTextStyle.blackW500Size16,
    );
  }
}
class CustomTextFormFieldPlaces extends StatelessWidget {
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final String? hintText;
  final String? counterText;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixWidgetIcon;
  final TextInputAction? textInputAction;
  final bool? password;
  final bool isUpperCase;
  final bool? enabled;
  final TextInputType? keyboardType;
  final AutovalidateMode autovalidateMode;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;
  final InputBorder? errorBorder;
  final int maxLines;
  final double? radius;
  final Color? color;
  final Color? colorBorder;
  final bool? autoCorrect;
  final TextStyle? style;
  final int? maxLength;
  final int? errorLines;
  final FocusNode? focusNode;

  final void Function(String)? onFailedSubmit;

  const CustomTextFormFieldPlaces({
    required this.controller,
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onFailedSubmit,
    this.obscureText,
    this.hintText,
    this.inputFormatters,
    this.suffixWidgetIcon,
    this.textInputAction,
    this.counterText,
    this.password,
    this.isUpperCase = false,
    this.enabled,
    this.keyboardType,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.initialValue,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.errorBorder,
    this.maxLines = 1,
    this.errorLines = 2,
    this.maxLength,
    this.radius,
    this.color,
    this.colorBorder,
    this.autoCorrect,
    this.style,
    this.focusNode,

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onFieldSubmitted: onFailedSubmit,
      controller: controller,
      maxLength: maxLength,
      decoration: InputDecoration(
        counterText: counterText??'',
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 28),
          borderSide: BorderSide(color: colorBorder ?? AppStyle.greyNewTextBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 28),
          borderSide: BorderSide(color: colorBorder ?? AppStyle.greyNewTextBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 28),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 28),
          borderSide: const BorderSide(color: Colors.red),
        ),
        filled: true,
        fillColor: color ??AppStyle.greyNewText,
        contentPadding:  EdgeInsets.symmetric(
            vertical: 12.h, horizontal: 14.w), // Adjust padding for spacing
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
          height: 1, // Increases space between error text and TextFormField
        ),
        errorMaxLines: errorLines, // Ensures multi-line errors display properly
      ),
      obscureText: obscureText ?? false,
      validator: validator,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      autovalidateMode: autovalidateMode,
      initialValue: initialValue,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
      autocorrect: autoCorrect ?? false,
      enabled: enabled,
      style: style ?? AppTextStyle.blackW500Size16,
    );
  }
}

class CustomEmailTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixWidgetIcon;
  final TextInputAction? textInputAction;
  final bool? password;
  final bool isUpperCase;
  final bool? enabled;
  final TextInputType? keyboardType;
  final AutovalidateMode autovalidateMode;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;
  final InputBorder? errorBorder;
  final int maxLines;
  final int? maxLength;
  final double? radius;
  final Color? color;
  final Color? colorBorder;
  final bool? autoCorrect;
  final TextStyle? style;

  const CustomEmailTextFormField({
    required this.controller,
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.obscureText,
    this.hintText,
    this.inputFormatters,
    this.suffixWidgetIcon,
    this.textInputAction,
    this.password,
    this.isUpperCase = false,
    this.enabled,
    this.keyboardType,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.initialValue,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.errorBorder,
    this.maxLines = 1,
    this.maxLength,
    this.radius,
    this.color,
    this.colorBorder,
    this.autoCorrect,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        minHeight: 48.h,
      ),
      child: TextFormField(
        maxLength: maxLength,
        controller: controller,
        decoration: InputDecoration(
          counterText: '',
          hintText: hintText??'',
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 8.0),
            borderSide: BorderSide(color: colorBorder ?? Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 8.0),
            borderSide: BorderSide(color: colorBorder ?? Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 8.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 8.0),
            borderSide: const BorderSide(color: Colors.red),
          ),
          filled: true,
          fillColor: color ?? Colors.white,
          contentPadding: EdgeInsets.symmetric(
              vertical: 12.h, horizontal: 16.w), // Adjust padding here
          errorStyle: AppTextStyle.greyW300Size12.copyWith(
            color: AppStyle.redErrorColor,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),

          errorMaxLines: 2, // Ensures multi-line errors fit properly
        ),
        obscureText: obscureText ?? false,
        // validator: (String? value) =>
        //     value!.isValidEmail() ? null : S.of(context).invalidEmail,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        autovalidateMode: autovalidateMode,
        initialValue: initialValue,
        onChanged: onChanged,
        readOnly: readOnly,
        onTap: onTap,
        maxLines: maxLines,
        autocorrect: autoCorrect ?? false,
        enabled: enabled,
        style: style ?? AppTextStyle.blackW500Size16,
      ),
    );
  }
}

class CustomDropDownButton<T> extends StatelessWidget {
  const CustomDropDownButton({
    super.key,
    this.value,
    this.items,
    this.onChanged,
    this.onSaved,
    this.hintText,
    this.validator,
  });

  final String? value;
  final List<T>? items;
  final void Function(String?)? onChanged, onSaved;
  final String? hintText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.people_alt_outlined,
            color: AppStyle.lightGrey,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          filled: true,
          errorStyle: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: AppStyle.redErrorColor),
          fillColor: AppStyle.offWhite.withValues(alpha: 0.33),
          border: OutlineInputBorder(
            borderRadius: AppStyle.defaultBorderRadius,
            borderSide: BorderSide(
              color: AppStyle.greyColor.withValues(alpha: 0.33),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppStyle.defaultBorderRadius,
            borderSide: BorderSide(
              color: AppStyle.primaryColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppStyle.defaultBorderRadius,
            borderSide: BorderSide(
              color: AppStyle.greyColor.withValues(alpha: 0.33),
            ),
          ),
        ),
        hint: Text(
          hintText!,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        isExpanded: true,
        icon: const Icon(Icons.arrow_drop_down),
        value: value,
        onSaved: onSaved,
        items: items
            ?.map(
              (T item) => DropdownMenuItem<String>(
                value: item.toString(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.toString(),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
        borderRadius: AppStyle.defaultBorderRadius,
        style: Theme.of(context).textTheme.labelSmall);
  }
}

class CustomTextWhereTo extends StatelessWidget {
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final String? hintText;
  final String? counterText;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixWidgetIcon;
  final TextInputAction? textInputAction;
  final bool? password;
  final bool isUpperCase;
  final bool? enabled;
  final TextInputType? keyboardType;
  final AutovalidateMode autovalidateMode;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;
  final InputBorder? errorBorder;
  final int maxLines;
  final double? radius;
  final Color? color;
  final Color? colorBorder;
  final bool? autoCorrect;
  final TextStyle? style;
  final int? maxLength;
  final int? errorLines;
  final FocusNode? focusNode;

  const CustomTextWhereTo({
    required this.controller,
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.obscureText,
    this.hintText,
    this.inputFormatters,
    this.suffixWidgetIcon,
    this.textInputAction,
    this.counterText,
    this.password,
    this.isUpperCase = false,
    this.enabled,
    this.keyboardType,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.initialValue,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.errorBorder,
    this.maxLines = 1,
    this.errorLines = 2,
    this.maxLength,
    this.radius,
    this.color,
    this.colorBorder,
    this.autoCorrect,
    this.style,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      maxLength: maxLength,
      decoration: InputDecoration(
        counterText: counterText??'',
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 8.0),
          borderSide: BorderSide(color: colorBorder ?? Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 8.0),
          borderSide: BorderSide(color: colorBorder ?? Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 8.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 8.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        filled: true,
        fillColor: color ?? Colors.white,
        contentPadding: const EdgeInsets.symmetric(
            vertical: 16, horizontal: 16), // Adjust padding for spacing
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
          height: 1.5, // Increases space between error text and TextFormField
        ),
        errorMaxLines: errorLines, // Ensures multi-line errors display properly
      ),
      obscureText: obscureText ?? false,
      validator: validator,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      autovalidateMode: autovalidateMode,
      initialValue: initialValue,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
      autocorrect: autoCorrect ?? false,
      enabled: enabled,
      style: style ?? AppTextStyle.blackW500Size16,
    );
  }
}
