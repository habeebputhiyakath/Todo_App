import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_manager.dart';

class AnimatedSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  AnimatedSearchBar({required this.onSearch});
  @override
  _AnimatedSearchBarState createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return AnimatedContainer(
      curve: Curves.easeIn,
      duration: Duration(milliseconds: 300),
      width: _isSearching ? 390.0 : 48,
      height: 50.0,
      alignment: _isSearching ? Alignment.centerLeft : Alignment.centerRight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80.0),
        color:
            _isSearching ? themeManager.searchIcons : themeManager.primaryColor,
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            alignment: Alignment.center,
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              size: 25,
              color: Color.fromARGB(255, 204, 202, 202),
            ),
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
                    onChanged: (value) {
                      widget.onSearch(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 146, 144, 144)),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: Colors.white),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
