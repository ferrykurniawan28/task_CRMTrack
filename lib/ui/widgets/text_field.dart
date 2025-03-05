// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:crm_track/helpers/filter.dart';
import 'package:crm_track/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTextField extends StatelessWidget {
  final bool isImportant;
  final String title;
  String? hint;
  TextEditingController? controller;

  CustomTextField({
    super.key,
    required this.isImportant,
    required this.title,
    this.controller,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (isImportant)
                Text(
                  ' *',
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
            ],
          ),
          spacerHeight(5),
          Container(
            width: double.infinity,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: isImportant
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDescriptionField extends StatelessWidget {
  final bool isImportant;
  final String title;
  String? hint;
  TextEditingController? controller;
  int legth;

  CustomDescriptionField({
    super.key,
    required this.isImportant,
    required this.title,
    this.controller,
    this.hint,
    required this.legth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '$title',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (isImportant)
                Text(
                  ' *',
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
            ],
          ),
          spacerHeight(5),
          SizedBox(
            width: double.infinity,
            child: TextField(
              maxLength: 100,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              controller: controller,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDropDown<T> extends StatefulWidget {
  final List<T> dataDropDown;
  Function(T)? onChange;
  final bool isImportant;
  final String title;
  TextEditingController? controller;
  final String Function(T) itemLabel; // Untuk menentukan teks yang ditampilkan
  final String? hint;

  CustomDropDown({
    super.key,
    required this.isImportant,
    required this.title,
    required this.dataDropDown,
    required this.itemLabel,
    this.controller,
    this.onChange,
    this.hint,
  });

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  T? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '${widget.title} ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            if (widget.isImportant)
              Text(
                '*',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
          ],
        ),
        SizedBox(height: 5),
        DropdownButtonFormField<T>(
          items: widget.dataDropDown.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child:
                  Text(widget.itemLabel(item)), // Menampilkan teks sesuai model
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedValue = value;
              widget.controller!.text = widget.itemLabel(value!);
            });
            widget.onChange!(value!);
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.isImportant
              ? (value) {
                  if (value == null) {
                    return 'This field is required';
                  }
                  return null;
                }
              : null,
          hint: Text(widget.hint ?? "Pilih opsi"),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDatePicker extends StatefulWidget {
  Function(dynamic)? onChange;
  bool isImportant;
  final String title;
  TextEditingController? controller;
  final String? Function(String?)? validator; // Validator function

  CustomDatePicker({
    super.key,
    required this.isImportant,
    required this.title,
    this.controller,
    this.onChange,
    this.validator,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  var selectedValue;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        widget.controller!.text = formatDateText(pickedDate);
      });
      widget.onChange!(pickedDate); // Pass the picked date to parent
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${widget.title} ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (widget.isImportant)
                Text(
                  '*',
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
            ],
          ),
          spacerHeight(5),
          SizedBox(
            width: double.infinity,
            child: TextFormField(
              controller: widget.controller,
              keyboardType: TextInputType.none, // Disable typing
              onTap: () => _pickDate(context),
              readOnly: true, // Disable direct typing
              validator: widget.isImportant
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    }
                  : widget.validator, // Pass the custom validator if needed
              decoration: InputDecoration(
                prefixIcon: Image.asset('assets/icon/calendar2-date.png'),
                hintText: 'DD/MM/YYYY',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
