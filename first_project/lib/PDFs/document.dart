import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:share/share.dart';
import 'package:Urbansol_App/funcoes.dart';

Future<void> generatePDF(
  String name,
  String local,
  double kWp,
  double? consumo,
  double geracao,
  double? preco,
  String garantiaModulos,
  String garantiaInversor,
  String placas,
  String inversor,
  double valorAntes,
  double valorDepois,
  double valorEconomiaAnual,
) async {
  final pdf = pw.Document();
  final fontData = await rootBundle.load('fonts/Arial.ttf');
  final ttf = pw.Font.ttf(fontData.buffer.asByteData());
  final boldFontData =
      await rootBundle.load('fonts/Arial-Bold.ttf'); // Fonte em negrito
  final boldTtf = pw.Font.ttf(boldFontData.buffer.asByteData());

  // Adicione sua imagem como plano de fundo
  final image = pw.MemoryImage(
    (await rootBundle.load('imgs/p1.jpg')).buffer.asUint8List(),
  );

  final image2 = pw.MemoryImage(
    (await rootBundle.load('imgs/p2.jpg')).buffer.asUint8List(),
  );

  final image3 = pw.MemoryImage(
    (await rootBundle.load('imgs/p3.jpg')).buffer.asUint8List(),
  );

  final image4 = pw.MemoryImage(
    (await rootBundle.load('imgs/p4.jpg')).buffer.asUint8List(),
  );

  final image5 = pw.MemoryImage(
    (await rootBundle.load('imgs/p5.jpg')).buffer.asUint8List(),
  );

  final image6 = pw.MemoryImage(
    (await rootBundle.load('imgs/p6.jpg')).buffer.asUint8List(),
  );

  final image7 = pw.MemoryImage(
    (await rootBundle.load('imgs/p7.jpg')).buffer.asUint8List(),
  );

  final image8 = pw.MemoryImage(
    (await rootBundle.load('imgs/p8.jpg')).buffer.asUint8List(),
  );

  // calculando lista de valores n para o grafico de lucro
  List<double> n = calculaN(valorEconomiaAnual);

  // Capa
  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 0,
          marginLeft: 0,
          marginRight: 0,
          marginTop: 0,
        ),
        orientation: pw.PageOrientation.portrait,
        buildBackground: (context) => pw.Image(image, fit: pw.BoxFit.fill),
      ),
      build: (pw.Context context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.only(
            // left: -220,
            top: 720,
            left: 30,
          ),
          child: pw.Center(
            child: pw.Column(
              children: [
                pw.Align(
                  alignment:
                      pw.Alignment.centerLeft, // Ajuste para a posição desejada
                  child: pw.RichText(
                    textAlign: pw.TextAlign.left,
                    text: pw.TextSpan(
                      text: name,
                      style: pw.TextStyle(
                          fontSize: 18, font: ttf, color: PdfColors.black),
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(
                    top: 7,
                  ),
                  child: pw.Align(
                    alignment: pw
                        .Alignment.centerLeft, // Ajuste para a posição desejada
                    child: pw.RichText(
                      textAlign: pw.TextAlign.left,
                      text: pw.TextSpan(
                        text: local,
                        style: pw.TextStyle(
                          fontSize: 15,
                          font: ttf,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  // Pagina 2
  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 0,
          marginLeft: 0,
          marginRight: 0,
          marginTop: 0,
        ),
        orientation: pw.PageOrientation.portrait,
        buildBackground: (context) => pw.Image(image2, fit: pw.BoxFit.fill),
      ),
      build: (pw.Context context) {
        return pw.Align(alignment: pw.Alignment.centerLeft);
      },
    ),
  );

  // Pagina 3
  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 0,
          marginLeft: 0,
          marginRight: 0,
          marginTop: 0,
        ),
        orientation: pw.PageOrientation.portrait,
        buildBackground: (context) => pw.Image(image3, fit: pw.BoxFit.fill),
      ),
      build: (pw.Context context) {
        return pw.Align(alignment: pw.Alignment.centerLeft);
      },
    ),
  );

  // Pagina 4
  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 0,
          marginLeft: 0,
          marginRight: 0,
          marginTop: 0,
        ),
        orientation: pw.PageOrientation.portrait,
        buildBackground: (context) => pw.Image(image4, fit: pw.BoxFit.fill),
      ),
      build: (pw.Context context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.only(
            // left: -220,
            top: 138,
            left: 11,
          ),
          child: pw.Center(
            child: pw.Column(
              children: [
                pw.Align(
                  alignment:
                      pw.Alignment.centerLeft, // Ajuste para a posição desejada
                  child: pw.RichText(
                    textAlign: pw.TextAlign.left,
                    text: pw.TextSpan(
                      text: formatCurrency(n[6]),
                      style: pw.TextStyle(
                          fontSize: 9, font: boldTtf, color: PdfColors.black),
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(
                    top: 16,
                  ),
                  child: pw.Align(
                    alignment: pw
                        .Alignment.centerLeft, // Ajuste para a posição desejada
                    child: pw.RichText(
                      textAlign: pw.TextAlign.left,
                      text: pw.TextSpan(
                        text: formatCurrency(n[5]),
                        style: pw.TextStyle(
                          fontSize: 9,
                          font: boldTtf,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(
                    top: 14,
                  ),
                  child: pw.Align(
                    alignment: pw
                        .Alignment.centerLeft, // Ajuste para a posição desejada
                    child: pw.RichText(
                      textAlign: pw.TextAlign.left,
                      text: pw.TextSpan(
                        text: formatCurrency(n[4]),
                        style: pw.TextStyle(
                          fontSize: 9,
                          font: boldTtf,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(
                    top: 10,
                  ),
                  child: pw.Align(
                    alignment: pw
                        .Alignment.centerLeft, // Ajuste para a posição desejada
                    child: pw.RichText(
                      textAlign: pw.TextAlign.left,
                      text: pw.TextSpan(
                        text: formatCurrency(n[3]),
                        style: pw.TextStyle(
                          fontSize: 9,
                          font: boldTtf,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(
                    top: 8,
                  ),
                  child: pw.Align(
                    alignment: pw
                        .Alignment.centerLeft, // Ajuste para a posição desejada
                    child: pw.RichText(
                      textAlign: pw.TextAlign.left,
                      text: pw.TextSpan(
                        text: formatCurrency(n[2]),
                        style: pw.TextStyle(
                          fontSize: 9,
                          font: boldTtf,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(
                    top: 10,
                  ),
                  child: pw.Align(
                    alignment: pw
                        .Alignment.centerLeft, // Ajuste para a posição desejada
                    child: pw.RichText(
                      textAlign: pw.TextAlign.left,
                      text: pw.TextSpan(
                        text: formatCurrency(n[1]),
                        style: pw.TextStyle(
                          fontSize: 9,
                          font: boldTtf,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(
                    top: 18,
                  ),
                  child: pw.Align(
                    alignment: pw
                        .Alignment.centerLeft, // Ajuste para a posição desejada
                    child: pw.RichText(
                      textAlign: pw.TextAlign.left,
                      text: pw.TextSpan(
                        text: formatCurrency(n[0]),
                        style: pw.TextStyle(
                          fontSize: 9,
                          font: boldTtf,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(
                    top: 10,
                  ),
                  child: pw.Align(
                    alignment: pw
                        .Alignment.centerLeft, // Ajuste para a posição desejada
                    child: pw.RichText(
                      textAlign: pw.TextAlign.left,
                      text: pw.TextSpan(
                        text: formatCurrency(0),
                        style: pw.TextStyle(
                          fontSize: 9,
                          font: boldTtf,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  // Pagina 5
  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 0,
          marginLeft: 0,
          marginRight: 0,
          marginTop: 0,
        ),
        orientation: pw.PageOrientation.portrait,
        buildBackground: (context) => pw.Image(image5, fit: pw.BoxFit.fill),
      ),
      build: (pw.Context context) {
        return pw.Stack(
          children: [
            pw.Positioned(
              left: 63, // Ajuste a posição horizontal desejada
              top: 195, // Ajuste a posição vertical desejada
              child: pw.RichText(
                textAlign: pw.TextAlign.center,
                text: pw.TextSpan(
                  text: formatKWP(kWp),
                  style: pw.TextStyle(
                    fontSize: 20,
                    font: boldTtf,
                    color: PdfColors.white,
                  ),
                ),
              ),
            ),
            pw.Positioned(
              left: 65, // Ajuste a posição horizontal desejada
              top: 377, // Ajuste a posição vertical desejada
              child: pw.RichText(
                textAlign: pw.TextAlign.center,
                text: pw.TextSpan(
                  text: formatCurrency(valorAntes),
                  style: pw.TextStyle(
                    fontSize: 20,
                    font: boldTtf,
                    color: PdfColors.white,
                  ),
                ),
              ),
            ),
            pw.Positioned(
              left: 235, // Ajuste a posição horizontal desejada
              top: 195, // Ajuste a posição vertical desejada
              child: pw.RichText(
                textAlign: pw.TextAlign.left,
                text: pw.TextSpan(
                  text: formatKWH(consumo),
                  style: pw.TextStyle(
                    fontSize: 20,
                    font: boldTtf,
                    color: PdfColors.white,
                  ),
                ),
              ),
            ),
            pw.Positioned(
              left: 242, // Ajuste a posição horizontal desejada
              top: 377, // Ajuste a posição vertical desejada
              child: pw.RichText(
                textAlign: pw.TextAlign.left,
                text: pw.TextSpan(
                  text: formatCurrency(valorDepois),
                  style: pw.TextStyle(
                    fontSize: 20,
                    font: boldTtf,
                    color: PdfColors.white,
                  ),
                ),
              ),
            ),
            pw.Positioned(
              left: 407, // Ajuste a posição horizontal desejada
              top: 195, // Ajuste a posição vertical desejada
              child: pw.RichText(
                textAlign: pw.TextAlign.left,
                text: pw.TextSpan(
                  text: formatKWH(geracao),
                  style: pw.TextStyle(
                    fontSize: 20,
                    font: boldTtf,
                    color: PdfColors.white,
                  ),
                ),
              ),
            ),
            pw.Positioned(
              left: 413, // Ajuste a posição horizontal desejada
              top: 377, // Ajuste a posição vertical desejada
              child: pw.RichText(
                textAlign: pw.TextAlign.left,
                text: pw.TextSpan(
                  text: formatCurrency(valorEconomiaAnual),
                  style: pw.TextStyle(
                    fontSize: 20,
                    font: boldTtf,
                    color: PdfColors.white,
                  ),
                ),
              ),
            ),
            pw.Positioned(
              left: 300, // Ajuste a posição horizontal desejada
              top: 482.5, // Ajuste a posição vertical desejada
              child: pw.RichText(
                textAlign: pw.TextAlign.left,
                text: pw.TextSpan(
                  text: formatCurrency(preco),
                  style: pw.TextStyle(
                    fontSize: 27,
                    font: boldTtf,
                    color: PdfColors.green300,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );

  // Pagina 6
  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 0,
          marginLeft: 0,
          marginRight: 0,
          marginTop: 0,
        ),
        orientation: pw.PageOrientation.portrait,
        buildBackground: (context) => pw.Image(image6, fit: pw.BoxFit.fill),
      ),
      build: (pw.Context context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.only(
            // left: -220,
            top: 143,
            left: 105,
          ),
          child: pw.Center(
            child: pw.Column(
              children: [
                pw.Align(
                  alignment:
                      pw.Alignment.centerLeft, // Ajuste para a posição desejada
                  child: pw.RichText(
                    textAlign: pw.TextAlign.left,
                    text: pw.TextSpan(
                      text: placas,
                      style: pw.TextStyle(
                          fontSize: 10, font: ttf, color: PdfColors.black),
                    ),
                  ),
                ),
                pw.Padding(padding: const pw.EdgeInsets.only(top: 12)),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 11),
                  child: pw.Align(
                    alignment: pw
                        .Alignment.centerLeft, // Ajuste para a posição desejada
                    child: pw.RichText(
                      textAlign: pw.TextAlign.left,
                      text: pw.TextSpan(
                        text: inversor,
                        style: pw.TextStyle(
                            fontSize: 10, font: ttf, color: PdfColors.black),
                      ),
                    ),
                  ),
                ),
                pw.Padding(padding: const pw.EdgeInsets.only(top: 102)),
                pw.Align(
                  alignment:
                      pw.Alignment.centerLeft, // Ajuste para a posição desejada
                  child: pw.RichText(
                    textAlign: pw.TextAlign.left,
                    text: pw.TextSpan(
                      text: garantiaModulos,
                      style: pw.TextStyle(
                          fontSize: 10, font: ttf, color: PdfColors.black),
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 11, top: 11),
                  child: pw.Align(
                    alignment: pw
                        .Alignment.centerLeft, // Ajuste para a posição desejada
                    child: pw.RichText(
                      textAlign: pw.TextAlign.left,
                      text: pw.TextSpan(
                        text: garantiaInversor,
                        style: pw.TextStyle(
                            fontSize: 10, font: ttf, color: PdfColors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  // Pagina 7
  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 0,
          marginLeft: 0,
          marginRight: 0,
          marginTop: 0,
        ),
        orientation: pw.PageOrientation.portrait,
        buildBackground: (context) => pw.Image(image7, fit: pw.BoxFit.fill),
      ),
      build: (pw.Context context) {
        return pw.Align(alignment: pw.Alignment.centerLeft);
      },
    ),
  );

  // Pagina 8
  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 0,
          marginLeft: 0,
          marginRight: 0,
          marginTop: 0,
        ),
        orientation: pw.PageOrientation.portrait,
        buildBackground: (context) => pw.Image(image8, fit: pw.BoxFit.fill),
      ),
      build: (pw.Context context) {
        return pw.Align(alignment: pw.Alignment.centerLeft);
      },
    ),
  );

  final output = await getApplicationDocumentsDirectory();
  final pdfFile =
      File('${output.path}/Orçamento ${(geracao.round()).toString()}.pdf');
  await pdfFile.writeAsBytes(await pdf.save());

  // Compartilhe o PDF
  Share.shareFiles([pdfFile.path], text: 'Compartilhando o PDF');

  // Abra o PDF usando o pacote open_file
  OpenFile.open(pdfFile.path);
}
