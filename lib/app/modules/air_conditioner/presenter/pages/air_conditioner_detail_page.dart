import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:guard_class/app/core/widgets/labeled_slider.dart';
import 'package:guard_class/app/modules/air_conditioner/domain/errors/errors.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/adapters/air_conditioner_detail_view_model_adapter.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/controllers/ar_conditioner_detail_controller.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/states/air_conditioner_detail_states.dart';
import 'package:guard_class/app/modules/air_conditioner/presenter/viewmodels/air_conditioner_detail_viewmodel.dart';

class AirConditionerDetailPage extends StatefulWidget {
  final AirConditionerDetailViewModel _airConditionerConfigurationViewModel;

  AirConditionerDetailPage(this._airConditionerConfigurationViewModel, {Key key}) : super(key: key);

  @override
  _AirConditionerDetailPageState createState() {
    return _AirConditionerDetailPageState(_airConditionerConfigurationViewModel);
  }
}

class _AirConditionerDetailPageState extends ModularState<AirConditionerDetailPage, AirConditionerDetailController> {
  final BaseAirConditionerDetailViewModelAdapter viewModelAdapter = Modular.get<BaseAirConditionerDetailViewModelAdapter>();

  final AirConditionerDetailViewModel viewModel;
  final String title;

  _AirConditionerDetailPageState(this.viewModel, {this.title = "Configuração"});

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBodyBasedOnState(),
    );
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
            controller.save(viewModel);
          },
          child: Text("SALVAR"),
        ),
      ],
    );
  }

  _buildBodyBasedOnState() {
    return Observer(
      builder: (_) {
        var state = controller.state;

        if (state is LoadingAirConditionerDetailState) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is ErrorAirConditionerDetailState) {
          return _buildError(state.error);
        }

        return _buildForm();
        ;
      },
    );
  }

  _buildForm() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Observer(
          builder: (_) => Column(
            children: [
              ListTile(
                title: Text("Id"),
                subtitle: Text(viewModel.id),
                contentPadding: EdgeInsets.zero,
              ),
              LabeledSlider(
                decoration: InputDecoration(
                  labelText: "Temperatura Alvo",
                  border: InputBorder.none,
                ),
                label: "Temperatura Alvo",
                divisions: 40,
                max: 30,
                min: -10,
                onChanged: viewModel.changeSetpoint,
                value: viewModel.setpoint,
                textStyle: TextStyle(fontSize: 25),
              ),
              LabeledSlider(
                decoration: InputDecoration(
                  labelText: "Variação",
                  border: InputBorder.none,
                ),
                label: "Variação",
                divisions: 4,
                max: 1,
                min: 0,
                onChanged: viewModel.changeOffset,
                value: viewModel.offset,
                textStyle: TextStyle(fontSize: 25),
              ),
              SwitchListTile(
                title: Text("Ligar/Desligar"),
                contentPadding: EdgeInsets.zero,
                onChanged: viewModel.changeIsOn,
                value: viewModel.isOn,
              ),
              SwitchListTile(
                title: Text("Usar controle remoto"),
                contentPadding: EdgeInsets.zero,
                onChanged: viewModel.changeUseRemote,
                value: viewModel.useRemote,
              ),
            ],
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
