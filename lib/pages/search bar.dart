import 'package:flutter/material.dart';

class AnimatedSearchBar extends StatefulWidget {
  @override
  _AnimatedSearchBarState createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.bounceIn,
      duration: Duration(milliseconds: 300),
      width: _isSearching ? 370.0 : 48,
      height: 47.0,
      alignment: _isSearching ? Alignment.centerLeft : Alignment.centerRight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80.0), // Make it a complete circle
        color: Color.fromARGB(255, 143, 178, 252),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            alignment: Alignment.center,
            icon: Icon(_isSearching ? Icons.close : Icons.search,size: 25,),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _controller.clear();
                }
              });
            },
          ),
          Expanded(
            child: _isSearching
                ? TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
