import 'package:characters/characters.dart';

List<String> calFatorSolar(String local) {
  // Convertendo o nome do local para minúsculas, removendo acentos e espaços
  var normalizedInput = removeAccents(local.toLowerCase().replaceAll(' ', ''));

  // Lista de locais com seus fatores solares
  var locais = [
    ["Fortaleza, CE", 1743.8],
    ["Aldeota, Fortaleza, CE", 1745.9],
    ["Ancuri, Fortaleza, CE", 1710.5],
    ["Antônio Bezerra, Fortaleza, CE", 1710.7],
    ["Autran Nunes, Fortaleza, CE", 1699.7],
    ["Barra do Ceará, Fortaleza, CE", 1732.0],
    ["Barroso, Fortaleza, CE", 1719.3],
    ["Benfica, Fortaleza, CE", 1739.8],
    ["Bom Futuro, Fortaleza, CE", 1733.1],
    ["Cais do Porto, Fortaleza, CE", 1756.6],
    ["Cidade 2000, Fortaleza, CE", 1758.2],
    ["Cidade dos Funcionários, Fortaleza, CE", 1731.7],
    ["Cocó, Fortaleza, CE", 1760.1],
    ["Conjunto Ceará, Fortaleza, CE", 1694.7],
    ["Damas, Fortaleza, CE", 1728.7],
    ["Demócrito Rocha, Fortaleza, CE", 1719.1],
    ["Dionísio Torres, Fortaleza, CE", 1750.2],
    ["Edson Queiroz, Fortaleza, CE", 1753.1],
    ["Ellery, Fortaleza, CE", 1736.5],
    ["Fátima, Fortaleza, CE", 1736.3],
    ["Floresta, Fortaleza, CE", 1728.2],
    ["Granja Lisboa, Fortaleza, CE", 1687.5],
    ["Guajeru, Fortaleza, CE", 1727.7],
    ["Henrique Jorge, Fortaleza, CE", 1703.2],
    ["Itaperi, Fortaleza, CE", 1713.3],
    ["Jacarecanga, Fortaleza, CE", 1742.4],
    ["Jangurussu, Fortaleza, CE", 1714.5],
    ["Jardim América, Fortaleza, CE", 1733.1],
    ["Jardim Cearense, Fortaleza, CE", 1701.3],
    ["Jardim das Oliveiras, Fortaleza, CE", 1735.5],
    ["Jardim Guanabara, Fortaleza, CE", 1722.4],
    ["Joaquim Távora, Fortaleza, CE", 1740.0],
    ["José Bonifácio, Fortaleza, CE", 1741.0],
    ["Lagoa Redonda, Fortaleza, CE", 1735.8],
    ["Luciano Cavalcante, Fortaleza, CE", 1747.8],
    ["Maraponga, Fortaleza, CE", 1704.1],
    ["Messejana, Fortaleza, CE", 1721.9],
    ["Mondubim, Fortaleza, CE", 1691.0],
    ["Monte Castelo, Fortaleza, CE", 1737.0],
    ["Montese, Fortaleza, CE", 1725.3],
    ["Moura Brasil, Fortaleza, CE", 1743.2],
    ["Mucuripe, Fortaleza, CE", 1759.6],
    ["Padre Andrade, Fortaleza, CE", 1715.8],
    ["Pan Americano, Fortaleza, CE", 1721.7],
    ["Papicu, Fortaleza, CE", 1760.4],
    ["Parangaba, Fortaleza, CE", 1710.6],
    ["Parquelândia, Fortaleza, CE", 1728.6],
    ["Parque Manibura, Fortaleza, CE", 1732.8],
    ["Parque Santa Rosa, Fortaleza, CE", 1681.0],
    ["Parque São José, Fortaleza, CE", 1698.3],
    ["Passaré, Fortaleza, CE", 1712.6],
    ["Pici, Fortaleza, CE", 1717.0],
    ["Pirambu, Fortaleza, CE", 1741.5],
    ["Praia de Iracema, Fortaleza, CE", 1747.1],
    ["Praia do Futuro, Fortaleza, CE", 1751.9],
    ["Presidente Kennedy, Fortaleza, CE", 1726.0],
    ["Sabiaguaba, Fortaleza, CE", 1751.5],
    ["Salinas, Fortaleza, CE", 1741.8],
    ["Santa Rosa, Fortaleza, CE", 1636.2],
    ["São Gerardo, Fortaleza, CE", 1524.4],
    ["Serrinha, Fortaleza, CE", 1716.9],
    ["Tamandaré, Fortaleza, CE", 1714.8],
    ["Varjota, Fortaleza, CE", 1758.9],
    ["Vicente Pinzon, Fortaleza, CE", 1759.6],
    ["Vila Ellery, Fortaleza, CE", 1736.5],
    ["Vila Peri, Fortaleza, CE", 1705.3],
    ["Vila União, Fortaleza, CE", 1727.9],
    ["Vila Velha, Fortaleza, CE", 1708.5],
    ["Vila do Mar, Fortaleza, CE", 1735.0],
    ["Abaiara, CE", 1736.5],
    ["Acarape, CE", 1530.3],
    ["Acaraú, CE", 1685.4],
    ["Acopiara, CE", 1670.9],
    ["Aiuaba, CE", 1683.6],
    ["Alcântaras, CE", 1621.7],
    ["Altaneira, CE", 1731.6],
    ["Alto Santo, CE", 1687.6],
    ["Amontada, CE", 1618.4],
    ["Antonina do Norte, CE", 1674.6],
    ["Apuiarés, CE", 1577.3],
    ["Aquiraz, CE", 1746.8],
    ["Aracati, CE", 1773.1],
    ["Aracoiaba, CE", 1569.3],
    ["Ararendá, CE", 1581.5],
    ["Araripe, CE", 1676.9],
    ["Aratuba, CE", 1606.4],
    ["Arneiroz, CE", 1666.1],
    ["Assaré, CE", 1700.6],
    ["Aurora, CE", 1708.6],
    ["Baixio, CE", 1744.1],
    ["Banabuiú, CE", 1660.9],
    ["Barbalha, CE", 1730.3],
    ["Barreira, CE", 1583.7],
    ["Barro, CE", 1688.8],
    ["Barroquinha, CE", 1645.4],
    ["Baturité, CE", 1489.2],
    ["Beberibe, CE", 1773.1],
    ["Bela Cruz, CE", 1627.5],
    ["Boa Viagem, CE", 1647.8],
    ["Brejo Santo, CE", 1720.8],
    ["Camocim, CE", 1674.8],
    ["Campos Sales, CE", 1702.1],
    ["Canindé, CE", 1622.5],
    ["Capistrano, CE", 1558.9],
    ["Caridade, CE", 1614.4],
    ["Cariré, CE", 1619.4],
    ["Caririaçu, CE", 1722.0],
    ["Cariús, CE", 1691.8],
    ["Carnaubal, CE", 1733.0],
    ["Cascavel, CE", 1739.8],
    ["Catarina, CE", 1704.6],
    ["Catunda, CE", 1626.1],
    ["Caucaia, CE", 1674.2],
    ["Cedro, CE", 1725.1],
    ["Chaval, CE", 1663.3],
    ["Choró, CE", 1633.5],
    ["Chorozinho, CE", 1621.7],
    ["Coreaú, CE", 1571.4],
    ["Crateús, CE", 1650.5],
    ["Crato, CE", 1705.9],
    ["Croatá, CE", 1734.9],
    ["Cruz, CE", 1658.1],
    ["Deputado Irapuan Pinheiro, CE", 1663.8],
    ["Ererê, CE", 1716.9],
    ["Eusébio, CE", 1723.7],
    ["Farias Brito, CE", 1690.2],
    ["Forquilha, CE", 1588.5],
    ["Fortim, CE", 1779.6],
    ["Frecheirinha, CE", 1605.0],
    ["General Sampaio, CE", 1563.7],
    ["Graça, CE", 1590.4],
    ["Granja, CE", 1587.0],
    ["Granjeiro, CE", 1711.3],
    ["Groaíras, CE", 1600.1],
    ["Guaiúba, CE", 1556.6],
    ["Guaraciaba do Norte, CE", 1633.9],
    ["Guaramiranga, CE", 1546.5],
    ["Hidrolândia, CE", 1633.8],
    ["Horizonte, CE", 1663.4],
    ["Ibaretama, CE", 1632.7],
    ["Ibiapina, CE", 1650.7],
    ["Ibicuitinga, CE", 1678.5],
    ["Icapuí, CE", 1838.5],
    ["Icó, CE", 1715.7],
    ["Iguatu, CE", 1723.0],
    ["Independência, CE", 1659.9],
    ["Ipaporanga, CE", 1618.5],
    ["Ipaumirim, CE", 1747.5],
    ["Ipu, CE", 1563.9],
    ["Ipueiras, CE", 1603.8],
    ["Iracema, CE", 1710.2],
    ["Irauçuba, CE", 1622.7],
    ["Itaiçaba, CE", 1690.0],
    ["Itaitinga, CE", 1634.6],
    ["Itapagé, CE", 1535.2],
    ["Itapipoca, CE", 1617.5],
    ["Itapiúna, CE", 1588.9],
    ["Itarema, CE", 1733.4],
    ["Itatira, CE", 1620.3],
    ["Jaguaretama, CE", 1748.6],
    ["Jaguaribara, CE", 1711.4],
    ["Jaguaribe, CE", 1715.7],
    ["Jaguaruana, CE", 1670.4],
    ["Jardim, CE", 1656.9],
    ["Jati, CE", 1646.2],
    ["Jijoca de Jericoacoara, CE", 1645.0],
    ["Juazeiro do Norte, CE", 1735.7],
    ["Jucás, CE", 1691.4],
    ["Lavras da Mangabeira, CE", 1721.0],
    ["Limoeiro do Norte, CE", 1667.5],
    ["Madalena, CE", 1613.1],
    ["Maracanaú, CE", 1649.1],
    ["Maranguape, CE", 1547.2],
    ["Marco, CE", 1621.2],
    ["Martinópole, CE", 1612.4],
    ["Massapê, CE", 1590.5],
    ["Mauriti, CE", 1706.8],
    ["Meruoca, CE", 1625.1],
    ["Milagres, CE", 1716.2],
    ["Milhã, CE", 1680.2],
    ["Miraíma, CE", 1585.1],
    ["Missão Velha, CE", 1719.0],
    ["Mombaça, CE", 1654.1],
    ["Monsenhor Tabosa, CE", 1613.2],
    ["Morada Nova, CE", 1700.6],
    ["Moraújo, CE", 1612.4],
    ["Morrinhos, CE", 1593.7],
    ["Mucambo, CE", 1609.8],
    ["Mulungu, CE", 1642.8],
    ["Nova Olinda, CE", 1699.3],
    ["Nova Russas, CE", 1637.8],
    ["Novo Oriente, CE", 1662.9],
    ["Ocara, CE", 1618.2],
    ["Orós, CE", 1693.9],
    ["Pacajus, CE", 1669.7],
    ["Pacatuba, CE", 1486.2],
    ["Pacoti, CE", 1551.0],
    ["Pacujá, CE", 1619.0],
    ["Palhano, CE", 1661.6],
    ["Palmácia, CE", 1596.7],
    ["Paracuru, CE", 1758.8],
    ["Paraipaba, CE", 1695.1],
    ["Parambu, CE", 1669.5],
    ["Paramoti, CE", 1602.5],
    ["Pedra Branca, CE", 1633.2],
    ["Penaforte, CE", 1682.0],
    ["Pentecoste, CE", 1627.2],
    ["Pereiro, CE", 1752.2],
    ["Pindoretama, CE", 1731.4],
    ["Piquet Carneiro, CE", 1661.9],
    ["Pires Ferreira, CE", 1605.8],
    ["Poranga, CE", 1716.8],
    ["Porteiras, CE", 1646.8],
    ["Potengi, CE", 1683.8],
    ["Potiretama, CE", 1724.8],
    ["Quiterianópolis, CE", 1636.8],
    ["Quixadá, CE", 1633.3],
    ["Quixelô, CE", 1754.5],
    ["Quixeramobim, CE", 1656.3],
    ["Quixeré, CE", 1636.6],
    ["Redenção, CE", 1519.8],
    ["Reriutaba, CE", 1634.7],
    ["Russas, CE", 1667.8],
    ["Saboeiro, CE", 1699.2],
    ["Salitre, CE", 1709.4],
    ["Santa Quitéria, CE", 1628.8],
    ["Santana do Acaraú, CE", 1581.8],
    ["Santana do Cariri, CE", 1654.0],
    ["São Benedito, CE", 1650.3],
    ["São Gonçalo do Amarante, CE", 1663.9],
    ["São João do Jaguaribe, CE", 1684.3],
    ["São Luís do Curu, CE", 1609.6],
    ["Senador Pompeu, CE", 1647.6],
    ["Senador Sá, CE", 1601.7],
    ["Sobral, CE", 1569.4],
    ["Solonópole, CE", 1695.8],
    ["Tabuleiro do Norte, CE", 1670.3],
    ["Tamboril, CE", 1613.8],
    ["Tarrafas, CE", 1677.3],
    ["Tauá, CE", 1649.2],
    ["Tejuçuoca, CE", 1602.9],
    ["Tianguá, CE", 1689.7],
    ["Trairi, CE", 1721.6],
    ["Tururu, CE", 1546.3],
    ["Ubajara, CE", 1636.2],
    ["Umari, CE", 1731.0],
    ["Umirim, CE", 1589.1],
    ["Uruburetama, CE", 1464.8],
    ["Uruoca, CE", 1612.2],
    ["Varjota, CE", 1648.7],
    ["Várzea Alegre, CE", 1730.3],
    ["Viçosa do Ceará, CE", 1634.4]
  ];

  // Buscando o local correspondente ao nome fornecido
  for (var item in locais) {
    // Convertendo o nome do item para minúsculas, removendo acentos e espaços
    var normalizedItem =
        removeAccents(item[0].toString().toLowerCase().replaceAll(' ', ''));

    // Verificando se o nome do local fornecido contém o nome do item da lista
    if (normalizedItem.contains(normalizedInput)) {
      // Retorna o nome do local e o fator solar encontrado
      return [item[0].toString(), item[1].toString()];
    }
  }

  // Se o local não for encontrado, retorna uma lista vazia
  return [];
}

