import 'package:flutter/material.dart';
import 'package:instagramclone/utility/colors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textController;
  final String textHint;
  final bool isPass;
  final TextInputType textInputType;
  final Function onChange;
  final Function validator;
  const TextFieldInput(
      {Key? key,
      required this.textController,
      required this.textHint,
       required this.onChange,
       required this.validator,
      this.isPass = false,
      required this.textInputType,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Scaffold(
      body: SingleChildScrollView(
        child: TextFormField(
          validator: (value){},
            onChanged: (value) {},
          style: const TextStyle(color: primaryColor),
          controller: textController,
          decoration: InputDecoration(
            
              hintStyle:const TextStyle(color: secondaryColor) ,
              fillColor: Colors.grey[900],
              hintText: textHint,
              border: inputBorder,
              focusedBorder: inputBorder,
              filled:true ,
              
              enabledBorder: inputBorder,
              contentPadding: const EdgeInsets.all(10.0)),
          obscureText: isPass,
          keyboardType: textInputType,
        ),
      ),
    );
  }
}
