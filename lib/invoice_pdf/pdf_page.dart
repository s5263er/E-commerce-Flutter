import 'package:flutter/material.dart';
import 'package:flutter_app/invoice_pdf/pdf_api.dart';
import 'package:flutter_app/invoice_pdf/pdf_invoice.dart';
import 'package:flutter_app/invoice_pdf/widgets.dart';
import 'package:flutter_app/myStore.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'invoicemodels.dart';


class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<myStore>(context);
    return Scaffold(

    backgroundColor:
    Colors.black
    ,
    appBar: AppBar(
    title: Text("TechIst"),
    centerTitle: true,
    ),
    body: Container(
    padding: EdgeInsets.all(32),
    child: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    TitleWidget(
    icon: Icons.picture_as_pdf,
    text: 'Generate Invoice',
    ),
    const SizedBox(height: 48),
    ButtonWidget(
    text: 'Invoice PDF',
    onClicked: () async {
    final date = DateTime.now();
    final dueDate = date.add(Duration(days: 7));

    final invoice = Invoice(
    supplier: Supplier(
    name: 'TechIst Team',
    address: 'Sabanci University Istanbul/Turkey',
    paymentInfo: 'https://paypal.me/techist',
    ),
    customer: Customer(
    name: store.username,
    address: store.adress,
    ),
    info: InvoiceInfo(
    date: date,
    dueDate: dueDate,
    description: 'Thank you for your purchase...',
    number: '${DateTime.now().year}-9999',
    ),
    items: [
    for(var i in store.baskets)
        InvoiceItem(
          description: i.title,
          date: DateTime.now(),
          quantity: i.size,
          unitPrice: i.discountrate == 0 ? i.price.toDouble(): i.discprice.toDouble(),
        ),
    ],
    );

    final pdfFile = await PdfInvoiceApi.generate(invoice);

    PdfApi.openFile(pdfFile);
    },
    ),
    ],
    ),
    ),
    ),
    );
  }
}