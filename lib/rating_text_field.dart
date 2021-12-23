import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:order_trackr/rating_model.dart';
import 'package:order_trackr/size_provider.dart';
import 'package:provider/provider.dart';

class RatingTextField extends StatelessWidget {
  const RatingTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getProportionalHeight(250),
      padding: EdgeInsets.symmetric(horizontal: getProportionalWidth(16)),
      child: Consumer<RatingModel>(builder: (context, model, _) {
        return RatingInputTextField(
          initialText: model.feedback,
          onSubmitted: (feedback) {
            model.setFeedback(feedback);
          },
        );
      }),
    );
  }
}

class RatingInputTextField extends StatefulWidget {
  final String initialText;
  final Function(String) onSubmitted;
  const RatingInputTextField(
      {Key? key, required this.initialText, required this.onSubmitted})
      : super(key: key);

  @override
  State<RatingInputTextField> createState() => _RatingInputTextFieldState();
}

class _RatingInputTextFieldState extends State<RatingInputTextField> {
  String feedbackText = "";
  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: (feedback) {
          setState(() {
            feedbackText = feedback;
            widget.onSubmitted(feedbackText);
          });
        },
        style: Theme.of(context).textTheme.bodyText2,
        maxLength: 200,
        maxLines: null,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Write a feedback...",
            counterText: "${feedbackText.length.toString()}/200"),
        cursorColor: Colors.grey);
  }
}
