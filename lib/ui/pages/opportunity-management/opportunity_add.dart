import 'package:crm_track/cubit/opportunity-management/opportunity_management_cubit.dart';
import 'package:crm_track/helpers/helpers.dart';
import 'package:crm_track/models/opportunity_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class OpportunityAdd extends StatefulWidget {
  const OpportunityAdd({super.key});

  @override
  State<OpportunityAdd> createState() => _OpportunityAddState();
}

class _OpportunityAddState extends State<OpportunityAdd> {
  final PageController _pageController = PageController();
  final _opportunityName = TextEditingController();
  final _customerName = TextEditingController();
  final _amount = TextEditingController();
  final _probability = TextEditingController();
  final _description = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _jobTitle = TextEditingController();
  final _companyName = TextEditingController();
  OpportunityType? _opportunityType;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  int _currentIndex = 0;
  DateTime? _selectedCloseDate;
  OpportunityStage? _selectedStage;
  LeadSource? _selectedSource;

  void _nextPage() {
    if (_currentIndex == 0 && _formKey1.currentState!.validate()) {
      if (_opportunityType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select opportunity type'),
          ),
        );
        return;
      }
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentIndex = 1);
    } else if (_currentIndex == 1 && _formKey2.currentState!.validate()) {
      if (_selectedCloseDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select close date'),
          ),
        );
        return;
      } else if (_selectedStage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select stage'),
          ),
        );
        return;
      } else if (_selectedSource == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select lead source'),
          ),
        );
        return;
      }
      OpportunityModel newOpportunity = OpportunityModel(
        id: '1',
        opprtunity: _opportunityName.text,
        description: _description.text,
        closeDate: _selectedCloseDate!,
        amount: int.parse(_amount.text),
        type: _opportunityType!,
        stage: _selectedStage!,
        leadSource: _selectedSource!,
        probability: int.parse(_probability.text),
        createdBy: 'Admin',
        lastModifiedBy: 'Admin',
        customer: CustomerOpportunity(
          id: 1,
          name: _customerName.text,
          email: _email.text,
          phone: int.parse(_phone.text),
          jobTitle: _jobTitle.text,
          company: _companyName.text,
        ),
      );
      BlocProvider.of<OpportunityManagementCubit>(context)
          .addOpportunity(newOpportunity);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Opportunity added successfully'),
        ),
      );
      Modular.to.pop();
    }
  }

  @override
  void dispose() {
    _opportunityName.dispose();
    _customerName.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Opportunity'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Modular.to.navigate('/opportunity-management'),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              // Use a fade transition
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: _currentIndex == 0
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    color: primaryColor,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                    fontWeight: medium,
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            spacerWidth(4),
                            Text(
                              'Project Preview',
                              style: TextStyle(
                                fontWeight: medium,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE6E6E6),
                                shape: BoxShape.circle,
                                border: Border.fromBorderSide(
                                  BorderSide(
                                    color: Color(0xFF959596),
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '2',
                                  style: TextStyle(
                                    fontWeight: medium,
                                    fontSize: 14,
                                    color: const Color(0xFFC6C7C8),
                                  ),
                                ),
                              ),
                            ),
                            spacerWidth(4),
                            Text(
                              'Project Detail',
                              style: TextStyle(
                                fontWeight: medium,
                                fontSize: 14,
                                color: const Color(0xFFE6E6E6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    color: primaryColor,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ),
                            ),
                            spacerWidth(4),
                            Text(
                              'Project Preview',
                              style: TextStyle(
                                fontWeight: medium,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '2',
                                  style: TextStyle(
                                    fontWeight: medium,
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            spacerWidth(4),
                            Text(
                              'Project Detail',
                              style: TextStyle(
                                fontWeight: medium,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(), // Disable swipe
              children: [
                ProjectOverview(
                  formKey: _formKey1,
                  opportunityNameController: _opportunityName,
                  customerNameController: _customerName,
                  opportunityType: _opportunityType,
                  onTypeChanged: (OpportunityType? type) {
                    setState(() => _opportunityType = type);
                  },
                ),
                ProjectDetail(
                  formKey: _formKey2,
                  amountController: _amount,
                  probabilityController: _probability,
                  descriptionController: _description,
                  email: _email,
                  phone: _phone,
                  jobTitle: _jobTitle,
                  companyName: _companyName,
                  closeDate: _selectedCloseDate,
                  selectStage: _selectedStage,
                  selectSource: _selectedSource,
                  onDateChanged: (DateTime date) {
                    setState(() => _selectedCloseDate = date);
                  },
                  onStageChanged: (OpportunityStage stage) {
                    setState(() => _selectedStage = stage);
                  },
                  onSourceChanged: (LeadSource source) {
                    setState(() => _selectedSource = source);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        padding: const EdgeInsets.only(
          top: 6,
          bottom: 20,
          left: 18,
          right: 18,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 8.9,
              color: Colors.black.withOpacity(0.1),
            )
          ],
        ),
        child: Row(
          children: [
            if (_currentIndex > 0)
              Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: primaryColor),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: primaryColor,
                    size: 20,
                  ),
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.all(0),
                    ),
                    minimumSize: WidgetStateProperty.all<Size>(
                      const Size(0, 0),
                    ),
                  ),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    setState(() => _currentIndex = 0);
                  },
                ),
              ),
            Expanded(
              child: ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentIndex == 0 ? 'Next' : 'Save',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    spacerWidth(8),
                    const Icon(Icons.arrow_forward_ios_outlined,
                        size: 20, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectOverview extends StatelessWidget {
  final TextEditingController opportunityNameController;
  final TextEditingController customerNameController;
  final OpportunityType? opportunityType;
  final GlobalKey<FormState> formKey;
  final Function(OpportunityType?) onTypeChanged;

  const ProjectOverview({
    super.key,
    required this.opportunityNameController,
    required this.customerNameController,
    required this.opportunityType,
    required this.formKey,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spacerHeight(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildTextField(
              label: 'Opportunity Name',
              hintText: 'Enter project opportunity name',
              controller: opportunityNameController,
              validatorMsg: 'Please enter opportunity name',
            ),
          ),
          spacerHeight(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildTextField(
              label: 'Customer Name',
              hintText: 'Enter customer',
              controller: customerNameController,
              validatorMsg: 'Please enter customer name',
            ),
          ),
          spacerHeight(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Type', style: TextStyle(fontSize: 16)),
                spacerHeight(4),
              ],
            ),
          ),
          RadioListTile<OpportunityType>(
            dense: true,
            visualDensity: VisualDensity.compact,
            title: const Text('New Business'),
            value: OpportunityType.newBusiness,
            groupValue: opportunityType,
            activeColor: primaryColor,
            onChanged: onTypeChanged,
          ),
          RadioListTile<OpportunityType>(
            dense: true,
            visualDensity: VisualDensity.compact,
            title: const Text('Existing Business'),
            value: OpportunityType.existingBusiness,
            groupValue: opportunityType,
            activeColor: primaryColor,
            onChanged: onTypeChanged,
          ),
        ],
      ),
    );
  }
}

class ProjectDetail extends StatefulWidget {
  final TextEditingController amountController;
  final TextEditingController probabilityController;
  final TextEditingController descriptionController;
  final TextEditingController email;
  final TextEditingController phone;
  final TextEditingController jobTitle;
  final TextEditingController companyName;
  final GlobalKey<FormState> formKey;
  final DateTime? closeDate;
  final OpportunityStage? selectStage;
  final LeadSource? selectSource;
  final Function(DateTime) onDateChanged;
  final Function(OpportunityStage) onStageChanged;
  final Function(LeadSource) onSourceChanged;
  const ProjectDetail({
    super.key,
    required this.amountController,
    required this.probabilityController,
    required this.descriptionController,
    required this.email,
    required this.phone,
    required this.jobTitle,
    required this.companyName,
    required this.formKey,
    required this.closeDate,
    required this.selectStage,
    required this.selectSource,
    required this.onDateChanged,
    required this.onStageChanged,
    required this.onSourceChanged,
  });

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  DateTime? _selectedCloseDate;
  LeadSource? _selectedSource;
  OpportunityStage? _selectedStage;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Amount',
                  style: TextStyle(fontSize: 16),
                ),
                spacerHeight(4),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: widget.amountController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter amount';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter amount',
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          spacerHeight(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Close Date',
                  style: TextStyle(fontSize: 16),
                ),
                spacerHeight(4),
                GestureDetector(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    ).then((value) {
                      if (value != null) {
                        widget.onDateChanged(value);
                        setState(() {
                          _selectedCloseDate = value;
                        });
                      }
                    });
                  },
                  child: Container(
                    height: 37,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE6E6E6)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color:
                              (_selectedCloseDate ?? widget.closeDate) == null
                                  ? const Color(0xFF899197)
                                  : Colors.black,
                          size: 20,
                        ),
                        spacerWidth(8),
                        Text(
                          (_selectedCloseDate ?? widget.closeDate) == null
                              ? 'DD/MM/YYYY'
                              : DateFormat('dd/MM/yyyy').format(
                                  _selectedCloseDate ?? widget.closeDate!),
                          style: TextStyle(
                              color: (_selectedCloseDate ?? widget.closeDate) ==
                                      null
                                  ? const Color(0xFF899197)
                                  : Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          spacerHeight(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Stage',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              spacerHeight(4),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: OpportunityStage.values
                          .take(OpportunityStage.values.length ~/ 2)
                          .map((stage) {
                        return RadioListTile<OpportunityStage>(
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          title: Text(opportunityStageToString(stage)),
                          value: stage,
                          groupValue: _selectedStage ?? widget.selectStage,
                          activeColor: primaryColor,
                          onChanged: (OpportunityStage? value) {
                            widget.onStageChanged(value!);
                            setState(() {
                              _selectedStage = value;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: OpportunityStage.values
                          .skip(OpportunityStage.values.length ~/ 2)
                          .map((stage) {
                        return RadioListTile<OpportunityStage>(
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          title: Text(opportunityStageToString(stage)),
                          value: stage,
                          groupValue: _selectedStage ?? widget.selectStage,
                          activeColor: primaryColor,
                          onChanged: (OpportunityStage? value) {
                            widget.onStageChanged(value!);
                            setState(() {
                              _selectedStage = value;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              )
            ],
          ),
          spacerHeight(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Probability',
                  style: TextStyle(fontSize: 16),
                ),
                spacerHeight(4),
                TextFormField(
                  controller: widget.probabilityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter probability',
                    suffixText: '%',
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter probability';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          spacerHeight(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 16),
                ),
                spacerHeight(4),
                TextFormField(
                  controller: widget.descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    // hintText: 'Enter amount',
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          spacerHeight(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Lead Source',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              spacerHeight(4),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: LeadSource.values
                          .take(LeadSource.values.length ~/ 2)
                          .map((source) {
                        return RadioListTile<LeadSource>(
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          title: Text(leadSourceToString(source)),
                          value: source,
                          activeColor: primaryColor,
                          groupValue: _selectedSource ?? widget.selectSource,
                          onChanged: (LeadSource? value) {
                            widget.onSourceChanged(value!);
                            setState(() {
                              _selectedSource = value;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: LeadSource.values
                          .skip(LeadSource.values.length ~/ 2)
                          .map((source) {
                        return RadioListTile<LeadSource>(
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          title: Text(leadSourceToString(source)),
                          value: source,
                          activeColor: primaryColor,
                          groupValue: _selectedSource ?? widget.selectSource,
                          onChanged: (LeadSource? value) {
                            widget.onSourceChanged(value!);
                            setState(() {
                              _selectedSource = value;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              )
            ],
          ),
          spacerHeight(12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: DottedLine(
              dashColor: Color(0xFFDDC9A9),
              dashGapLength: 4,
              dashLength: 4,
              lineThickness: 1,
              dashRadius: 0,
            ),
          ),
          spacerHeight(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customer Information',
                  style: TextStyle(fontSize: 16, fontWeight: medium),
                ),
                spacerHeight(8),
                _buildTextField(
                  label: 'Email',
                  hintText: 'Enter email',
                  controller: widget.email,
                  validatorMsg: 'Please enter email',
                ),
              ],
            ),
          ),
          spacerHeight(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  label: 'Phone',
                  hintText: 'Enter number',
                  controller: widget.phone,
                  validatorMsg: 'Please enter phone number',
                ),
              ],
            ),
          ),
          spacerHeight(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  label: 'Job Title',
                  hintText: 'Enter job title',
                  controller: widget.jobTitle,
                  validatorMsg: 'Please enter job title',
                ),
              ],
            ),
          ),
          spacerHeight(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  label: 'Company Name',
                  hintText: 'Enter company name',
                  controller: widget.companyName,
                  validatorMsg: 'Please enter company name',
                ),
              ],
            ),
          ),
          spacerHeight(12),
        ],
      ),
    );
  }
}

Widget _buildTextField({
  required String label,
  required String hintText,
  required TextEditingController controller,
  required String validatorMsg,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 16)),
      spacerHeight(4),
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
          ),
        ),
        validator: (value) => value!.isEmpty ? validatorMsg : null,
      ),
    ],
  );
}
