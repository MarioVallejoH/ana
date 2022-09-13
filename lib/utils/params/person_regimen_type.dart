//______________________________________________________________________________________________________________
//
//                                       RAZÓN SOCIAL Y TIPO REGIMEN
//_______________________________________________________________________________________________________________

import 'package:flutter/material.dart';

final personT = [
  const DropdownMenuItem(child: Text('Persona Jurídica'), value: "2"),
  const DropdownMenuItem(child: Text('Persona Natural'), value: "1")
];
final regimenT = [
  const DropdownMenuItem(child: Text('No responsable de IVA'), value: "1"),
  const DropdownMenuItem(child: Text('Responsable de IVA'), value: "2"),
  const DropdownMenuItem(child: Text('Regimen Simple'), value: "3"),
];
