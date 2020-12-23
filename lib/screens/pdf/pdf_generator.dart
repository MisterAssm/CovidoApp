import 'dart:io' as dio;

import 'package:covid19_ui/utils/constants.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class PdfViewPage extends StatelessWidget {
  final pdf = pw.Document(
    title: 'COVID-19 - Déclaration de déplacement',
    keywords:
        'covid19 covid-19 attestation déclaration déplacement officielle gouvernement',
    producer: 'DNUM/SDIT',
    creator: '',
    author: "Ministère de l'intérieur",
  );

  writeOnPdf() async {
    final box = PdfImage.file(
      pdf.document,
      bytes: (await rootBundle.load('assets/images/box.png'))
          .buffer
          .asUint8List(),
    );
    final trebuchet = pw.Font.ttf(
        ((await rootBundle.load('assets/fonts/Helvetica.ttf'))
            .buffer
            .asUint8List()
            .buffer
            .asByteData()));

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
              padding: pw.EdgeInsets.only(top: 2),
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Center(
                        child: pw.Text('ATTESTATION DE DÉPLACEMENT DÉROGATOIRE',
                            style:
                                pw.TextStyle(font: trebuchet, fontSize: 16))),
                    pw.SizedBox(height: 7),
                    pw.Center(
                        child: pw.Text(
                      'En application du décret n°2020-1310 du 29 octobre 2020 prescrivant les mesures générales',
                      style: pw.TextStyle(font: trebuchet, fontSize: 10),
                    )),
                    pw.Center(
                        child: pw.Text(
                            "nécessaires pour faire face à l'épidémie de Covid19 dans le cadre de l'état d'urgence sanitaire",
                            style:
                                pw.TextStyle(font: trebuchet, fontSize: 10))),
                    pw.SizedBox(height: 9),
                    pw.Text('Je soussigné(e),',
                        style: pw.TextStyle(font: trebuchet, fontSize: 10)),
                    pw.SizedBox(height: 12),
                    pw.Text('Mme/M. :', style: pw.TextStyle(font: trebuchet, fontSize: 10)),
                    pw.SizedBox(height: 12),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Né(e) le :', style: pw.TextStyle(font: trebuchet, fontSize: 10)),
                          pw.Spacer(),
                          pw.Text('à :', style: pw.TextStyle(font: trebuchet, fontSize: 10)),
                          pw.Spacer(),
                          pw.Spacer(),
                        ]),
                    pw.SizedBox(height: 12),
                    pw.Text('Demeurant :', style: pw.TextStyle(font: trebuchet, fontSize: 10)),
                    pw.SizedBox(height: 12),
                    pw.Text("certifie que mon déplacement est lié au motif suivant (cocher la case) autorisé par le décret\nn°2020-1310 du 29 octobre 2020 prescrivant les mesures générales nécessaires pour faire face à\nl'épidémie de Covid19 dans le cadre de l'état d'urgence sanitaire¹ :", style: pw.TextStyle(font: trebuchet, fontSize: 10)),
                    pw.SizedBox(height: 24),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Image(box, width: 13, height: 13),
                        pw.SizedBox(width: 13),
                        pw.Text('Déplacements entre le domicile et le lieu d’exercice de l’activité professionnelle ou un\nétablissement d’enseignement ou de formation, déplacements professionnels ne pouvant\nêtre différés², déplacements pour un concours ou un examen.', style: pw.TextStyle(font: trebuchet, fontSize: 10))
                      ]
                    ),
                    pw.SizedBox(height: 12),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Image(box, width: 13, height: 13),
                        pw.SizedBox(width: 13),
                        pw.Text("Déplacements  pour  effectuer  des  achats  de  fournitures  nécessaires  à  l'activité\nprofessionnelle,  des  achats  de  première  nécessité³ dans  des  établissements  dont  les\nactivités demeurent autorisées, le retrait de commande et les livraisons à domicile.", style: pw.TextStyle(font: trebuchet, fontSize: 10))
                      ]
                    ),
                    pw.SizedBox(height: 12),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Image(box, width: 13, height: 13),
                        pw.SizedBox(width: 13),
                        pw.Text('Consultations, examens et soins ne pouvant être assurés à distance et l’achat de\nmédicaments.', style: pw.TextStyle(font: trebuchet, fontSize: 10))
                      ]
                    ),
                    pw.SizedBox(height: 12),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Image(box, width: 13, height: 13),
                        pw.SizedBox(width: 13),
                        pw.Text("Déplacements pour motif familial impérieux, pour l'assistance aux personnes vulnérables\net précaires ou la garde d'enfants.", style: pw.TextStyle(font: trebuchet, fontSize: 10))
                      ]
                    ),
                    pw.SizedBox(height: 12),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Image(box, width: 13, height: 13),
                        pw.SizedBox(width: 13),
                        pw.Text('Déplacement des personnes en situation de handicap et leur accompagnant.\n', style: pw.TextStyle(font: trebuchet, fontSize: 10))
                      ]
                    ),
                    pw.SizedBox(height: 12),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Image(box, width: 13, height: 13),
                        pw.SizedBox(width: 13),
                        pw.Text("Déplacements brefs, dans la limite d'une heure quotidienne et dans un rayon maximal\nd'un kilomètre  autour  du  domicile, liés soit à l'activité physique individuelle des\npersonnes, à l'exclusion de toute pratique sportive collective et de toute proximité avec\nd'autres personnes, soit à la promenade avec les seules personnes regroupées dans un\nmême domicile, soit aux besoins des animaux de compagnie.", style: pw.TextStyle(font: trebuchet, fontSize: 10))
                      ]
                    ),
                    pw.SizedBox(height: 12),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Image(box, width: 13, height: 13),
                        pw.SizedBox(width: 13),
                        pw.Text('Convocation judiciaire ou administrative et pour se rendre dans un service public\n', style: pw.TextStyle(font: trebuchet, fontSize: 10))
                      ]
                    ),
                    pw.SizedBox(height: 12),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Image(box, width: 13, height: 13),
                        pw.SizedBox(width: 13),
                        pw.Text("Participation à des missions d'intérêt général sur demande de l'autorité administrative\n", style: pw.TextStyle(font: trebuchet, fontSize: 10))
                      ]
                    ),
                    pw.SizedBox(height: 12),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Image(box, width: 13, height: 13),
                        pw.SizedBox(width: 13),
                        pw.Text('Déplacement pour chercher les enfants à l’école et à l’occasion de leurs activités\npériscolaires', style: pw.TextStyle(font: trebuchet, fontSize: 10))
                      ]
                    ),
                    pw.SizedBox(height: 24),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Expanded(
                            child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                children: [
                                  pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Text('Fait à :', style: pw.TextStyle(font: trebuchet, fontSize: 10))
                                    ]
                                  ),
                                  pw.SizedBox(height: 12),
                                  pw.Row(
                                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Text('Le :', style: pw.TextStyle(font: trebuchet, fontSize: 10)),
                                        pw.Spacer(),
                                        pw.Text('à :', style: pw.TextStyle(font: trebuchet, fontSize: 10)),
                                        pw.Spacer(),
                                        pw.Spacer(),
                                      ]),
                                  pw.Row(
                                      mainAxisAlignment: pw.MainAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(height: 12),
                                        pw.Text('(Date et heure de début de sortie à mentionner obligatoirement)', style: pw.TextStyle(font: trebuchet, fontSize: 8)),
                                        pw.SizedBox(height: 12),
                                      ]
                                  ),
                                  pw.SizedBox(height: 12),
                                  pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Text('Signature', style: pw.TextStyle(font: trebuchet, fontSize: 10)),
                                    ]
                                  )
                                ]
                            )
                          ),
                          pw.BarcodeWidget(
                            data:
                            'Cree le: 02/11/2020 a 21h24;\n Nom: Zemouchi;\n Prenom: Assim;\n Naissance: 24/03/1999 a Chatillon;\n Adresse: 74 Avenue de Paris 92320 Chatillon;\n Sortie: 02/11/2020 a 21:45;\n Motifs: enfants',
                            width: 90,
                            height: 90,
                            barcode: pw.Barcode.qrCode(errorCorrectLevel: pw.BarcodeQRCorrectionLevel.medium),
                          )
                        ]),
                    pw.SizedBox(height: 24),
                    pw.Text("1 - Les personnes souhaitant bénéficier de l'une de ces exceptions doivent se munir s'il y a lieu, lors de leurs\ndéplacements hors de leur domicile, d'un document leur permettant de justifier que le déplacement considéré entre\ndans le champ de l'une de ces exceptions.", style: pw.TextStyle(font: trebuchet, fontSize: 6)),
                    pw.SizedBox(height: 9),
                    pw.Text("2 - A utiliser par les travailleurs non-salariés, lorsqu'ils ne peuvent disposer d'un justificatif de déplacement établi par leur\nemployeur.", style: pw.TextStyle(font: trebuchet, fontSize: 6)),
                    pw.SizedBox(height: 9),
                    pw.Text("3 - Y compris les acquisitions à titre gratuit (distribution de denrées alimentaires...) et les déplacements liés à la\nperception de prestations sociales et au retrait d'espèces.", style: pw.TextStyle(font: trebuchet, fontSize: 6)),
                  ]),
          );
        }));

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.BarcodeWidget(
              data:
                  'Cree le: 02/11/2020 a 21h24;\n Nom: Zemouchi;\n Prenom: Assim;\n Naissance: 24/03/1999 a Chatillon;\n Adresse: 74 Avenue de Paris 92320 Chatillon;\n Sortie: 02/11/2020 a 21:45;\n Motifs: enfants',
              width: 300,
              height: 300,
              barcode: pw.Barcode.qrCode(
                  errorCorrectLevel: pw.BarcodeQRCorrectionLevel.medium),
            )));
  }

  void test() async {}

  Future savePdf() async {
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);

    dio.Directory directory = await DownloadsPathProvider.downloadsDirectory;
    String documentPath = directory.path;

    dio.File file = dio.File('$documentPath/atest2.pdf');
    file.writeAsBytesSync(pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('PDF Flutter')),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('PDF TUTORIAL', style: kHeadingTextStyle)],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          writeOnPdf();
          await savePdf();

          _scaffoldKey.currentState.showSnackBar(
            new SnackBar(
              content: new Text("PDF Downloaded."),
              duration: new Duration(seconds: 3),
              backgroundColor: Color.fromRGBO(123, 237, 159, 1),
            ),
          );
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
