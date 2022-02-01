import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextOverFlowWidget extends StatefulWidget {

  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final double maxWidthMultiplier;
  final int maxLines;
  final bool lineClamp;


  /// maxWidthMultiplier defines max width of the container. That indicates where text overflow ellipsis begin.
  /// The default value of maxWidthMultiplier is %44 of whole screen width.

  TextOverFlowWidget({
    required this.text,
    this.style = expansionTileStyle,
    this.maxWidthMultiplier = 0.44,
    this.maxLines = 1,
    this.textAlign = TextAlign.right,
    this.overflow = TextOverflow.ellipsis,
    this.lineClamp = false,
  });

  @override
  State<TextOverFlowWidget> createState() => _TextOverFlowWidgetState();
}

class _TextOverFlowWidgetState extends State<TextOverFlowWidget> {

  // initial line clamp values
  String lineClampTitle = 'Show More';
  bool clickSwitch = true;
  bool showLineClampButton = false;
  int lineSize = 2;
  int maxLine = 50;
  int minLine = 2;


  // if line clamp true & text length is bigger than 25 character, show line clamp button
  verifyLineClamp(){
    if(widget.lineClamp){

      if(widget.text.length > 25){
        showLineClampButton = true;
      } else {
        showLineClampButton = false;
      }
      return showLineClampButton;
    } else {
      return false;
    }
  }

  // switch statement on click
  changeLineClampState(){
    if(clickSwitch){
        clickSwitch = false;
        lineClampTitle = 'Show Less';
        lineSize = maxLine;
    } else {
        clickSwitch = true;
        lineClampTitle = 'Show More';
        lineSize = minLine;
    }
    // update screen
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * widget.maxWidthMultiplier
      ),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.text,
                overflow: widget.overflow,
                style: widget.style,
                textAlign: widget.textAlign,
                maxLines: widget.lineClamp == false ? widget.maxLines : lineSize, // if line clamp false, change line size with max line parameter
              ),
              Visibility( //
                visible: verifyLineClamp(),
                child: TextButton(
                  onPressed: () {
                    changeLineClampState();
                  },
                  child: Text(lineClampTitle, style: lineClampTitleTextStyle,),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
const expansionTileStyle = TextStyle(fontSize: 12);
const lineClampTitleTextStyle = TextStyle(fontSize: 10);
