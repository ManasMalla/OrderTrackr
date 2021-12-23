import 'package:flutter/material.dart';
import 'package:order_trackr/order_details_card.dart';
import 'package:order_trackr/rating_model.dart';
import 'package:order_trackr/rating_text_field.dart';
import 'package:order_trackr/size_provider.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionalHeight(470),
      child: Column(
        children: [
          SizedBox(
            height: getProportionalHeight(40),
          ),
          SizedBox(
            height: getProportionalHeight(50),
            width: double.infinity,
            child: RatingStarField(),
          ),
          SizedBox(
            height: getProportionalHeight(25),
          ),
          Container(
            height: getProportionalHeight(5),
            padding: EdgeInsets.symmetric(horizontal: getProportionalWidth(32)),
            child: Divider(),
          ),
          RatingTextField(),
          Consumer<RatingModel>(builder: (context, model, _) {
            return ClipRRect(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(getProportionalHeight(32))),
              child: SizedBox(
                height: getProportionalHeight(100),
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => getMSColor(states))),
                  onPressed: () {
                    print(
                        "Feedback: ${model.feedback} with ${model.numberOfStarsGiven} stars");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: getProportionalHeight(32)),
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}

Color getMSColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.disabled
  };
  if (!states.any(interactiveStates.contains)) {
    return Color(0xFF3d91ff);
  }
  return Colors.grey.shade700;
}
