import 'package:firebasewithauthentication/core/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatefulWidget {
  final String? hint;
  final String? Function(String?)? validator;
  final VoidCallback? onPressed;
  final bool secure;
  final bool isNumber;
  final Function(String?)? onSave;
  final int? maxLines;
  final int minLines;

  // final IconData? icon;
  final Widget? suffixIcon;
  final Widget? prefix, prefixIcon;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool isNext;
  final bool isReadOnly;
  final int? maxLength;
  final String? upperText;
  final String? lableText;
  final String? errorText;
  final String? suffixText;
  final bool hasLabel;
  final Color? hintColor;
  final bool isRTL;
  final double horizontalMargin;
  final double verticalMargin;
  final bool multiLine;
  final Color? fillColor;
  final Color? textColor;
  final Color? labelColor;
  final double radius;
  final String? initialValue;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final String? initialText;
  final TextEditingController? controller;
  final bool? isDropDown;
  final bool? correct;
  final bool? enableAutoValidate;
  final String? prefixSvgName;

  const CustomTextField(
      {Key? key,
        this.prefix,
        this.isNumber = false,
        this.maxLines,
        this.minLines = 1,
        this.onPressed,
        this.onSave,
        this.secure = false,
        this.hint,
        this.validator,
        this.onChanged,
        this.suffixIcon,
        this.onTap,
        this.isNext = true,
        this.maxLength,
        this.upperText,
        this.hasLabel = false,
        this.isRTL = false,
        this.hintColor = Colors.black,
        this.horizontalMargin = 0,
        this.multiLine = false,
        this.fillColor,
        this.textColor,
        this.labelColor,
        this.radius = 30,
        this.verticalMargin = 5,
        this.lableText,
        this.initialValue,
        this.prefixIcon,
        this.keyboardType = TextInputType.text,
        this.focusNode,
        this.errorText,
        this.isReadOnly = false,
        this.initialText,
        this.suffixText,
        this.controller,
        this.isDropDown,
        this.correct,
        this.enableAutoValidate,
        this.prefixSvgName})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final BorderRadius borderRadius = BorderRadius.circular(25);
  late bool _showPassword;
  late bool _isFocused;

  @override
  void initState() {
    _showPassword = widget.secure;
    _isFocused = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: widget.verticalMargin, horizontal: widget.horizontalMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.upperText != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                widget.upperText!,
                style: TextStyle(
                  color: AppStyle.lightBlackColor,
                  // fontSize: AppResponsive.isTablet(context) ? 24 : 14
                ),
              ),
            ),
          GestureDetector(
            onTap: () => widget.onTap!(),
            child: Focus(
              onFocusChange: (value) => setState(() => _isFocused = value),
              child: TextFormField(
                focusNode: widget.focusNode,
                controller: widget.initialText != null
                    ? TextEditingController(text: widget.initialText)
                    : widget.controller,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                inputFormatters: [EnglishArabicTextInputFormatter()],
                readOnly: widget.isReadOnly,
                initialValue: widget.initialValue,
                obscureText: _showPassword,
                onSaved: widget.onSave,
                onChanged: widget.onChanged,
                enableInteractiveSelection: true,
                enableSuggestions: true,
                textDirection: widget.isRTL == true ? TextDirection.ltr : null,
                maxLength: widget.maxLength,
                minLines: widget.minLines,
                textInputAction: widget.multiLine
                    ? TextInputAction.newline
                    : widget.isNext
                    ? TextInputAction.next
                    : TextInputAction.done,
                keyboardType: widget.multiLine
                    ? TextInputType.multiline
                    : widget.isNumber
                    ? TextInputType.number
                    : widget.keyboardType,
                cursorColor: AppStyle.primaryColor,
                autovalidateMode: widget.enableAutoValidate == true
                    ? AutovalidateMode.onUserInteraction
                    : null,
                validator: widget.validator,
                onTap: () {
                  if (widget.isReadOnly) {
                    widget.onTap;
                  }
                },
                maxLines: widget.maxLines ?? 1,
                enabled: widget.onTap == null,
                buildCounter: (context,
                    {required currentLength,
                      required isFocused,
                      maxLength}) =>
                null,
                style: TextStyle(
                  color: widget.textColor,
                ),
                decoration: InputDecoration(
                  filled: true,
                  errorStyle: const TextStyle(
                    height: 0,
                    color: Colors.red,
                  ),
                  errorText: widget.errorText,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    // fontSize: AppResponsive.isTablet(context) ? 20 : 12
                  ),
                  labelStyle: TextStyle(
                    color: widget.labelColor,
                    //  fontSize: AppResponsive.isTablet(context) ? 24 : 12
                  ),
                  fillColor: widget.fillColor ?? Colors.grey.withOpacity(0.1),
                  counterStyle:
                  const TextStyle(fontSize: 0, color: Colors.transparent),
                  prefix: widget.prefix,
                  prefixIcon: widget.prefixSvgName != null
                      ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SvgPicture.asset(
                      "assets/${widget.prefixSvgName!}.svg",
                    ),
                  )
                      : widget.prefixIcon,
                  suffixText: widget.suffixText,
                  suffixStyle: TextStyle(color: AppStyle.primaryColor),
                  suffixIcon: widget.isDropDown == true
                      ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SvgPicture.asset("assets/images/Path 10.svg"),
                  )
                      : widget.suffixIcon ??
                      (widget.secure
                          ? IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: !_showPassword
                            ? SvgPicture.asset(
                            "assets/images/Path 10.svg")
                            : Icon(Icons.visibility_off),
                        color: AppStyle.mainColor2,
                        // Icon(
                        //   !_showPassword
                        //       ? Icons.visibility
                        //       : Icons.visibility_off,
                        //   color: AppStyle.mainColor2,
                        //   // size: AppResponsive.isTablet(context)
                        //   //     ? 30
                        //   //     : 20,
                        // ),
                        onPressed: () => setState(
                              () => _showPassword = !_showPassword,
                        ),
                      )
                          : widget.suffixIcon),
                  hintText: widget.hint,
                  labelText: widget.lableText,
                  // contentPadding: EdgeInsets.symmetric(
                  //     horizontal: 15,
                  //     vertical: widget.maxLines == 1
                  //         ? AppResponsive.isTablet(context)
                  //         ? 15
                  //         : 10
                  //         : 15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide(
                        color: widget.correct == true
                            ? Colors.green
                            : Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EnglishArabicTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final englishPattern =
    RegExp(r'[a-zA-Z]+'); // pattern to match English text
    final arabicPattern =
    RegExp(r'[\u0600-\u06FF]+'); // pattern to match Arabic text
    final hasEnglishText = englishPattern.hasMatch(newValue.text);
    final hasArabicText = arabicPattern.hasMatch(newValue.text);

    if (hasEnglishText && hasArabicText) {
      // if the text contains both English and Arabic text, format it using RichText
      final englishMatches = englishPattern.allMatches(newValue.text);
      final arabicMatches = arabicPattern.allMatches(newValue.text);

      var children = <TextSpan>[];

      int index = 0;
      for (var match in arabicMatches) {
        // add Arabic text to children
        children.add(TextSpan(
          text: newValue.text.substring(match.start, match.end),
          style: const TextStyle(),
        ));

        // add English text to children
        if (index < englishMatches.length) {
          var englishMatch = englishMatches.elementAt(index);
          children.add(TextSpan(
            text: newValue.text.substring(englishMatch.start, englishMatch.end),
            style: const TextStyle(),
          ));
          index++;
        }
      }
      return TextEditingValue(
        text: newValue.text,
        selection: newValue.selection,
        composing: TextRange.empty,
      ).copyWith(
        text: children.isNotEmpty
            ? TextSpan(children: children).toPlainText()
            : '',
      );
    } else {
      // otherwise, just return the new value as is
      return newValue;
    }
  }
}