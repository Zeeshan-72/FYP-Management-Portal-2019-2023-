import 'package:flutter/material.dart';

class ApprovedProposal extends ChangeNotifier {
  List<String> _groupids = [];
  List<String> get groupids => _groupids;

  void toggleApproval(String ids) {
    final isExist = _groupids.contains(ids);
    if (isExist) {
      _groupids.remove(ids);
    } else {
      _groupids.add(ids);
    }
    notifyListeners();
  }

  bool isExist(String ids) {
    final isExist = _groupids.contains(ids);
    return isExist;
  }

  void clearApproval() {
    _groupids = [];
    notifyListeners();
  }
}
