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
  final _formKey = GlobalKey<FormBuilderState>();

  final AirConditionerDetailViewModel _airConditionerDetailViewModel;
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
          child: Observer(
            builder: (_) => Column(
              children: [
                ListTile(
                  title: Text("Id"),
                  subtitle: Text(_airConditionerDetailViewModel.id),
                  contentPadding: EdgeInsets.zero,
                ),
                FormBuilderSlider(
                  name: "setpoint",
                  label: "Temperatura Alvo",
                  decoration: InputDecoration(
                    labelText: "Temperatura Alvo",
                    border: InputBorder.none,
                  ),
                  onChanged: _airConditionerDetailViewModel.changeSetpoint,
                  initialValue: _airConditionerDetailViewModel.setpoint.toDouble(),
                  divisions: 40,
                  max: 30,
                  min: -10,
                  maxTextStyle: TextStyle(),
                  minTextStyle: TextStyle(),
                  textStyle: TextStyle(fontSize: 25),
                ),
                FormBuilderSlider(
                  name: "offset",
                  label: "Variação",
                  decoration: InputDecoration(
                    labelText: "Variação",
                    border: InputBorder.none,
                  ),
                  onChanged: _airConditionerDetailViewModel.changeOffset,
                  initialValue: _airConditionerDetailViewModel.offset.toDouble(),
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
                  onChanged: _airConditionerDetailViewModel.changeIsOn,
                  initialValue: _airConditionerDetailViewModel.isOn,
                ),
                FormBuilderSwitch(
                  name: "useRemote",
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  title: Text("Usar controle remoto"),
                  onChanged: _airConditionerDetailViewModel.changeUseRemote,
                  initialValue: _airConditionerDetailViewModel.useRemote,
                ),
                FormBuilderSwitch(
                  name: "useRemote",
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  title: Text("Usar controle remoto"),
                  onChanged: _airConditionerDetailViewModel.changeUseRemote,
                  initialValue: _airConditionerDetailViewModel.useRemote,
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
