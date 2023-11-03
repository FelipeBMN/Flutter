import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './Bigcard.dart';

void main() {
  // Informa ao Flutter para executar o app definido em Urban_APP.
  runApp(const Urban_APP());
}

class Urban_APP extends StatelessWidget {
  // Urban_APP configura todo o app. // Cria o estado geral (falaremos mais sobre isso depois), nomeia o app e define o tema visual e o widget "inicial", ou seja, o ponto de partida do app.
  const Urban_APP({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Urban_APPState(),
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

class Urban_APPState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>[];

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  void remove(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
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
        page = const GeneratorPage();
        break;
      case 1:
        page = const Favorite();
        break;
      case 2:
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
                    icon: Icon(Icons.slideshow),
                    label: Text(
                      'Apresentação',
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

    var appState = context.watch<Urban_APPState>();
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
          BigCard(pair: pair),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.deepOrange,
                ),
                icon: Icon(icon),
                label: const Text('Like'),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  appState.getNext();
                },
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
    var favorites = context.watch<Urban_APPState>().favorites;
    var appState = context.watch<Urban_APPState>();
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
                      onPressed: () {
                        appState.remove(favorito);
                      },
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

class MyCustomForm extends StatelessWidget {
  const MyCustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nome Completo',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Consumo Mensal',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Localização',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Preço',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Inversor',
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.deepOrange,
                    ),
                    icon: const Icon(Icons.article),
                    label: const Text('Gerar PDF'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
