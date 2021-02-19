import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/adapters/air_conditioner_detail_view_model_adapter.dart';
import 'package:intl/intl.dart';

import 'package:guard_class/app/modules/air_conditioner/domain/entities/air_conditioner_item.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/controllers/ar_conditioner_list_controller.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/states/air_conditioner_states.dart';

class AirConditionerListWidget extends StatefulWidget {
  final String title;
  const AirConditionerListWidget({Key key, this.title = "Cold Is Not Frozen"}) : super(key: key);

  @override
  _AirConditionerListWidgetState createState() => _AirConditionerListWidgetState();
}

class _AirConditionerListWidgetState extends ModularState<AirConditionerListWidget, AirConditionerListController> {
  final NumberFormat _numberFormatter = NumberFormat("0.##", "pt-br");
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  // @override
  // initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
  //     _loadInitialInfos();
  //   });
  // }

  // void _loadInitialInfos() {
  //   _refreshIndicatorKey.currentState.show();
  // }

  Future<void> _fetchAndLoadAirConditionerData() {
    return controller.loadData();
  }

  _buildBasedOnState() {
    return Observer(
      builder: (_) {
        var state = controller.state;

        if (state is StartAirConditionerState) {
          return Center();
        }

        if (state is LoadingAirConditionerState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is SuccessAirConditionerState) {
          return _buildAirConditionerListView(state.list);
        }

        if (state is ErrorAirConditionerState) {
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
    String offsetText = "";
    String setpointText = "";
    String useRemoteText = "";
    String temperatureText = "";

    bool isOn = false;
    double temperature = 0;

    if (airConditionerLastLogJson != null) {
      isOnText = airConditionerLastLogJson?.isOn == true ? "Ligado" : "Desligado";
      offsetText = "${_numberFormatter.format(airConditionerLastLogJson?.offset)}ºC de variação";
      setpointText = "${_numberFormatter.format(airConditionerLastLogJson?.setpoint)}ºC de temperatura alvo";
      useRemoteText = airConditionerLastLogJson?.useRemote == true ? "Usa remoto" : "Não usa remoto";
      temperatureText = "${_numberFormatter.format(airConditionerLastLogJson?.localTemperature)}ºC";

      isOn = airConditionerLastLogJson.isOn;
      temperature = airConditionerLastLogJson.localTemperature;
    } else {
      isOnText = airConditionerConfigurationModel?.isOn == true ? "Ligar" : "Desligar";
      offsetText = "Com ${_numberFormatter.format(airConditionerConfigurationModel?.offset)}ºC de variação";
      setpointText = "Parar em ${_numberFormatter.format(airConditionerConfigurationModel?.setpoint)}ºC de temperatura";
      useRemoteText = airConditionerConfigurationModel?.useRemote == true ? "Não usar remoto" : "Usar remoto";
      temperatureText = "";
    }

    Color leftCardBorderColor = isOn ? Colors.green : Colors.red;
    Color temperatureColor = temperature <= 0 ? Colors.green : Colors.red;

    return Container(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Modular.to.pushNamed(
            "/air_conditioner/detail",
            //arguments: AirConditionerDetailViewModelAdapter().fromConfiguration(airConditionerConfigurationModel),
            arguments: airConditionerConfigurationModel,
          );
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
                        Row(
                          children: <Widget>[
                            Icon(Icons.lightbulb_outline, color: Theme.of(context).accentColor, size: 17.0),
                            SizedBox(width: 10.0),
                            Text(isOnText, style: TextStyle(fontSize: 15.0)),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            Icon(Icons.ac_unit, color: Theme.of(context).accentColor, size: 17.0),
                            SizedBox(width: 10.0),
                            Text(setpointText, style: TextStyle(fontSize: 15.0)),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            Icon(Icons.settings_ethernet, color: Theme.of(context).accentColor, size: 17.0),
                            SizedBox(width: 10.0),
                            Text(offsetText, style: TextStyle(fontSize: 15.0)),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            Icon(Icons.router, color: Theme.of(context).accentColor, size: 17.0),
                            SizedBox(width: 10.0),
                            Text(useRemoteText, style: TextStyle(fontSize: 15.0)),
                          ],
                        ),
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _fetchAndLoadAirConditionerData,
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

  Widget _buildError(AirConditionerError failure) {
    // if (error is EmptyList) {
    //   return Center(
    //     child: Text('Nada encontrado'),
    //   );
    // } else if (error is ErrorSearch) {
    //   return Center(
    //     child: Text('Erro no github'),
    //   );
    // } else {
    //   return Center(
    //     child: Text('Erro interno'),
    //   );
    // }
    return Center(
      child: Text('Erro interno: ' + failure.message),
    );
  }
}
