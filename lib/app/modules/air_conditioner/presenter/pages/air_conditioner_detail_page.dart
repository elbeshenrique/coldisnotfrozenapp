import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/viewmodels/air_conditioner_detail_viewmodel.dart';

class AirConditionerDetailPage extends StatefulWidget {
  final AirConditionerDetailViewModel _airConditionerConfigurationViewModel;

  AirConditionerDetailPage(this._airConditionerConfigurationViewModel, {Key key}) : super(key: key);

  @override
  _AirConditionerDetailPageState createState() {
    return _AirConditionerDetailPageState(_airConditionerConfigurationViewModel);
  }
}

class _AirConditionerDetailPageState extends State<AirConditionerDetailPage> {
  final AirConditionerDetailViewModel _airConditionerConfigurationViewModel;
  String _title;

  _AirConditionerDetailPageState(this._airConditionerConfigurationViewModel);

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
            Modular.to.pop();
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
          child: Column(
            children: [
              Observer(
                builder: (_) => ListTile(
                  title: Text("Id"),
                  subtitle: Text(_airConditionerConfigurationViewModel.id),
                ),
              ),
              Observer(
                builder: (_) => FormBuilderSlider(
                  name: "setpoint",
                  label: "Temperatura Alvo",
                  decoration: InputDecoration(
                    labelText: "Temperatura Alvo",
                    border: InputBorder.none,
                  ),
                  onChanged: _airConditionerConfigurationViewModel.changeSetpoint,
                  initialValue: _airConditionerConfigurationViewModel.setpoint.toDouble(),
                  divisions: 40,
                  max: 30,
                  min: -10,
                  maxTextStyle: TextStyle(),
                  minTextStyle: TextStyle(),
                  textStyle: TextStyle(fontSize: 25),
                ),
              ),
              Observer(
                builder: (_) => FormBuilderSlider(
                  name: "offset",
                  label: "Variação",
                  decoration: InputDecoration(
                    labelText: "Variação",
                    border: InputBorder.none,
                  ),
                  onChanged: _airConditionerConfigurationViewModel.changeOffset,
                  initialValue: _airConditionerConfigurationViewModel.offset.toDouble(),
                  divisions: 4,
                  max: 1,
                  min: 0,
                  maxTextStyle: TextStyle(),
                  minTextStyle: TextStyle(),
                  textStyle: TextStyle(fontSize: 25),
                ),
              ),
              Observer(
                builder: (_) => _switch(
                  title: "Ligar/Desligar",
                  value: _airConditionerConfigurationViewModel.isOn,
                  onChanged: _airConditionerConfigurationViewModel.changeIsOn,
                ),
              ),
              Observer(
                builder: (_) => _switch(
                  title: "Usar controle remoto",
                  value: _airConditionerConfigurationViewModel.useRemote,
                  onChanged: _airConditionerConfigurationViewModel.changeUseRemote,
                ),
              ),
            ],
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

  _switch({String title = "", bool value, void Function(bool) onChanged}) {
    return SwitchListTile(
      dense: true,
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
