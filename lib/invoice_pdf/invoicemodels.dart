import 'package:flutter/material.dart';


class Customer {
  final String name;
  final String address;

  const Customer({
     this.name,
     this.address,
  });
}
class Supplier {
  final String name;
  final String address;
  final String paymentInfo;

  const Supplier({
     this.name,
     this.address,
     this.paymentInfo,
  });
}

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
     this.info,
     this.supplier,
     this.customer,
     this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
     this.description,
     this.number,
     this.date,
     this.dueDate,
  });
}

class InvoiceItem {
  final String description;
  final DateTime date;
  final int quantity;
  final double unitPrice;

  const InvoiceItem({
     this.description,
     this.date,
     this.quantity,
     this.unitPrice,
  });
}