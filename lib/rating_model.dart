import 'package:flutter/material.dart';

class RatingModel extends ChangeNotifier {
  int _numberOfStarsGiven = 0;
  String _feedback = "";
  int get numberOfStarsGiven => _numberOfStarsGiven;
  String get feedback => _feedback;

  void setFeedback(String text) {
    _feedback = text;
    notifyListeners();
  }

  void setNumberOfStars(int numbers) {
    _numberOfStarsGiven = numbers;
    notifyListeners();
  }
}