String removeAccents(String input) {
  return input
      .replaceAll(RegExp(r'[áàãâä]'), 'a')
      .replaceAll(RegExp(r'[éèêë]'), 'e')
      .replaceAll(RegExp(r'[íìîï]'), 'i')
      .replaceAll(RegExp(r'[óòõôö]'), 'o')
      .replaceAll(RegExp(r'[úùûü]'), 'u')
      .replaceAll(RegExp(r'[ç]'), 'c');
}

List<String> findMostSimilar(List<List<dynamic>> locais, String localDesejado) {
  double maiorSimilaridade = 0.0;
  double fatorSolar = 0;
  String nomeMaisSimilar = "";

  for (var local in locais) {
    String nomeLocal = local[0].toLowerCase(); // Converter para minúsculas
    String localDesejadoMinusculas =
        localDesejado.toLowerCase(); // Converter a entrada para minúsculas
    double similaridade =
        calculateStringSimilarity(nomeLocal, localDesejadoMinusculas);

    if (similaridade > maiorSimilaridade) {
      maiorSimilaridade = similaridade;
      nomeMaisSimilar = local[0];
      fatorSolar = local[1];
    }
  }

  return [nomeMaisSimilar, fatorSolar.toString()];
}

double calculateStringSimilarity(String s1, String s2) {
  int len1 = s1.length;
  int len2 = s2.length;
  List<List<int>> matrix =
      List.generate(len1 + 1, (_) => List<int>.generate(len2 + 1, (_) => 0));

  for (int i = 0; i <= len1; i++) {
    for (int j = 0; j <= len2; j++) {
      if (i == 0) {
        matrix[i][j] = j;
      } else if (j == 0) {
        matrix[i][j] = i;
      } else {
        int cost = (s1[i - 1] == s2[j - 1]) ? 0 : 1;
        matrix[i][j] = (matrix[i - 1][j - 1] + cost)
            .compareTo((matrix[i][j - 1] + 1).compareTo(matrix[i - 1][j] + 1));
      }
    }
  }

  int maxLen = len1 > len2 ? len1 : len2;
  return 1 - matrix[len1][len2] / maxLen;
}
