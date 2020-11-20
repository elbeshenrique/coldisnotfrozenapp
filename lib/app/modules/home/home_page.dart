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
      itemCount: airConditionerStore.airConditioner != null ? 1 : 0,
      itemBuilder: (BuildContext context, int index) {
        var airConditioner = airConditionerStore.airConditioner;

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
                      color: Colors.green,
                      width: 5,
                    ),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.lightbulb_outline, color: Theme.of(context).accentColor, size: 17.0),
                              SizedBox(width: 10.0),
                              Text(airConditioner?.isOn == true ? "Ligado" : "Desligado", style: TextStyle(fontSize: 15.0)),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              Icon(Icons.settings_ethernet, color: Theme.of(context).accentColor, size: 17.0),
                              SizedBox(width: 10.0),
                              Text("${numberFormatter.format(airConditioner?.offset)}ºC de variação", style: TextStyle(fontSize: 15.0)),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              Icon(Icons.ac_unit, color: Theme.of(context).accentColor, size: 17.0),
                              SizedBox(width: 10.0),
                              Text("${numberFormatter.format(airConditioner?.setpoint)}ºC de temperatura alvo", style: TextStyle(fontSize: 15.0)),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              Icon(Icons.router, color: Theme.of(context).accentColor, size: 17.0),
                              SizedBox(width: 10.0),
                              Text(airConditioner?.useRemote == true ? "Usa remoto" : "Não usa remoto", style: TextStyle(fontSize: 15.0)),
                            ],
                          ),
                        ],
                      )
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
