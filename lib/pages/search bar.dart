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
      width: _isSearching ? 365.0 : 48,
      height: 47.0,
      alignment: _isSearching ? Alignment.centerLeft : Alignment.centerRight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80.0), 
        color: _isSearching? Color.fromARGB(255, 43, 56, 129):Color.fromARGB(255, 39, 43, 110),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            alignment: Alignment.center,
            icon: Icon(_isSearching ? Icons.close : Icons.search,size: 25,color: Color.fromARGB(255, 204, 202, 202),),
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
                      hintText: 'Search...',hintStyle: TextStyle(color: Color.fromARGB(255, 204, 202, 202)),
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
