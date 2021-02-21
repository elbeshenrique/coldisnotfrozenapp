import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/adapters/air_conditioner_detail_view_model_adapter.dart';
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
  final BaseAirConditionerDetailViewModelAdapter viewModelAdapter = Modular.get<BaseAirConditionerDetailViewModelAdapter>();
  final AirConditionerDetailViewModel viewModel;

  String title;

  _AirConditionerDetailPageState(this.viewModel);

  @override
  initState() {
    super.initState();
    title = "Configuração";
  }

  _buildAppBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, textScaleFactor: 1.25)
        ],
      ),
      actions: [
        FlatButton(
          textTheme: ButtonTextTheme.accent,
          onPressed: () async {
            _formKey.currentState.save();
            print(_formKey.currentState.value);
            final viewModel = viewModelAdapter.fromMap(_formKey.currentState.value);
            print(viewModel);
            //Modular.to.pop();
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
          child: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            initialValue: viewModelAdapter.toMap(viewModel),
            child: Column(
              children: [
                FormBuilderField(
                  name: "id",
                  builder: (_) => ListTile(
                    title: Text("Id"),
                    subtitle: Text(viewModel.id),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                FormBuilderSlider(
                  name: "setpoint",
                  label: "Temperatura Alvo",
                  decoration: InputDecoration(
                    labelText: "Temperatura Alvo",
                    border: InputBorder.none,
                  ),
                  divisions: 40,
                  max: 30,
                  min: -10,
                  maxTextStyle: TextStyle(),
                  minTextStyle: TextStyle(),
                  textStyle: TextStyle(fontSize: 25),
                  valueTransformer: (value) {
                    print(value);
                  },
                ),
                FormBuilderSlider(
                  name: "offset",
                  label: "Variação",
                  decoration: InputDecoration(
                    labelText: "Variação",
                    border: InputBorder.none,
                  ),
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
                ),
                FormBuilderSwitch(
                  name: "useRemote",
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  title: Text("Usar controle remoto"),
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
