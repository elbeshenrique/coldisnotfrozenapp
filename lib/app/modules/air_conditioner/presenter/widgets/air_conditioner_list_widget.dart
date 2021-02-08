import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/core/stores/ar_conditioner_store.dart';
import 'package:intl/intl.dart';

class AirConditionerListWidget extends StatefulWidget {
  final String title;
  const AirConditionerListWidget({Key key, this.title = "Cold Is Not Frozen"}) : super(key: key);

  @override
  _AirConditionerListWidgetState createState() => _AirConditionerListWidgetState();
}

class _AirConditionerListWidgetState extends State<AirConditionerListWidget> {
  final _airConditionerStore = Modular.get<AirConditionerStore>();
  final NumberFormat _numberFormatter = NumberFormat("0.##", "pt-br");
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  _AirConditionerListWidgetState();

  @override
  initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
      _loadInitialInfos();
    });
  }

  void _loadInitialInfos() {
    _refreshIndicatorKey.currentState.show();
  }

  Future<void> _fetchAndLoadAirConditionerData() {
    return _airConditionerStore.getConfigurationList();
  }

  _buildWidget() {
    return Center(
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _fetchAndLoadAirConditionerData,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildAirConditionerListView(),
          ],
        ),
      ),
    );
  }

  _buildAirConditionerListView() {
    return Expanded(
      child: Observer(
        builder: (_) => ListView.builder(
          shrinkWrap: true,
          itemCount: _airConditionerStore.airConditionerConfigurationList?.length ?? 0,
          itemBuilder: _buildAirConditionerListViewItem,
        ),
      ),
    );
  }

  Widget _buildAirConditionerListViewItem(BuildContext context, int index) {
    var airConditionerItemModel = _airConditionerStore.airConditionerConfigurationList[index];
    var airConditionerConfigurationModel = airConditionerItemModel.configuration;
    var airConditionerLastLog = airConditionerItemModel.lastLog;

    String isOnText;
    String offsetText;
    String setpointText;
    String useRemoteText;
    String temperatureText;

    bool isOn = false;
    double temperature = 0;

    if (airConditionerLastLog != null) {
      // isOnText = airConditionerLastLog?.isOn == true ? "Ligado" : "Desligado";
      // offsetText = "${_numberFormatter.format(airConditionerLastLog?.offset)}ºC de variação";
      // setpointText = "${_numberFormatter.format(airConditionerLastLog?.setpoint)}ºC de temperatura alvo";
      // useRemoteText = airConditionerLastLog?.useRemote == true ? "Usa remoto" : "Não usa remoto";
      // temperatureText = airConditionerLastLog != null ? "${_numberFormatter.format(airConditionerLastLog?.localTemperature)}ºC" : "";

      // isOn = airConditionerLastLog.isOn;
      // temperature = airConditionerLastLog.localTemperature;
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }
}
