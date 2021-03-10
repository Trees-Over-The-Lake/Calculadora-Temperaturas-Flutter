import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  Widget build(BuildContext ctx) {
    return MaterialApp(
      home: Temperature(),
    );
  }
}

class Temperature extends StatefulWidget {
  @override
  _TemperatureState createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  var metricasTemperatura = ['Kelvin', 'Fahrenheit', 'Reaumur', 'Rankine'];
  int index_metricas_temperatura = 0;
  double input_temperatura = 0;

  double result_calc = 0;

  Widget build(BuildContext ctx) {
    var scroll = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const Text('Unit:'),
            Slider(
              value: index_metricas_temperatura.toDouble(),
              onChanged: (value) {
                setState(() {
                  index_metricas_temperatura = value.round();
                });
              },
              min: 0,
              max: metricasTemperatura.length.toDouble() - 1,
              divisions: metricasTemperatura.length - 1,
              label: metricasTemperatura[index_metricas_temperatura],
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: input_temperatura.toString(),
              decoration: InputDecoration(labelText: 'Celsius'),
              keyboardType: TextInputType.number,
              onSaved: (value) {
                input_temperatura = double.parse(value);
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please provide a temperature!';
                } else if (double.tryParse(value) == null) {
                  return 'Please provide a valide number!';
                }

                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () => calculate(ctx), child: Text('Calculate')),
            SizedBox(
              height: 20,
            ),
            Card(
              child: Text(
                'Result = ' + result_calc.toString(),
                style: TextStyle(fontSize: 32),
              ),
            ),
          ],
        ),
      ),
    );

    var form = Form(
      key: globalKey,
      child: scroll,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Temperature"),
      ),
      body: form,
    );
  }

  void calculate(BuildContext ctx) {
    if (!globalKey.currentState.validate()) {
      return;
    }
    globalKey.currentState.save();

    setState(() {
      switch (index_metricas_temperatura) {
        case 0:
          result_calc = input_temperatura + 273.15;
          break;

        case 1:
          result_calc = (input_temperatura * 9 / 5) + 32;
          break;

        case 2:
          result_calc = input_temperatura - (input_temperatura / 5);
          break;

        case 3:
          result_calc = (input_temperatura + 273.15) * 9 / 5;
          break;

        default:
          return;
      }
    });
  }
}
