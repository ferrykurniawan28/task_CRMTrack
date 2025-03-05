// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:crm_track/constants/dummy_data.dart';
import 'package:crm_track/helpers/dash_line.dart';
import 'package:crm_track/helpers/helpers.dart';
import 'package:crm_track/models/models.dart';
import 'package:crm_track/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _categoryController = TextEditingController();
  TextEditingController _assignedController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _ccController = TextEditingController();
  TextEditingController _productController = TextEditingController();
  TextEditingController _customerController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dueDateController = TextEditingController();
  TextEditingController _reminderController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _priorityController = TextEditingController();

  late DateTime dueDate;
  late DateTime reminder;
  late TaskStatus statusData;
  late TaskPriority priorityData;
  late ProductDetail dataProduct;
  late CustomerDetail dataCustomer;
  List<String> ccData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 30, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_assignedController.text.isNotEmpty ||
                            _categoryController.text.isNotEmpty ||
                            _descriptionController.text.isNotEmpty ||
                            _dueDateController.text.isNotEmpty ||
                            _ccController.text.isNotEmpty ||
                            _customerController.text.isNotEmpty ||
                            _priorityController.text.isNotEmpty ||
                            _productController.text.isNotEmpty ||
                            _reminderController.text.isNotEmpty ||
                            _statusController.text.isNotEmpty) {
                          showDialogWidget(
                            context,
                            () {
                              Modular.to.pop();
                            },
                            'Discard',
                            'Diascard add task?',
                          );
                        } else {
                          Modular.to.pop();
                        }
                      },
                      child: Image.asset(
                        'assets/icon/arrow-left-short.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                    spacerWidth(10),
                    Text(
                      'Add a new task',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                spacerHeight(16),
                DashedLineWidget(),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      spacerHeight(16),
                      CustomDropDown(
                        itemLabel: (category) => category,
                        isImportant: true,
                        title: 'Task Category',
                        dataDropDown: category,
                        hint: 'Choose Category',
                        controller: _categoryController,
                      ),
                      spacerHeight(12),
                      CustomDropDown(
                        itemLabel: (assignor) => assignor,
                        isImportant: true,
                        title: 'Assigned To',
                        dataDropDown: assignors,
                        controller: _assignedController,
                        hint: 'Choose user',
                      ),
                      spacerHeight(12),
                      CustomDropDown(
                        isImportant: false,
                        itemLabel: (cc) => cc.first,
                        title: 'CC',
                        hint: 'Choose user',
                        dataDropDown: ccList,
                        controller: _ccController,
                        onChange: (selectedData) {
                          setState(() {
                            ccData = selectedData;
                          });
                        },
                      ),
                      spacerHeight(12),
                      CustomTextField(
                        isImportant: true,
                        title: 'Subject',
                        controller: _subjectController,
                        hint: 'Enter task subject',
                      ),
                      spacerHeight(12),
                      CustomDropDown(
                        itemLabel: (product) => product.name,
                        isImportant: false,
                        title: 'Product',
                        dataDropDown: dummyProducts,
                        controller: _productController,
                        onChange: (selectedData) {
                          setState(() {
                            dataProduct = selectedData;
                          });
                        },
                        hint: 'Choose product',
                      ),
                      spacerHeight(12),
                      CustomDropDown(
                        itemLabel: (customer) => customer.name,
                        isImportant: false,
                        title: 'Customer',
                        dataDropDown: dummyCustomers,
                        controller: _customerController,
                        onChange: (selectedDate) {
                          setState(() {
                            dataCustomer = selectedDate;
                          });
                        },
                        hint: 'Choose customer',
                      ),
                      spacerHeight(12),
                      CustomDescriptionField(
                        isImportant: false,
                        title: 'Description',
                        legth: _descriptionController.text.length,
                        controller: _descriptionController,
                      ),
                      spacerHeight(12),
                      CustomDatePicker(
                        isImportant: true,
                        title: 'Due Date',
                        controller: _dueDateController,
                        onChange: (selecteddate) {
                          setState(() {
                            dueDate = selecteddate;
                          });
                        },
                      ),
                      spacerHeight(12),
                      CustomDatePicker(
                        isImportant: false,
                        title: 'Reminder',
                        controller: _reminderController,
                        onChange: (selectedDate) {
                          setState(() {
                            reminder = selectedDate;
                          });
                        },
                      ),
                      spacerHeight(12),
                      CustomDropDown(
                        itemLabel: (status) => status.name,
                        isImportant: true,
                        title: 'Status',
                        dataDropDown: TaskStatus.values,
                        controller: _statusController,
                        onChange: (newStatus) {
                          setState(() {
                            statusData = newStatus;
                          });
                        },
                        hint: 'Choose status',
                      ),
                      spacerHeight(12),
                      CustomDropDown(
                          itemLabel: (priority) => priority.name,
                          isImportant: true,
                          title: 'Priority',
                          dataDropDown: TaskPriority.values,
                          controller: _priorityController,
                          onChange: (newPriority) {
                            setState(() {
                              priorityData = newPriority;
                            });
                          },
                          hint: 'Choose priority'),
                      spacerHeight(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (_assignedController.text.isNotEmpty ||
                                  _categoryController.text.isNotEmpty ||
                                  _descriptionController.text.isNotEmpty ||
                                  _dueDateController.text.isNotEmpty ||
                                  _ccController.text.isNotEmpty ||
                                  _customerController.text.isNotEmpty ||
                                  _priorityController.text.isNotEmpty ||
                                  _productController.text.isNotEmpty ||
                                  _reminderController.text.isNotEmpty ||
                                  _statusController.text.isNotEmpty) {
                                showDialogWidget(
                                  context,
                                  () {
                                    Modular.to.pop();
                                  },
                                  'Discard',
                                  'Diascard add task?',
                                );
                              } else {
                                Modular.to.pop();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Discard',
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                          ),
                          spacerWidth(16),
                          GestureDetector(
                            onTap: () {
                              _formKey.currentState?.validate();
                              print('VALIDATE DONE');

                              addData(
                                _subjectController.text,
                                _descriptionController.text,
                                dueDate,
                                priorityData,
                                statusData,
                                _assignedController.text,
                                ccData,
                                dataCustomer,
                                dataProduct,
                                _categoryController.text,
                              );

                              Modular.to.pop();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: primaryColor, width: 2),
                              ),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      spacerHeight(20),
                    ],
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
