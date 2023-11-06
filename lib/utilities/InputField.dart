import 'package:flutter/material.dart';

// Input Box
class InputField extends StatelessWidget {
  InputField({
    this.hint,
    this.icon,
    super.key,
    required this.setData,
    this.cont,
  });

  IconData? icon;
  String? hint;
  String? text;
  Function setData;
  TextEditingController? cont;

  String? getText(){
    return text;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0xFFA4DDE0),
                offset: Offset(0,0.5),
                blurRadius: 6,
                spreadRadius: 0
            )
          ],
          borderRadius: BorderRadius.circular(40)
      ),

      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: TextField(
        controller: cont,
        onChanged: (value){
          setData(value);
        },
        decoration: InputDecoration(
          prefixIcon: Icon(icon,size: 15,),
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(width: 0,color: Colors.transparent)
          ),
          filled: true,
          fillColor: Colors.white,

        ),
      ),
    );
  }
}