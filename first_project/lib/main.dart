import 'package:Urbansol_App/funcoes.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:printing/printing.dart';
import 'PDFs/document.dart';

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
  var favorites = <WordPair>[];

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
        page = const MyCustomForm();
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
                indicatorColor: const Color.fromARGB(255, 255, 178, 102),
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
                    icon: Icon(Icons.build),
                    label: Text(
                      'teste',
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
                color: Color.fromARGB(100, 255, 178, 102),
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Styling Demo';

    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.deepOrange,
                ),
                icon: Icon(icon),
                label: const Text('Like'),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.deepOrange,
                ),
                icon: const Icon(Icons.navigate_next),
                label: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    var favorites = context.watch<MyAppState>().favorites;
    var appState = context.watch<MyAppState>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text('You have '
                '${appState.favorites.length} favorites:'),
          ),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                childAspectRatio: 400 / 80,
              ),
              children: [
                for (var favorito in favorites)
                  ListTile(
                    title: Text("$favorito"),
                    leading: IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        semanticLabel: 'Delete',
                      ),
                      color: Colors.deepOrange,
                      onPressed: () {},
                    ),
                  ),
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
  double fatorSolar = 0;
  double kwp = 0;

  List<double> n = [1, 2, 3, 4, 5, 6, 7];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Nome Completo',
                  ),
                  onChanged: (value) {
                    name = value;
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
                  onChanged: (value) {
                    consumo = double.tryParse(value);
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
                  onChanged: (value) {
                    local = value;
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
                  onChanged: (value) {
                    preco = double.tryParse(value);
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
                  onChanged: (value) {
                    inversor = value;
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
                  onChanged: (value) {
                    placas = value;
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
                  onChanged: (value) {
                    inversor = value;
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
                  onChanged: (value) {
                    inversor = value;
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
                            kwp = calculeKwp(placas);
                            print(kwp);
                            generatePDF(
                                name,
                                local,
                                kwp,
                                consumo,
                                geracao,
                                fatorSolar,
                                preco,
                                garantiaPlacas,
                                garantiaInversor,
                                placas,
                                inversor,
                                n);
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
