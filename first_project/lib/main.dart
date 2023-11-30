import 'package:Urbansol_App/funcoes.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:printing/printing.dart';
import 'PDFs/document.dart';
import 'package:Urbansol_App/fatorSolar.dart';

void main() {
  // Informa ao Flutter para executar o app definido em MyApp.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // MyApp configura todo o app. // Cria o estado geral (falaremos mais sobre isso depois), nomeia o app e define o tema visual e o widget "inicial", ou seja, o ponto de partida do app.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Urbansol',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  double? valor;
  double? gastosExtras = 1500;
  double? numModulos;
  String name = '';
  String local = '';
  String placas = '';
  String inversor = '';
  String garantiaPlacas = '';
  String garantiaInversor = '';
  double? consumo;
  double? preco;
  // var favorites = <WordPair>[];

  void _showPrintedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document printed successfully'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }
}
// ...

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const MyCustomForm();
        break;
      case 1:
        page = const Calculator();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                indicatorColor: const Color.fromARGB(100, 255, 179, 91),
                extended: constraints.maxWidth >= 600,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.article),
                    label: Text(
                      'Orçamento',
                      textScaleFactor: 1.3,
                    ),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.calculate),
                    label: Text(
                      'Calculadora',
                      textScaleFactor: 1.3,
                    ),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Color.fromARGB(171, 248, 215, 178),
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

// class GeneratorPage extends StatelessWidget {
//   const GeneratorPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const appTitle = 'Form Styling Demo';

//     var appState = context.watch<MyAppState>();
//     var pair = appState.current;
//     IconData icon;
//     if (appState.favorites.contains(pair)) {
//       icon = Icons.favorite;
//     } else {
//       icon = Icons.favorite_border;
//     }

//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const SizedBox(height: 10),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ElevatedButton.icon(
//                 onPressed: () {},
//                 style: TextButton.styleFrom(
//                   foregroundColor: Colors.deepOrange,
//                 ),
//                 icon: Icon(icon),
//                 label: const Text('Like'),
//               ),
//               const SizedBox(width: 10),
//               ElevatedButton.icon(
//                 onPressed: () {},
//                 style: TextButton.styleFrom(
//                   foregroundColor: Colors.deepOrange,
//                 ),
//                 icon: const Icon(Icons.navigate_next),
//                 label: const Text('Next'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  CalculatorState createState() {
    return CalculatorState();
  }
}

