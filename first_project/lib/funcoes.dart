import 'package:flutter/material.dart';

String formatPlacas(String entrada) {
  List<String> valores = entrada.split(", ").map((e) => e.trim()).toList();

  if (valores.length == 3) {
    int? valor1 = int.tryParse(valores[0]);
    int? valor2 = int.tryParse(valores[1]);
    String palavra = valores[2];
    print('entrou aqui');
    if (valor1 != null && valor2 != null) {
      String resultado = "$valor1 x $palavra $valor2 w";
      return resultado;
    }
  }
  return 'Leapton / Canadina / DAH / ...';
}

double calculeKwp(String entrada) {
  List<String> valores = entrada.split(",").map((e) => e.trim()).toList();
  double kwp = 0;
  double? valor1;
  double? valor2;

  if (valores.length == 3) {
    valor1 = double.tryParse(valores[0]);
    valor2 = double.tryParse(valores[1]);
  }

  print(valor1.toString() + ' ' + valor2.toString());

  if (valor1 is double && valor2 is double) {
    print(valor1.toString() + ' ' + valor2.toString());
    kwp = valor1 * valor2/1000;
  }

  return kwp;
}

void valorInvalido(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Valores inválidos.'),
    ),
  );
}

List<String> gerarGarantias(String garantiaPlacas, String garantiaInversor) {
  if (garantiaPlacas == null || garantiaPlacas.isEmpty) {
    garantiaPlacas =
        '15 Anos (Garantia Geração), 10 Anos (Garantia para Defeitos de Fabrica)';
  }

  if (garantiaInversor == null || garantiaInversor.isEmpty) {
    garantiaInversor = '10 Anos';
  }
  return [garantiaPlacas, garantiaInversor];
}
