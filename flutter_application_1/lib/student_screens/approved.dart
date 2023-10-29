import 'package:flutter/material.dart';
import 'package:flutter_application_1/student_screens/provider.dart';
import 'package:provider/provider.dart';

class Approved extends StatefulWidget {
  const Approved({super.key});

  @override
  State<Approved> createState() => _ApprovedState();
}

class _ApprovedState extends State<Approved> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ApprovedProposal>(context);

    final ids = provider.groupids;

    return ListView.builder(
        shrinkWrap: true,
        itemCount: ids.length,
        // itemCount: names.length,
        itemBuilder: (BuildContext context, int index) {
          return SafeArea(
            child: Column(
              children: [
                Container(child: Text(ids[index])),
              ],
            ),
          );
        });
  }
}
