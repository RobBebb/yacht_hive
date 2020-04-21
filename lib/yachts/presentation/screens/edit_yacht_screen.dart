import 'package:flutter/material.dart';

import '../../domain/yacht.dart';

class EditYachtScreen extends StatefulWidget {
  static const routeName = 'edityachtscreen';
  @override
  _EditYachtScreenState createState() => _EditYachtScreenState();
}

class _EditYachtScreenState extends State<EditYachtScreen> {
  final _form = GlobalKey<FormState>();

  var _imoFocusNode = FocusNode();

  var _initValues = {
    'name': '',
    'imo': '',
    'length': '',
  };

  var _editedYacht = Yacht(
    id: null,
    name: '',
    imo: null,
    length: null,
  );

  @override
  void dispose() {
    _imoFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Row(
          children: <Widget>[
            Image.asset('assets/images/historic-ship-48.png'),
            SizedBox(
              width: 20,
            ),
            Text(
              'Add Yacht',
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.title.fontSize),
            ),
          ],
        ),
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
                    id: _editedYacht.id,
                    name: value,
                    imo: _editedYacht.imo,
                    length: _editedYacht.length,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
