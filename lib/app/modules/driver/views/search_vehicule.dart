import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:flutter/material.dart';

class DropDownWithiOsBackIcon extends StatefulWidget {
  const DropDownWithiOsBackIcon({Key? key}) : super(key: key);

  @override
  _DropDownWithiOsBackIconState createState() =>
      _DropDownWithiOsBackIconState();
}

class _DropDownWithiOsBackIconState extends State<DropDownWithiOsBackIcon> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isBackPressedOrTouchedOutSide = false,
      _isDropDownOpened = false,
      _isPanDown = false,
      _navigateToPreviousScreenOnIOSBackPress = true;
  late List<String> _list;
  String _selectedItem = '';

  @override
  void initState() {
    _list = ["Abc", "DEF", "GHI", "JKL", "MNO", "PQR"];
    _selectedItem = 'Select Item';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _removeFocus,
      onPanDown: (focus) {
        _isPanDown = true;
        _removeFocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,

        /// in appBar I have added iOS back button and open and close state of drop down is work like a charm when iOS back button pressed
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: PreferredSize(
                preferredSize: Size.fromHeight(100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 30,
                      child: Container(
                          margin: EdgeInsets.only(
                            left: 8,
                          ),
                          child: IconButton(
                            color: Colors.black,
                            icon: Icon(
                              Icons.arrow_back_ios,
                            ),
                            onPressed: _onWillPop,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        right: 60,
                      ),
                      child: Text('Awesome DropDown',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                )),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 15, left: 16, right: 20),
              child: AwesomeDropDown(
                isPanDown: _isPanDown,
                dropDownList: _list,
                isBackPressedOrTouchedOutSide: _isBackPressedOrTouchedOutSide,
                selectedItem: _selectedItem,
                onDropDownItemClick: (selectedItem) {
                  _selectedItem = selectedItem;
                },
                dropStateChanged: (isOpened) {
                  _isDropDownOpened = isOpened;
                  if (!isOpened) {
                    _isBackPressedOrTouchedOutSide = false;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// this func is used to close dropDown (if open) when you tap or pandown anywhere in the screen
  /// this method is also used for iOS backPressed as mentioned in gif
  void _removeFocus() {
    if (_isDropDownOpened) {
      setState(() {
        _isBackPressedOrTouchedOutSide = true;
      });
      _navigateToPreviousScreenOnIOSBackPress = false;
    }
  }

  /// this func will call on mob backPressed and iOS back pressed
  /// if dropdown opens it will close the dropdown else it will pop the screen
  Future<bool> _onWillPop() {
    if (_scaffoldKey.currentState!.isEndDrawerOpen) {
      Navigator.of(context).pop();
      return Future.value(false);
    } else {
      if (_isDropDownOpened) {
        setState(() {
          _isBackPressedOrTouchedOutSide = true;
        });
        FocusManager.instance.primaryFocus!.unfocus();
        return Future.value(false);
      } else {
        if (_navigateToPreviousScreenOnIOSBackPress) {
          Navigator.of(context).pop();
          return Future.value(true);
        } else {
          _navigateToPreviousScreenOnIOSBackPress = true;
          return Future.value(false);
        }
      }
    }
  }
}
