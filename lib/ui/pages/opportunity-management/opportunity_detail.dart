import 'package:crm_track/helpers/helpers.dart';
import 'package:crm_track/models/opportunity_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OpportunityDetail extends StatelessWidget {
  final OpportunityModel opportunity;
  const OpportunityDetail({super.key, required this.opportunity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opportunity Management'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Opportunity',
                        style:
                            TextStyle(fontSize: 10, color: Color(0xFFF9FAFB))),
                    Text(
                      opportunity.opprtunity,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                spacerHeight(12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Description',
                        style:
                            TextStyle(fontSize: 10, color: Color(0xFFF9FAFB))),
                    Text(
                      opportunity.description,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: medium,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                spacerHeight(12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Close Date',
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xFFF9FAFB))),
                          spacerHeight(4),
                          Row(
                            children: [
                              Image.asset(
                                'assets/icon/calendar2-day.png',
                                width: 16,
                                height: 16,
                                color: Colors.white,
                              ),
                              spacerWidth(4),
                              Text(
                                DateFormat('dd MMMM yyyy')
                                    .format(opportunity.closeDate),
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: medium,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Stage',
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xFFF9FAFB))),
                          spacerHeight(4),
                          Row(
                            children: [
                              Image.asset(
                                'assets/icon/bezier2.png',
                                width: 16,
                                height: 16,
                                color: Colors.white,
                              ),
                              spacerWidth(4),
                              Text(
                                opportunityStageToString(opportunity.stage),
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: medium,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          spacerHeight(12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            color: const Color(0xFFF9FAFB),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Other Detail',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
                spacerHeight(6),
                Column(
                  children: [
                    Row(
                      children: [
                        const Text('Owner',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF4D5154))),
                        const Spacer(),
                        Text(
                          opportunity.createdBy,
                          style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xFF141619),
                              fontWeight: medium),
                        )
                      ],
                    ),
                    spacerHeight(6),
                    Row(
                      children: [
                        const Text('Probability',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF4D5154))),
                        const Spacer(),
                        Text(
                          '${opportunity.probability}%',
                          style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xFF141619),
                              fontWeight: medium),
                        )
                      ],
                    ),
                    spacerHeight(6),
                    Row(
                      children: [
                        const Text('Amount',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF4D5154))),
                        const Spacer(),
                        Text(
                          NumberFormat.currency(
                                  locale: 'id', symbol: 'Rp', decimalDigits: 0)
                              .format(opportunity.amount),
                          style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xFF141619),
                              fontWeight: medium),
                        )
                      ],
                    ),
                    spacerHeight(6),
                    Row(
                      children: [
                        const Text('Type',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF4D5154))),
                        const Spacer(),
                        Text(
                          opportunityTypeToString(opportunity.type),
                          style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xFF141619),
                              fontWeight: medium),
                        )
                      ],
                    ),
                    spacerHeight(6),
                    Row(
                      children: [
                        const Text('Lead Source',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF4D5154))),
                        const Spacer(),
                        Text(
                          leadSourceToString(opportunity.leadSource),
                          style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xFF141619),
                              fontWeight: medium),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          spacerHeight(12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            color: const Color(0xFFF9FAFB),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customer Detail',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
                spacerHeight(6),
                Column(
                  children: [
                    Row(
                      children: [
                        const Text('Customer Name',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF4D5154))),
                        const Spacer(),
                        Text(
                          opportunity.customer.name,
                          style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xFF141619),
                              fontWeight: medium),
                        )
                      ],
                    ),
                    spacerHeight(6),
                    Row(
                      children: [
                        const Text('Email',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF4D5154))),
                        const Spacer(),
                        Text(
                          opportunity.customer.email,
                          style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xFF141619),
                              fontWeight: medium),
                        )
                      ],
                    ),
                    spacerHeight(6),
                    Row(
                      children: [
                        const Text('Phone',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF4D5154))),
                        const Spacer(),
                        Text(
                          opportunity.customer.phone.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xFF141619),
                              fontWeight: medium),
                        )
                      ],
                    ),
                    spacerHeight(6),
                    Row(
                      children: [
                        const Text('Job Title',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF4D5154))),
                        const Spacer(),
                        Text(
                          opportunity.customer.jobTitle,
                          style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xFF141619),
                              fontWeight: medium),
                        )
                      ],
                    ),
                    spacerHeight(6),
                    Row(
                      children: [
                        const Text('Company',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF4D5154))),
                        const Spacer(),
                        Text(
                          opportunity.customer.company,
                          style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xFF141619),
                              fontWeight: medium),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          spacerHeight(12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            color: const Color(0xFFF9FAFB),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'System Detail',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
                spacerHeight(6),
                Column(
                  children: [
                    Row(
                      children: [
                        const Text('Created By',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF4D5154))),
                        const Spacer(),
                        Text(
                          opportunity.createdBy,
                          style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xFF141619),
                              fontWeight: medium),
                        )
                      ],
                    ),
                    spacerHeight(6),
                    Row(
                      children: [
                        const Text('Last Modified By',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF4D5154))),
                        const Spacer(),
                        Text(
                          opportunity.lastModifiedBy,
                          style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xFF141619),
                              fontWeight: medium),
                        )
                      ],
                    ),
                  ],
                )
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
        child: ElevatedButton(
          onPressed: () {
            OpportunityStage newStage = opportunity.stage;
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              builder: (context) => StatefulBuilder(
                builder: (context, setState) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Update Stage',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                      spacerHeight(12),
                      const DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 2.0,
                        dashLength: 4.0,
                        dashColor: Color(0xFFDDC9A9),
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                      spacerHeight(12),
                      Column(
                        children: OpportunityStage.values.map((e) {
                          return RadioListTile<OpportunityStage>(
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            title: Text(opportunityStageToString(e)),
                            value: e,
                            groupValue: newStage,
                            onChanged: (value) {
                              setState(() {
                                newStage = value!;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                      color: primaryColor,
                                    )),
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: medium,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                          spacerWidth(12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                opportunity.stage = newStage;

                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                'Update Stage',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: medium,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(primaryColor),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          child: const Text(
            'Update Stage',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
