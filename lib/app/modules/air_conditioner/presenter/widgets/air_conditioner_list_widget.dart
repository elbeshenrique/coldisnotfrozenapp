import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/core/widgets/icon_text.dart';
import 'package:intl/intl.dart';

import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_item.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/controllers/ar_conditioner_list_controller.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/states/air_conditioner_list_states.dart';

class AirConditionerListWidget extends StatefulWidget {
  const AirConditionerListWidget({Key key}) : super(key: key);

  @override
  _AirConditionerListWidgetState createState() => _AirConditionerListWidgetState();
}

class _AirConditionerListWidgetState extends ModularState<AirConditionerListWidget, AirConditionerListController> {
  NumberFormat _numberFormatter;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
      controller.refreshIndicatorKey.currentState.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    _numberFormatter = _numberFormatter ?? Modular.get<NumberFormat>();
    return Center(
      child: RefreshIndicator(
        key: controller.refreshIndicatorKey,
        onRefresh: controller.onRefreshIndicator,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: _buildBasedOnState(),
            ),
          ],
        ),
      ),
    );
  }

  _buildBasedOnState() {
    return Observer(
      builder: (_) {
        var state = controller.state;

        if (state is SuccessAirConditionerListState) {
          return _buildAirConditionerListView(state.list);
        }

        if (state is ErrorAirConditionerListState) {
          return _buildError(state.error);
        }

        return Center();
      },
    );
  }

  Widget _buildAirConditionerListView(List<AirConditionerItem> list) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (_, index) => _buildAirConditionerListViewItem(list, index),
    );
  }

  Widget _buildAirConditionerListViewItem(List<AirConditionerItem> list, int index) {
    var airConditionerItemModel = list[index];
    var airConditionerConfigurationModel = airConditionerItemModel.configuration;
    var airConditionerLastLog = airConditionerItemModel.lastLog;
    var airConditionerLastLogJson = airConditionerItemModel.lastLogJson;

    String isOnText = "";
    String isOnSubText = "";

    String offsetText = "";
    String setpointText = "";
    String useRemoteText = "";
    String temperatureText = "";

    bool isOn = false;
    double temperature = 0;

    if (airConditionerLastLogJson != null) {
      isOnText = airConditionerLastLogJson.isOn == true ? "Ligado" : "Desligado";
      isOnSubText = "(${(airConditionerConfigurationModel.isOn == true ? "Ligar" : "Desligar")})";

      offsetText = "${_numberFormatter.format(airConditionerLastLogJson.offset)}??C de varia????o";
      setpointText = "${_numberFormatter.format(airConditionerLastLogJson.setpoint)}??C de temperatura alvo";
      useRemoteText = airConditionerLastLogJson.useRemote == true ? "Usa remoto" : "N??o usa remoto";
      temperatureText = "${_numberFormatter.format(airConditionerLastLogJson.localTemperature)}??C";

      isOn = airConditionerLastLogJson.isOn;
      temperature = airConditionerLastLogJson.localTemperature;
    } else {
      isOnText = airConditionerConfigurationModel.isOn == true ? "Ligar" : "Desligar";
      offsetText = "Com ${_numberFormatter.format(airConditionerConfigurationModel.offset)}??C de varia????o";
      setpointText = "Parar em ${_numberFormatter.format(airConditionerConfigurationModel.setpoint)}??C de temperatura";
      useRemoteText = airConditionerConfigurationModel.useRemote == true ? "N??o usar remoto" : "Usar remoto";
      temperatureText = "";
    }

    Color leftCardBorderColor = isOn ? Colors.green : Colors.red;
    Color temperatureColor = temperature <= 0 ? Colors.green : Colors.red;

    return Container(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () async {
          await controller.openDetailForResult(airConditionerConfigurationModel);
        },
        child: Card(
          elevation: 5,
          child: ClipPath(
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: leftCardBorderColor,
                    width: 5,
                  ),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(airConditionerConfigurationModel.id, style: TextStyle(fontSize: 9.0))
                          ],
                        ),
                        SizedBox(height: 10.0),
                        IconText(Icons.lightbulb_outline, isOnText),
                        SizedBox(height: 10.0),
                        IconText(Icons.ac_unit, setpointText),
                        SizedBox(height: 10.0),
                        IconText(Icons.settings_ethernet, offsetText),
                        SizedBox(height: 10.0),
                        IconText(Icons.router, useRemoteText),
                        Visibility(
                          visible: airConditionerLastLog?.createdAt != null,
                          child: Column(
                            children: [
                              SizedBox(height: 10.0),
                              Row(
                                children: <Widget>[
                                  Text(airConditionerLastLog?.createdAt?.toString() ?? "", style: TextStyle(fontSize: 9.0))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      temperatureText,
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: temperatureColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildError(AirConditionerError failure) {
    return Center(
      child: Text('Erro interno: ' + failure.message),
    );
  }
}
