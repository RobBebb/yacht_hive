import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../domain/yacht.dart';

const String yachtBoxName = 'yacht';

class EditYachtScreen extends StatefulWidget {
  static const routeName = 'edityachtscreen';
  @override
  _EditYachtScreenState createState() => _EditYachtScreenState();
}

class _EditYachtScreenState extends State<EditYachtScreen> {
  final _form = GlobalKey<FormState>();

  var _imoFocusNode = FocusNode();
  var _lengthFocusNode = FocusNode();

  String yachtBoxName = 'yacht';
  int yachtIndex;

  var _initValues = {
    'name': '',
    'imo': '',
    'length': '',
  };

  var _editedYacht = Yacht(
    name: '',
    imo: null,
    length: null,
  );

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      yachtIndex = ModalRoute.of(context).settings.arguments as int;
      if (yachtIndex != null) {
        Box<Yacht> yachtBox = Hive.box<Yacht>(yachtBoxName);
        _editedYacht = yachtBox.getAt(yachtIndex);
        _initValues = {
          'name': _editedYacht.name,
          'imo': _editedYacht.imo.toString(),
          'length': _editedYacht.length.toString(),
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imoFocusNode.dispose();
    _lengthFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Box<Yacht> yachtsBox = Hive.box<Yacht>(yachtBoxName);
    if (yachtIndex != null) {
      yachtsBox.putAt(yachtIndex, _editedYacht);
    } else {
      yachtsBox.add(_editedYacht);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: <Widget>[
            Image.asset('assets/images/historic-ship-48.png'),
            SizedBox(
              width: 20,
            ),
            Text(
              'Add Yacht',
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline6.fontSize),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['name'],
                decoration: InputDecoration(labelText: 'Name'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_imoFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a name.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedYacht = Yacht(
                    name: value,
                    imo: _editedYacht.imo,
                    length: _editedYacht.length,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['imo'],
                decoration: InputDecoration(labelText: 'IMO'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _imoFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_lengthFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a imo.';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (int.parse(value) <= 0) {
                    return ' Please enter a number greater than zero.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedYacht = Yacht(
                    name: _editedYacht.name,
                    imo: int.parse(value),
                    length: _editedYacht.length,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['length'],
                decoration: InputDecoration(labelText: 'Length'),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                focusNode: _lengthFocusNode,
                onFieldSubmitted: (_) {
                  _saveForm();
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a length.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (double.parse(value) <= 0) {
                    return ' Please enter a number greater than zero.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedYacht = Yacht(
                    name: _editedYacht.name,
                    imo: _editedYacht.imo,
                    length: double.parse(value),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
