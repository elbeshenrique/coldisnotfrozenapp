import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_configuration.dart';
import 'package:guard_class/app/modules/air_conditioner/infra/models/air_conditioner_configuration_model.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/viewmodels/air_conditioner_detail_viewmodel.dart';
import 'package:guard_class/app/modules/air_conditioner/utils/json_serializer.dart';

class AirConditionerDetailPage extends StatefulWidget {
  final AirConditionerConfiguration _airConditionerConfigurationViewModel;

  AirConditionerDetailPage(this._airConditionerConfigurationViewModel, {Key key}) : super(key: key);

  @override
  _AirConditionerDetailPageState createState() {
    return _AirConditionerDetailPageState(_airConditionerConfigurationViewModel);
  }
}

class _AirConditionerDetailPageState extends State<AirConditionerDetailPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  final AirConditionerConfiguration _airConditionerDetailViewModel;
  String _title;

  _AirConditionerDetailPageState(this._airConditionerDetailViewModel);

  @override
  initState() {
    super.initState();
    _title = "Configuração";
  }

  _buildAppBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_title, textScaleFactor: 1.25)
        ],
      ),
      actions: [
        FlatButton(
          textTheme: ButtonTextTheme.accent,
          onPressed: () async {
            _formKey.currentState.save();
            print(_formKey.currentState.value);
            final x = JsonMapper.fromMap<AirConditionerConfigurationModel>(_formKey.currentState.value);
            print(x);
            //Modular.to.pop();
          },
          child: Text("SALVAR"),
        ),
      ],
    );
  }

  _buildBody() {
    return Form(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            initialValue: JsonMapper.toMap(_airConditionerDetailViewModel),
            child: Column(
              children: [
                FormBuilderField(
                  name: "id",
                  builder: (_) => ListTile(
                    title: Text("Id"),
                    subtitle: Text(_airConditionerDetailViewModel.id),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                FormBuilderSlider(
                  name: "setpoint",
                  label: "Temperatura Alvo",
                  decoration: InputDecoration(
                    labelText: "Temperatura Alvo",
                    border: InputBorder.none,
                  ),
                  divisions: 40,
                  max: 30,
                  min: -10,
                  maxTextStyle: TextStyle(),
                  minTextStyle: TextStyle(),
                  textStyle: TextStyle(fontSize: 25),
                  valueTransformer: (value) {
                    print(value);
                  },
                ),
                FormBuilderSlider(
                  name: "offset",
                  label: "Variação",
                  decoration: InputDecoration(
                    labelText: "Variação",
                    border: InputBorder.none,
                  ),
                  divisions: 4,
                  max: 1,
                  min: 0,
                  maxTextStyle: TextStyle(),
                  minTextStyle: TextStyle(),
                  textStyle: TextStyle(fontSize: 25),
                ),
                FormBuilderSwitch(
                  name: "isOn",
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  title: Text("Ligar/Desligar"),
                ),
                FormBuilderSwitch(
                  name: "useRemote",
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  title: Text("Usar controle remoto"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}
