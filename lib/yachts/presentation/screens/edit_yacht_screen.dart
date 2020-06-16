import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:yacht_hive/yachts/domain/yacht.dart';
import 'package:yacht_hive/yachts/domain/yacht_data.dart';
import 'package:yacht_hive/yachts/domain/yacht_validator.dart';

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

  Yacht yacht;

  var _initValues = {
    'id': '',
    'name': '',
    'imo': '',
    'length': '',
    'buildDate': '',
  };

  var _editedYacht = Yacht(
    id: '',
    name: '',
    imo: null,
    length: null,
    buildDate: null,
  );

  var _isInit = true;

  DateTime _dateSelected;

  _showDateTimePicker() async {
    _dateSelected = await showDatePicker(
      context: context,
      initialDate: _initValues['buildDate'] == ''
          ? DateTime.parse('20000101')
          : DateTime.parse(_initValues['buildDate']),
      // initialDate: yacht == null ? DateTime.now() : _editedYacht.buildDate,
      firstDate: DateTime(1960, 1, 1),
      lastDate: DateTime(2050, 1, 1),
    );

    _editedYacht = Yacht(
      id: _editedYacht.id,
      name: _editedYacht.name,
      imo: _editedYacht.imo,
      length: _editedYacht.length,
      buildDate: _dateSelected,
    );
    setState(() {
      _initValues['buildDate'] = _dateSelected?.toIso8601String();
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      yacht = ModalRoute.of(context).settings.arguments as Yacht;
      if (yacht != null) {
        _initValues = {
          'id': yacht.id,
          'name': yacht.name == null ? '' : yacht.name,
          'imo': yacht.imo?.toString(),
          'length': yacht.length?.toString(),
          'buildDate': yacht.buildDate?.toIso8601String(),
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
    print('_saveForm');
    final isValid = _form.currentState.validate();
    print('After calling validate');
    print('isValid $isValid');
    if (!isValid) {
      return;
    }
    print('Before save');
    _form.currentState.save();
    print('After save');
    print('Before provider');
    if (yacht != null) {
      Provider.of<YachtData>(context, listen: false)
          .editYacht(yacht: _editedYacht, id: yacht.id);
    } else {
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
              yacht == null ? 'Add Yacht' : 'Edit Yacht',
              key: Key('title'),
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline6.fontSize),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            key: Key('saveIcon'),
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
                key: Key('nameTextFormField'),
                initialValue: _initValues['name'],
                decoration: InputDecoration(labelText: 'Name'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_imoFocusNode);
                },
                validator: NameFieldValidator.validate,
                onSaved: (value) {
                  _editedYacht = Yacht(
                    id: _editedYacht.id,
                    name: value,
                    imo: _editedYacht.imo,
                    length: _editedYacht.length,
                    buildDate: _editedYacht.buildDate,
                  );
                },
              ),
              TextFormField(
                key: Key('imoTextFormField'),
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
                    id: _editedYacht.id,
                    name: _editedYacht.name,
                    imo: int.parse(value),
                    length: _editedYacht.length,
                    buildDate: _editedYacht.buildDate,
                  );
                },
              ),
              TextFormField(
                key: Key('lengthTextFormField'),
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
                    id: _editedYacht.id,
                    name: _editedYacht.name,
                    imo: _editedYacht.imo,
                    length: double.parse(value),
                    buildDate: _editedYacht.buildDate,
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _initValues['buildDate'] != ''
                      ? Text(
                          DateFormat.yMMMMd().format(
                            DateTime.parse(_initValues['buildDate']),
                          ),
                          key: Key('buildDateText'),
                        )
                      : SizedBox(width: 0.0),
                  IconButton(
                    key: Key('buildDatePicker'),
                    icon: Icon(
                      Icons.calendar_today,
                    ),
                    onPressed: () => _showDateTimePicker(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
