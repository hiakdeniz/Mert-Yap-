import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    this.name,
    this.hintText,
    this.onEmpty,
    this.obscureText,
    this.textInputType,
    this.icon,
    this.validateFunction,
    this.onSaved,
    this.iconColor,
    this.textFieldColor,
  });

  final IconData? icon;
  final String? hintText;
  final TextInputType? textInputType;
  final Color? textFieldColor, iconColor;
  final bool? obscureText;
  final VoidCallback? validateFunction;
  final ValueChanged<String?>? onSaved;
  final String? onEmpty;
  final String? name;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            color: Colors.grey[50]),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextFormField(
            decoration: InputDecoration(
              icon: Icon(icon),
              labelText: name,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 15.0),
            ),
            validator: (val) => val!.isEmpty ? onEmpty : null,
            onSaved: onSaved,
            obscureText: obscureText!,
            keyboardType: textInputType,
          ),
        ),
      ),
    ));
  }
}
