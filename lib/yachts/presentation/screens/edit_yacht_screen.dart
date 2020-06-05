import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:yacht_hive/yachts/domain/yacht_data.dart';
import 'package:yacht_hive/yachts/domain/yacht_validator.dart';

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

  // String yachtBoxName = 'yacht';
  // int yachtIndex;
  Yacht yacht;

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
      yacht = ModalRoute.of(context).settings.arguments as Yacht;
      if (yacht != null) {
        // Box<Yacht> yachtBox = Hive.box<Yacht>(yachtBoxName);
        // _editedYacht = yachtBox.getAt(yachtIndex);
        _initValues = {
          'name': yacht.name,
          'imo': yacht.imo.toString(),
          'length': yacht.length.toString(),
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
    // Box<Yacht> yachtsBox = Hive.box<Yacht>(yachtBoxName);
    if (yacht != null) {
      // yachtsBox.putAt(yachtIndex, _editedYacht);
      Provider.of<YachtData>(context, listen: false)
          .editYacht(yacht: _editedYacht, yachtKey: yacht.key);
    } else {
      // yachtsBox.add(_editedYacht);
      Provider.of<YachtData>(context, listen: false)
          .addYacht(yacht: _editedYacht);
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
                validator: NameFieldValidator.validate,
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
                validator: ImoFieldValidator.validate,
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
                validator: LengthFieldValidator.validate,
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