class CalculatorState extends State<Calculator>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double? valor = 0;
  double? numModulos = 0;
  double valorInstalacao = 0;
  String valorInstalacaoFormat = '';
  double lucro = 0;
  double valorVenda = 0;
  double? gastosExtras = 0;
  double totalGastos = 0;
  double gastosTotais = 0;
  double lucroVendedor = 0;

  void update() {
    // Atualize o valorInstalacaoFormat conforme necessário]
    if (valor != null && numModulos != null) {
      List<double> result = calGastos(numModulos!, gastosExtras, valor!);
      lucro = result[0];
      lucroVendedor = result[1];
      valorVenda = result[2];
      gastosTotais = result[3];

      var myAppState = Provider.of<MyAppState>(context, listen: false);
      myAppState.numModulos = numModulos;
      myAppState.valor = valor;
      myAppState.gastosExtras = gastosExtras;

      setState(
          () {}); // Notifique o Flutter para redesenhar a interface do usuário
    }
  }

  void initState() {
    super.initState();
    var myAppState = Provider.of<MyAppState>(context, listen: false);
    numModulos = myAppState.numModulos;
    valor = myAppState.valor;
    gastosExtras = myAppState.gastosExtras;
    update();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Valor do Equipamento',
                  ),
                  initialValue: valor?.toString(), // Define o valor inicial
                  onChanged: (value) {
                    var myAppState = valor = double.tryParse(value);
                    if (_formKey.currentState!.validate()) {
                      update(); // Atualize o valorInstalacaoFormat
                    }
                  },
                  validator: (value) {
                    if (double.tryParse(value!) == null) {
                      return 'Campo deve ser preenchido apenas com numeros';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Numero de Modulos:',
                  ),
                  initialValue: numModulos?.toString(),
                  onChanged: (value) {
                    numModulos = double.tryParse(value);
                    if (_formKey.currentState!.validate()) {
                      update(); // Atualize o valorInstalacaoFormat
                    } // Atualize o valorInstalacaoFormat
                  },
                  validator: (value) {
                    if (double.tryParse(value!) == null) {
                      return 'Campo deve ser preenchido apenas com numeros';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Gastos Extras:',
                  ),
                  initialValue: (gastosExtras!).toString(),
                  onChanged: (value) {
                    gastosExtras = double.tryParse(value);
                    if (_formKey.currentState!.validate()) {
                      update(); // Atualize o valorInstalacaoFormat
                    } // Atualize o valorInstalacaoFormat
                  },
                  validator: (value) {
                    if (double.tryParse(value!) == null) {
                      return 'Campo deve ser preenchido apenas com numeros';
                    }
                    return null;
                  },
                ),
              ),
            ]),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                RichText(
                    text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Gastos com Instalação: ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: formatCurrency(valorInstalacao),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                RichText(
                    text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Gastos extras: ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: formatCurrency(gastosExtras),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                RichText(
                    text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Gasto Total: ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: formatCurrency(gastosTotais),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                RichText(
                    text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Comissão Vendedor: ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: formatCurrency(lucroVendedor),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                RichText(
                    text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Lucro Urbansol: ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: formatCurrency(lucro),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                RichText(
                    text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Valor de venda: ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: formatCurrency(valorVenda),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = '';
  String local = '';
  String placas = '';
  String inversor = '';
  String garantiaPlacas = '';
  String garantiaInversor = '';
  double? consumo;
  double? preco;
  double geracao = 0;
  double? fatorSolar = 0;
  double kwp = 0;

  void initState() {
    super.initState();
    var myAppState = Provider.of<MyAppState>(context, listen: false);
    name = myAppState.name;
    local = myAppState.local;
    placas = myAppState.placas;
    inversor = myAppState.inversor;
    garantiaPlacas = myAppState.garantiaPlacas;
    garantiaInversor = myAppState.garantiaInversor;
    consumo = myAppState.consumo;
    preco = myAppState.preco;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Nome Completo',
                  ),
                  initialValue: name,
                  onChanged: (value) {
                    name = value;
                    var myAppState =
                        Provider.of<MyAppState>(context, listen: false);
                    myAppState.name = name;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo deve ser preenchido';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Consumo Mensal',
                  ),
                  initialValue: consumo?.toString(),
                  onChanged: (value) {
                    consumo = double.tryParse(value);
                    var myAppState =
                        Provider.of<MyAppState>(context, listen: false);
                    myAppState.consumo = consumo;
                  },
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        double.tryParse(value) == null) {
                      return 'Digite apenas numero. Ex: 730';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Localização',
                  ),
                  initialValue: local,
                  onChanged: (value) {
                    local = value;
                    var myAppState =
                        Provider.of<MyAppState>(context, listen: false);
                    myAppState.local = local;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo deve ser preenchido';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Preço',
                    helperText: "Ex: 11250.89",
                  ),
                  initialValue: preco?.toString(),
                  onChanged: (value) {
                    preco = double.tryParse(value);
                    var myAppState =
                        Provider.of<MyAppState>(context, listen: false);
                    myAppState.preco = preco;
                  },
                  validator: (value) {
                    if (value != null && double.tryParse(value) == null) {
                      return 'Digite apenas numeros. Ex: 13245.23';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Inversor',
                    helperText: "Ex: 2x Solplanet 30k-TL-G3",
                  ),
                  initialValue: inversor,
                  onChanged: (value) {
                    inversor = value;
                    var myAppState =
                        Provider.of<MyAppState>(context, listen: false);
                    myAppState.inversor = inversor;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Modulos:',
                    helperText: "Ex: Quantidade,Potência,Marca",
                  ),
                  initialValue: placas,
                  onChanged: (value) {
                    placas = value;
                    var myAppState =
                        Provider.of<MyAppState>(context, listen: false);
                    myAppState.placas = placas;
                  },
                  validator: (value) {
                    RegExp padrao = RegExp(r'^(\d+)\s*,\s*(\d+)\s*,\s*(\w+)$');

                    if (!(value == null || value.isEmpty) &&
                        !padrao.hasMatch(value)) {
                      return 'Fora do padrão [N° placas], [Potência], [Marca]';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Garantia Inversor:',
                    helperText: "Ex: 30 Anos",
                  ),
                  initialValue: garantiaInversor,
                  onChanged: (value) {
                    garantiaInversor = value;
                    var myAppState =
                        Provider.of<MyAppState>(context, listen: false);
                    myAppState.garantiaInversor = garantiaInversor;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Garantia dos Modulos:',
                    helperText:
                        "Ex: 25 Anos (Geração), 15 Anos (Defeito de Fabricação)",
                  ),
                  initialValue: garantiaPlacas,
                  onChanged: (value) {
                    garantiaPlacas = value;
                    var myAppState =
                        Provider.of<MyAppState>(context, listen: false);
                    myAppState.garantiaPlacas = garantiaPlacas;
                  },
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Wrap(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Tratamento dos dados
                            kwp = calculeKwp(placas);

                            List<String> resultado = calFatorSolar(local);
                            local = resultado[0];
                            fatorSolar = double.tryParse(resultado[1]);

                            // CAlculando Geração
                            geracao = fatorSolar! * 0.9 / 12 * kwp;

                            var garantias = gerarGarantias(
                                garantiaPlacas, garantiaInversor);
                            garantiaPlacas = garantias[0];
                            garantiaInversor = garantias[1];

                            String placasFormatadas = formatPlacas(placas);

                            if (inversor == ' ' ||
                                inversor.isEmpty ||
                                inversor == '' ||
                                inversor == null) {
                              inversor =
                                  'Solplanet / Hoymiles / Canadian / Growatt / ...';
                            }

                            List<double> result = valorPagar(geracao);
                            double valorAntes = result[0];
                            double valorDepois = result[1];
                            double valorEconomiaAnual = result[2];

                            generatePDF(
                                name,
                                local,
                                kwp,
                                consumo,
                                geracao,
                                preco,
                                garantiaPlacas,
                                garantiaInversor,
                                placasFormatadas,
                                inversor,
                                valorAntes,
                                valorDepois,
                                valorEconomiaAnual);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Documento Criado')),
                            );
                          }
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.deepOrange,
                            textStyle: const TextStyle(fontSize: 20)),
                        icon: const Icon(Icons.article),
                        label: const Text('PDF'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
