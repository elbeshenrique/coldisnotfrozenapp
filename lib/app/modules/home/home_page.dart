import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/core/stores/auth_store.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/widgets/air_conditioner_list_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Cold Is Not Frozen"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authStore = Modular.get<AuthStore>();

  _HomePageState();

  @override
  initState() {
    super.initState();
  }

  _buildAppBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.title, textScaleFactor: 1.25),
          Text(_authStore?.user?.email ?? "", textScaleFactor: _authStore?.user?.email == null ? 0 : 0.6)
        ],
      ),
      actions: <Widget>[
        FlatButton(
          textTheme: ButtonTextTheme.accent,
          onPressed: _authStore.signOut,
          child: Text("SAIR"),
        ),
      ],
    );
  }

  _buildBody() {
    return AirConditionerListWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}
