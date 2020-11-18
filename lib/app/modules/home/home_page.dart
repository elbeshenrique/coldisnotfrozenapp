import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/core/stores/ar_conditioner_store.dart';
import 'package:guard_class/app/core/stores/auth_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Cold Is Not Frozen"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authStore = Modular.get<AuthStore>();
  final airConditionerStore = Modular.get<AirConditionerStore>();

  _HomePageState() {}

  Widget getMainScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Observer(
            builder: (_) => ListView.builder(
                itemCount: airConditionerStore.airConditioner != null ? 1 : 0,
                itemBuilder: (context, index) {
                  var airConditioner = airConditionerStore.airConditioner;
                  return Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    width: double.maxFinite,
                    child: Card(
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 2.0, color: Colors.green),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: airConditioner != null ? <Widget>[
                                  Text("Is ON? ${airConditioner?.isOn}"),
                                  Text("Offset ${airConditioner?.offset}"),
                                  Text("Setpoint ${airConditioner?.setpoint}"),
                                  Text("Use Remote? ${airConditioner?.useRemote}"),
                            ] : null,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
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
        child: getMainScreen(),
      ),
    );
  }
}
