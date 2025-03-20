import 'package:flutter/material.dart';

class AppSectionHeading extends StatelessWidget {
  const AppSectionHeading({
    super.key, this.textColor, this.showActionsButton=true, required this.title, this.buttonTitle='View all', this.onPressed,
  });
  final Color? textColor;
  final bool showActionsButton;
  final String title,buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.apply(color:textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if(showActionsButton)
        TextButton(onPressed:onPressed, child: Text(buttonTitle)),
      ],
    );
  }
}
