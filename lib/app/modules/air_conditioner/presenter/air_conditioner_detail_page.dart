import 'package:flutter/material.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/viewmodels/air_conditioner_configuration_viewmodel.dart';

class AirConditionerDetailPage extends StatefulWidget {
  final AirConditionerConfigurationViewModel _airConditionerConfiguration;

  AirConditionerDetailPage(this._airConditionerConfiguration, {Key key}) : super(key: key);

  @override
  _AirConditionerDetailPageState createState() {
    return _AirConditionerDetailPageState(_airConditionerConfiguration);
  }
}

class _AirConditionerDetailPageState extends State<AirConditionerDetailPage> {
  final AirConditionerConfigurationViewModel _airConditionerConfiguration;

  String _title;

  _AirConditionerDetailPageState(this._airConditionerConfiguration) {
    _title = "Dispositivo";
  }

  _buildAppBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_title, textScaleFactor: 1.25)
        ],
      ),
    );
  }

  _buildBody() {
    return Column(
      children: [
        Text(_airConditionerConfiguration.id),
        Switch(
          onChanged: (bool value) {
            _airConditionerConfiguration.isOn = value;
          },
          value: _airConditionerConfiguration.isOn,
        ),
        Switch(
          onChanged: (bool value) {
            _airConditionerConfiguration.useRemote = value;
          },
          value: _airConditionerConfiguration.useRemote,
        ),
      ],
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
