import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


 
class DatePickerDOB extends StatefulWidget
 {

  static DateTime? selectedDate;
  @override
  State<StatefulWidget> createState() {
    
    return _DatePickerDOB();
  }
}
 
class _DatePickerDOB extends State<DatePickerDOB> {
  TextEditingController dateInput = TextEditingController();


  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return TextFormField(
                  controller: dateInput,
                  
                  //editing controller of this TextField
                  decoration:  InputDecoration(
      
                  hintText: 'Enter Date',
            hintStyle: const TextStyle(color: Colors.grey),
      floatingLabelBehavior: FloatingLabelBehavior.always,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
                 borderRadius: BorderRadius.circular(25.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
      errorBorder: OutlineInputBorder(
     borderSide: const BorderSide(color: Colors.red),
     borderRadius: BorderRadius.circular(25.0),
            ),

 suffixIcon: Icon(Icons.calendar_today)
      
      ),
     
      style: TextStyle(fontSize: 10),
                  readOnly: true,
                  //set it true, so that user will not able to edit text
    
    
    
                  onTap: () async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));
        
     
    if (pickedDate != null) {
      print(
          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
    
      setState(() {
        dateInput.text =
            formattedDate; //set output date to TextField value.
    
        DatePickerDOB.selectedDate=pickedDate;
        
        print('Selected date is:$DatePickerDOB.selectedDate');
    
      });
    } 
                  },
                   textInputAction: TextInputAction.next,
    
    
       
                   validator: (value) {if (value!.isEmpty) {
      return 'This field is missing ';
    } else {
      return null;
    }
            },
                );
  }
}