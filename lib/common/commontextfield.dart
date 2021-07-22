
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class CommonTextFieldWidget extends StatefulWidget {
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final String initialValue;
  final String hintText;
  final bool obscureText;
  final bool suffix;
  final controller;
  final node;
  final suffixIcon;
  final void Function(String) onChanged;
  const CommonTextFieldWidget(
      {Key key,
        this.validator,
        this.keyboardType,
        this.initialValue,
        this.hintText,
        this.obscureText,
        this.suffix ,
        this.controller,
        this.suffixIcon,
        this.node,
        this.onChanged});
  @override
  _CommonTextFieldWidgetState createState() => _CommonTextFieldWidgetState();
}
class _CommonTextFieldWidgetState extends State<CommonTextFieldWidget> {
  bool _passwordVisible = false;
  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Container(
      height: MediaQuery.of(context).size.height*0.050,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff171717), width: 1),
        color: Colors.white.withOpacity(.8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(

        cursorColor: Color(0xff171717),
        initialValue: widget.initialValue,
        autofocus: false,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        onChanged: widget.onChanged,
        style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: Color(0xff171717),
            fontSize: 15),
        obscureText: widget.suffix??false ? !_passwordVisible : false,
        validator: widget.validator,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: InputDecoration(

          isCollapsed: true,
          contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.0090,top: MediaQuery.of(context).size.height*0.015),
          hintText: widget.hintText,
          errorStyle: TextStyle(
              height: 0,
              fontSize: 0,
              color: primaryColor,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400),
          hintStyle: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
              color: Color(0xff323232).withOpacity(.4),
              fontSize: 15),
          suffixIcon: widget.suffix == true ? IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: mainColor,
              size: 25,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ) : Icon(
            widget.suffixIcon,
            color: Color(0xff171717),
            size: MediaQuery.of(context).size.height * 0.030,
          ),
          //Icon(icon,size: 15,color: blueColor,),
          border: InputBorder.none,
        ),
      ),
    );
  }
}


Color mainColor = Colors.blueAccent;
Color primaryColor = Colors.blueAccent.withOpacity(0.4);