import 'package:ceklpse_pretest_mobiledev/app/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String value;
  final String hint;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? dropdownButtonPadding;
  final Color? borderColor;
  final void Function(String?)? onChanged;
  final List<DropdownMenuItem<String>>? items;
  
  const CustomDropdown({
    super.key, 
    required this.value,
    required this.hint,
    this.margin,
    this.dropdownButtonPadding,
    this.borderColor,
    required this.onChanged, 
    required this.items
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: widget.margin,
      decoration: BoxDecoration(
        color:  Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 2, 
          color: widget.borderColor ?? AppColors.primaryColor
        )
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          child: DropdownButton<String>(
            value: widget.value,
            padding: widget.dropdownButtonPadding,
            isExpanded: true,
            onChanged: widget.onChanged,
            items: widget.items,
            hint: Text(
              widget.hint,
              style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey[700]),
            )
          ),
        )
      ),
    );
  }
}