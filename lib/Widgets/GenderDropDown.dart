import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class GenderDropDown extends StatefulWidget {
  GenderDropDown({
    super.key,
    required FocusNode genericFocusNode,
    required TextEditingController genericController,
  })  : _inputFocusNode = genericFocusNode,
        ddController = genericController;
  final FocusNode _inputFocusNode;
  TextEditingController ddController;
  static String? selectedDropdownValue;

  @override
  State<GenderDropDown> createState() => _GenderDropDownState();
}

class _GenderDropDownState extends State<GenderDropDown> {
  String? dropdownValue;
  TextEditingController? ddController;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: Text('Select Gender'),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 25,
      elevation: 8,
      style: const TextStyle(color: Colors.black, fontSize: 10),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      validator: (value) => value == null ? 'This Field is missing' : null,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          GenderDropDown.selectedDropdownValue = dropdownValue;
          FocusScope.of(context)
              .requestFocus(widget._inputFocusNode); //Next focus is email
          //code to store data in firebase
          print('selectedDropdownValue is');
          print(GenderDropDown.selectedDropdownValue);
        });
      },
      items: <String>['Male', 'Female', 'Transgender', 'Prefer not to Respond']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
