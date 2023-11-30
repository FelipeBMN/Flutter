import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatPlacas(String entrada) {
  List<String> valores = entrada.split(",").map((e) => e.trim()).toList();

  if (valores.length == 3) {
    String valor1 = valores[0];
    String valor2 = valores[1];
    String palavra = valores[2];
    print('entrou aqui');
    if (valor1 != null && valor2 != null) {
      valor1 = valor1 + 'x';
      String resultado = "$valor1 $palavra $valor2 w";
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
    kwp = valor1 * valor2 / 1000;
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

List<double> calculaN(double economia) {
  List<double> n = [1, 2, 3, 4, 5, 6, 7];
  n[0] = economia * 3;
  n[1] = economia * 8;
  n[2] = economia * 11;
  n[3] = economia * 14;
  n[4] = economia * 17;
  n[5] = economia * 20;
  n[6] = economia * 24;
  return n;
}

List<double> valorPagar(double geracao) {
  double antes = 0;
  double depois = 0;
  double economia = 0;
  double taxaEnel = 0.92;
  double iluminacaoPublica = 1.08;

  antes = geracao * taxaEnel * iluminacaoPublica;

  depois = (30 * taxaEnel + geracao / 1.5 * 0.13) * iluminacaoPublica;

  economia = (antes - depois) * 12;

  return [antes, depois, economia];
}

String formatCurrency(double? value) {
  final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  return formatter.format(value);
}

String formatKWP(double? power) {
  final KWP = NumberFormat('#,##0.0', 'pt_BR');
  return '${KWP.format(power)} kWp';
}

String formatKWH(double? power) {
  final KWH = NumberFormat('#,##0.0', 'pt_BR');
  return '${KWH.format(power)} kWh';
}

/// Calcula o lucro, o lucro do vendedor, o valor de venda e os gastos totais
/// com base nos parâmetros fornecidos.
///
/// [gastoInstalacao] é o custo de instalação.
/// [gastosExtras] são gastos adicionais.
/// [valorSistema] é o valor do sistema.
///
/// Retorna uma lista de double contendo:
/// - O lucro total
/// - O lucro do vendedor
/// - O valor de venda
/// - Os gastos totais
List<double> calGastos(
    double numModulos, double? gastosExtras, double valorSistema) {
  double valorInstalacao = numModulos * 85;
  double valorVenda = 0;
  double gastosTotais = valorSistema + gastosExtras! + valorInstalacao;
  double percentualLucroTotal = 0.42;
  double percentualLucroVendedor = 14.2857142857 / 100;
  double percentualLucro = 85.7142857143 / 100;
  double lucro = 0;
  double lucroVendedor = 0;
  double lucroTotal = 0;

  do {
    percentualLucroTotal = percentualLucroTotal + 0.005;

    valorVenda = gastosTotais / (1 - percentualLucroTotal);

    lucroTotal = valorVenda - gastosTotais;

    lucro = lucroTotal * percentualLucro;

    lucroVendedor = lucroTotal * percentualLucroVendedor;
  } while (lucro < 3000);

  return [lucro, lucroVendedor, valorVenda, gastosTotais];
}
