import 'package:loop/export.dart';
class MyTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool? isObSecure;
  final bool? haveLabel;
  final bool? isReadOnly;
  final double? marginBottom;
  final double? radius;
  final int? maxLines;
  final double? labelSize;
  final double? hintsize;
  final FocusNode? focusNode;
  final Color? filledColor;
  final Color? focusedFillColor;
  final bool? autoFocus;
  final Color? bordercolor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? focusBorderColor;
  final Widget? prefix;
  final Widget? suffix;
  final FontWeight? labelWeight;
  final FontWeight? hintWeight;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final double? height;
  final double? width;
  final String? Function(String?)? validator;
  final bool? showPasswordToggle;
  final bool? isPin;
  final List<TextInputFormatter>? inputFormatters;
  final String? obscuringCharacter;
  final TextStyle? style;
  final TextAlign? textAlign;

  const MyTextField({
    super.key,
    this.controller,
    this.hint,
    this.label,
    this.onChanged,
    this.isObSecure = false,
    this.marginBottom = 18.0,
    this.maxLines = 1,
    this.filledColor,
    this.focusedFillColor,
    this.hintColor,
    this.labelColor,
    this.haveLabel = true,
    this.labelSize,
    this.hintsize,
    this.prefix,
    this.suffix,
    this.autoFocus = false,
    this.labelWeight,
    this.hintWeight,
    this.keyboardType,
    this.isReadOnly = false,
    this.onTap,
    this.bordercolor,
    this.focusBorderColor,
    this.focusNode,
    this.radius = 16.0,
    this.height = 58,
    this.width,
    this.validator,
    this.showPasswordToggle = false,
    this.isPin = false,
    this.inputFormatters,
    this.obscuringCharacter = '•',
    this.style,
    this.textAlign,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isFocused = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = widget.focusNode?.hasFocus ?? false;
    });
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_onFocusChange);
    super.dispose();
  }

  Widget _buildPasswordToggle() {
    return IconButton(
      icon: Icon(
        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        color: context.hint,
        size: 20,
      ),
      onPressed: () {
        setState(() {
          _isPasswordVisible = !_isPasswordVisible;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Theme-aware colors using your theme helpers
    final defaultFilledColor = context.inputBackground;
    final defaultFocusedFillColor = context.inputBackground;
    final defaultBorderColor = context.inputBorder;
    final defaultFocusBorderColor = context.focused;
    final defaultHintColor = context.inputHint;
    final defaultLabelColor = context.hint;
    final defaultTextColor = context.text;
    final defaultErrorColor = context.error;

    return Padding(
      padding: EdgeInsets.only(bottom: widget.marginBottom ?? 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null && _isFocused)
            MyText(
              text: widget.label ?? '',
              size: widget.labelSize ?? 10,
              paddingBottom: 8,
              color: widget.labelColor ?? defaultLabelColor,
              fontFamily: AppFonts.Figtree,
              weight: widget.labelWeight ?? FontWeight.w500,
            ),
          Container(
            width: widget.width ?? double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius ?? 30.0),
              color: widget.focusedFillColor ?? defaultFocusedFillColor,
            ),
            child: TextFormField(
              focusNode: widget.focusNode,
              onTap: widget.onTap,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: widget.isPin == true
                  ? TextInputType.number
                  : widget.keyboardType,
              inputFormatters: widget.isPin == true
                  ? [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ]
                  : widget.inputFormatters,
              obscureText: (widget.isObSecure ?? false) && !_isPasswordVisible,
              obscuringCharacter: widget.obscuringCharacter ?? '•',
              textAlign: widget.textAlign ?? TextAlign.start,
              style: widget.style ?? TextStyle(
                fontSize: widget.isPin == true ? 18 : 14,
                fontWeight: widget.isPin == true ? FontWeight.bold : FontWeight.w400,
                fontFamily: AppFonts.Figtree,
                decoration: TextDecoration.none,
                color: defaultTextColor,
              ),
              maxLines: widget.maxLines ?? 1,
              readOnly: widget.isReadOnly ?? false,
              controller: widget.controller,
              autofocus: widget.autoFocus ?? false,
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onChanged: widget.onChanged,
              validator: widget.validator,
              decoration: InputDecoration(
                filled: true,
                fillColor: _isFocused
                    ? widget.focusedFillColor ?? defaultFocusedFillColor
                    : widget.filledColor ?? defaultFilledColor,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 20.0),
                  borderSide: BorderSide(
                    color: widget.focusBorderColor ?? defaultFocusBorderColor,
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 20.0),
                  borderSide: BorderSide(
                    color: _isFocused
                        ? widget.focusBorderColor ?? defaultFocusBorderColor
                        : widget.bordercolor ?? defaultBorderColor,
                    width: 1,
                  ),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: widget.prefix,
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: widget.showPasswordToggle == true
                      ? _buildPasswordToggle()
                      : widget.suffix,
                ),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                hintText: widget.hint,
                hintStyle: TextStyle(
                  fontSize: widget.hintsize ?? 14,
                  fontFamily: AppFonts.Figtree,
                  color: widget.hintColor ?? defaultHintColor,
                  fontWeight: widget.hintWeight ?? FontWeight.w400,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 20.0),
                  borderSide: BorderSide(
                    width: 1,
                    color: defaultErrorColor,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 20.0),
                  borderSide: BorderSide(
                    width: 1.5,
                    color: defaultErrorColor,
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

// ========== CONVENIENCE CONSTRUCTORS ==========

extension MyTextFieldPresets on MyTextField {
  // Email field
  static MyTextField email({
    TextEditingController? controller,
    String? hint = 'Email address',
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) => MyTextField(
    controller: controller,
    hint: hint,
    keyboardType: TextInputType.emailAddress,
    onChanged: onChanged,
    validator: validator,
    prefix: Icon(Icons.email_outlined, color: Colors.grey),
  );

  // Password field
  static MyTextField password({
    TextEditingController? controller,
    String? hint = 'Password',
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
    bool showToggle = true,
  }) => MyTextField(
    controller: controller,
    hint: hint,
    isObSecure: true,
    showPasswordToggle: showToggle,
    onChanged: onChanged,
    validator: validator,
    prefix: Icon(Icons.lock_outline, color: Colors.grey),
  );

  // Search field
  static MyTextField search({
    TextEditingController? controller,
    String? hint = 'Search...',
    ValueChanged<String>? onChanged,
  }) => MyTextField(
    controller: controller,
    hint: hint,
    onChanged: onChanged,
    prefix: Icon(Icons.search, color: Colors.grey),
  );

  // Name field
  static MyTextField name({
    TextEditingController? controller,
    String? hint = 'Full name',
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) => MyTextField(
    controller: controller,
    hint: hint,
    keyboardType: TextInputType.name,
    onChanged: onChanged,
    validator: validator,
    prefix: Icon(Icons.person_outline, color: Colors.grey),
  );

  // Phone field
  static MyTextField phone({
    TextEditingController? controller,
    String? hint = 'Phone number',
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) => MyTextField(
    controller: controller,
    hint: hint,
    keyboardType: TextInputType.phone,
    onChanged: onChanged,
    validator: validator,
    prefix: Icon(Icons.phone_outlined, color: Colors.grey),
  );

  // Multiline field
  static MyTextField multiline({
    TextEditingController? controller,
    String? hint = 'Write something...',
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
    int maxLines = 4,
  }) => MyTextField(
    controller: controller,
    hint: hint,
    maxLines: maxLines,
    keyboardType: TextInputType.multiline,
    onChanged: onChanged,
    validator: validator,
  );

  // PIN field
  static MyTextField pin({
    TextEditingController? controller,
    String? hint = '0',
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) => MyTextField(
    controller: controller,
    hint: hint,
    isPin: true,
    keyboardType: TextInputType.number,
    onChanged: onChanged,
    validator: validator,
    textAlign: TextAlign.center,
  );
}