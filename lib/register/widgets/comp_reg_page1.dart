import 'package:customer_app/register/controller/register_controller.dart';
import 'package:customer_app/utils/parsing/numeric_paring.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/params/person_regimen_type.dart';
import '../../theme/color.dart';
import '../../utils/constant.dart';

class CompanyRegPage1 extends GetView<RegisterController> {
  const CompanyRegPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKeyP1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                fillColor: greyLight,
                labelText: "Tipo de persona",
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radiusValue),
                    borderSide: BorderSide.none)),
            validator: (value) {
              if (value == null) {
                return "Campo requerido";
              }
              return null;
            },
            // hint: const Text("Tipo de persona"),
            value: controller.companyData.typePerson,
            items: personT,
            onChanged: (String? value) {
              controller.companyData.typePerson = value;
            },
          ).paddingSymmetric(horizontal: 16, vertical: 6),
          DropdownButtonFormField(
            // hint: const Text("Tipo de regimen"),
            value: controller.companyData.tipoRegimen,
            decoration: InputDecoration(
                labelText: "Tipo de regimen",
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                fillColor: greyLight,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radiusValue),
                    borderSide: BorderSide.none)),
            validator: (value) {
              if (value == null) {
                return "Campo requerido";
              }
              return null;
            },
            borderRadius: BorderRadius.circular(radiusValue),
            items: regimenT,
            onChanged: (String? value) {
              controller.companyData.tipoRegimen = value;
            },
          ).paddingSymmetric(horizontal: 16, vertical: 6),
          FutureBuilder<List<DropdownMenuItem<String>>>(
            future: controller.customerGroups(),
            initialData: const [],
            builder: (BuildContext context,
                AsyncSnapshot<List<DropdownMenuItem<String>>> snapshot) {
              return DropdownButtonFormField(
                // hint: const Text("Grupo de cliente"),
                // ignore: prefer_null_aware_operators
                value: controller.companyData.customerGroupId != null
                    ? controller.companyData.customerGroupId.toString()
                    : null,
                decoration: InputDecoration(
                    labelText: "Grupo de cliente",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    fillColor: greyLight,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(radiusValue),
                        borderSide: BorderSide.none)),
                validator: (value) {
                  if (value == null) {
                    return "Campo requerido";
                  }
                  return null;
                },
                borderRadius: BorderRadius.circular(radiusValue),
                items: snapshot.data,
                onChanged: (String? value) {
                  // setState(() {
                  controller.companyData.customerGroupId =
                      parsingToIntNullable(value);
                  // });
                },
              );
            },
          ).paddingSymmetric(horizontal: 16, vertical: 6),
        ],
      ),
    );
  }
}
