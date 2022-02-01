import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatefulWidget {
  static final GlobalKey<_PageIndicator> globalKey = GlobalKey();

  PageIndicator({Key? key,required this.itemCount, required this.currentIndexCallBack}) : super(key: globalKey);
  /// that defines size of page indicator.
  final double? itemCount;

  /// Callback function that returns current index of page indicator.
  final Function currentIndexCallBack;

  @override
  _PageIndicator createState() => _PageIndicator();
}

class _PageIndicator extends State<PageIndicator> {
  int _selectedIndex = 1;
  ScrollController? _controller;


  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }


  _moveLeft() {
    // change constant to parameter to make it dynamic
    _controller!.animateTo(_controller!.offset - 60,
        curve: Curves.linear, duration: const Duration(milliseconds: 100));
  }
  _moveRight() {
    // change constant to parameter to make it dynamic
    _controller!.animateTo(_controller!.offset + 60,
        curve: Curves.linear, duration: const Duration(milliseconds: 100));
  }

  _jumpStart(){
    _controller!.animateTo(_controller!.position.minScrollExtent, curve: Curves.bounceIn, duration: Duration(milliseconds: 250));
  }
  _jumpEnd(){
    _controller!.animateTo(_controller!.position.maxScrollExtent, curve: Curves.bounceIn, duration: Duration(milliseconds: 250));
  }

  resetPageIndicator(){
    setState(() {
      _selectedIndex = 1;
      widget.currentIndexCallBack(_selectedIndex);
      _jumpStart();
    });
  }

  @override
  Widget build(BuildContext context) {
    int? _itemCount = widget.itemCount!.toInt();

    return Container(
      // color: Colors.brown,
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
              Positioned(
                bottom: 0,
                left: MediaQuery.of(context).size.width * 0.005,
                child: IconButton(
                  onPressed: () {
                    _jumpStart();
                    setState(() {
                      _selectedIndex = 1;
                      widget.currentIndexCallBack(_selectedIndex);
                    });
                  },
                  icon:  const Icon(
                    Icons.skip_previous,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: MediaQuery.of(context).size.width * 0.1,
                child: IconButton(
                  onPressed: () {
                    _moveLeft();
                    setState(() {

                      if( _selectedIndex > 1)
                        {
                          _selectedIndex = _selectedIndex - 1;
                          widget.currentIndexCallBack(_selectedIndex);
                        }
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_left,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: MediaQuery.of(context).size.width * 0.275,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Center(
                    child: ListView.builder(
                        controller: _controller,
                        scrollDirection: Axis.horizontal,
                        itemExtent: 60,
                        itemCount: _itemCount,
                        itemBuilder: (context, index) {
                          index = index+1;
                          return ListTile(
                            title: Center(
                              child: Text(
                                '$index',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            selected: index == _selectedIndex,
                            onTap: (){
                              setState(() {
                                _selectedIndex = index;
                                widget.currentIndexCallBack(_selectedIndex);
                              });
                            },
                          );
                        }),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: MediaQuery.of(context).size.width * 0.1,
                child: IconButton(
                  onPressed: () {
                    _moveRight();
                    setState(() {
                      if(_selectedIndex < _itemCount)
                        {
                          _selectedIndex = _selectedIndex + 1;
                          widget.currentIndexCallBack(_selectedIndex);
                        }
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_right,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: MediaQuery.of(context).size.width * 0.005,
                child: IconButton(
                  onPressed: () {
                    _jumpEnd();
                    setState(() {
                      _selectedIndex = _itemCount;
                      widget.currentIndexCallBack(_selectedIndex);
                    });
                  },
                  icon: const Icon(
                    Icons.skip_next,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}