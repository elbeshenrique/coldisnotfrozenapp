import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/core/stores/auth_store.dart';
import 'package:guard_class/app/core/stores/theme_store.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/widgets/air_conditioner_list_widget.dart';
import 'package:asuka/asuka.dart' as asuka;

class AirConditionerPage extends StatefulWidget {
  final String title;
  const AirConditionerPage({Key key, this.title = "Cold Is Not Frozen"}) : super(key: key);

  @override
  _AirConditionerPageState createState() => _AirConditionerPageState();
}

class _AirConditionerPageState extends State<AirConditionerPage> {
  final _authStore = Modular.get<AuthStore>();
  final _themeStore = Modular.get<ThemeStore>();

  _AirConditionerPageState();

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
        Observer(
          builder: (_) => Switch(
            onChanged: (bool value) {
              _themeStore.setBrightness(value ? Brightness.dark : Brightness.light);
            },
            value: _themeStore.brightness == Brightness.dark,
          ),
        ),
        FlatButton(
          textTheme: ButtonTextTheme.accent,
          onPressed: () async {
            final result = await _authStore.signOut();
            result.fold(
              (failure) {
                asuka.showSnackBar(SnackBar(content: Text(failure.message)));
              },
              (_) {
                Modular.to.pushReplacementNamed("/login");
              },
            );
          },
          child: Text("SAIR"),
        ),
      ],
    );
  }

  _buildBody() {
    return new AirConditionerListWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}
