import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/core/stores/ar_conditioner_store.dart';
import 'package:guard_class/app/core/stores/auth_store.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Cold Is Not Frozen"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authStore = Modular.get<AuthStore>();
  final airConditionerStore = Modular.get<AirConditionerStore>();
  final NumberFormat numberFormatter = NumberFormat("0.##", "pt-br");

  _HomePageState();

  @override
  initState() {
    super.initState();
    airConditionerStore.getConfigurationList();
  }

  Widget getMainScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Observer(
            builder: (_) => buildAirConditionerListView(context),
          ),
        ),
      ],
    );
  }

  buildAirConditionerListView(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: airConditionerStore.airConditionerConfigurationList?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        var airConditionerItemModel = airConditionerStore.airConditionerConfigurationList[index];
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
          isOnText = airConditionerLastLog?.isOn == true ? "Ligado" : "Desligado";
          offsetText = "${numberFormatter.format(airConditionerLastLog?.offset)}ºC de variação";
          setpointText = "${numberFormatter.format(airConditionerLastLog?.setpoint)}ºC de temperatura alvo";
          useRemoteText = airConditionerLastLog?.useRemote == true ? "Usa remoto" : "Não usa remoto";
          temperatureText = airConditionerLastLog != null ? "${numberFormatter.format(airConditionerLastLog?.localTemperature)}ºC" : "";

          isOn = airConditionerLastLog.isOn;
          temperature = airConditionerLastLog.localTemperature;
        } else {
          isOnText = airConditionerConfigurationModel?.isOn == true ? "Ligado" : "Desligado";
          offsetText = "${numberFormatter.format(airConditionerConfigurationModel?.offset)}ºC de variação";
          setpointText = "${numberFormatter.format(airConditionerConfigurationModel?.setpoint)}ºC de temperatura alvo";
          useRemoteText = airConditionerConfigurationModel?.useRemote == true ? "Usa remoto" : "Não usa remoto";
          temperatureText = "";
        }

        Color leftCardBorderColor = isOn ? Colors.green : Colors.red;
        Color temperatureBorderColor = temperature <= 0 ? Colors.green : Colors.red;

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
                              Icon(Icons.settings_ethernet, color: Theme.of(context).accentColor, size: 17.0),
                              SizedBox(width: 10.0),
                              Text(offsetText, style: TextStyle(fontSize: 15.0)),
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
                              Icon(Icons.router, color: Theme.of(context).accentColor, size: 17.0),
                              SizedBox(width: 10.0),
                              Text(useRemoteText, style: TextStyle(fontSize: 15.0)),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              Text(airConditionerLastLog?.createdAt?.toString() ?? "", style: TextStyle(fontSize: 9.0))
                            ],
                          ),
                        ],
                      ),
                      Text(
                        temperatureText,
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: temperatureBorderColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.title, textScaleFactor: 1.4),
            Text(authStore?.user?.email ?? "", textScaleFactor: authStore?.user?.email == null ? 0 : 0.6)
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: authStore.signOut,
            ),
          ),
        ],
      ),
      body: Center(
        child: getMainScreen(context),
      ),
    );
  }
}
