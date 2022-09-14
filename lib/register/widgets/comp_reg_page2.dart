import 'package:customer_app/register/controller/register_controller.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../models/documentypes_model.dart';
import '../../theme/color.dart';
import '../../utils/constant.dart';

class CompRegPage2 extends GetView<RegisterController> {
  const CompRegPage2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKeyP2,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _docSelection().paddingSymmetric(horizontal: 16, vertical: 6),
            _names(),
            _email().paddingSymmetric(horizontal: 16, vertical: 6),
          ],
        ),
      ),
    );
  }

  TextFormField _phone() {
    return TextFormField(
      initialValue: controller.companyData.phone,
      onChanged: (String? value) {
        controller.companyData.phone = value ?? "";
      },
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          fillColor: greyLight,
          filled: true,
          labelText: "Teléfono",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radiusValue),
              borderSide: BorderSide.none)),
    );
  }

  TextFormField _email() {
    return TextFormField(
      initialValue: controller.companyData.email,
      textCapitalization: TextCapitalization.sentences,
      validator: MultiValidator([
        EmailValidator(errorText: "Ingresa un correo valido"),
      ]),
      onChanged: (String? value) {
        controller.companyData.email = value ?? "";
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          fillColor: greyLight,
          filled: true,
          labelText: "Correo",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radiusValue),
              borderSide: BorderSide.none)),
    );
  }

  TextFormField _commercialName() {
    return TextFormField(
      onChanged: (String? value) {
        controller.companyData.company = value ?? "";
      },
      initialValue: controller.companyData.company,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          fillColor: greyLight,
          filled: true,
          labelText: "Nombre comercial",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radiusValue),
              borderSide: BorderSide.none)),
    );
  }

  Widget _docSelection() {
    return Obx(
      () {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownSearch<DocumentTypesModel>(
              asyncItems: (search) async {
                return await controller.documentTypes();
              },
              selectedItem: controller.companyData.docType,
              popupProps: PopupProps.menu(
                  emptyBuilder: (context, String? string) {
                    return const Center(
                      child: Text("No se encontraron tipos de documentos"),
                    );
                  },
                  itemBuilder: (context, item, isSelected) {
                    return Text(
                      item.toString(),
                      style: ThemeConf().normalTextStyle(context),
                    ).paddingSymmetric(horizontal: 10, vertical: 6);
                  },
                  menuProps: MenuProps(
                      borderRadius: BorderRadius.circular(radiusValue2),
                      elevation: 5),
                  searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          fillColor: greyLight,
                          filled: true,
                          hintText: "Buscar",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(radiusValue),
                              borderSide: BorderSide.none))),
                  showSelectedItems: true,
                  fit: FlexFit.loose,
                  showSearchBox: false),
              compareFn: (i1, i2) => i1.codigoDoc == i2.codigoDoc,
              itemAsString: (item) => item.toString2(),
              dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      labelText: (controller.companyData.docType != null)
                          ? "T. doc."
                          : "Tipo de documento",
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      fillColor: greyLight,
                      filled: true,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusValue),
                              bottomLeft: Radius.circular(radiusValue)),
                          borderSide: BorderSide.none))),
              validator: (value) {
                if (value == null) {
                  return "Campo requerido";
                }
                return null;
              },
              onChanged: (DocumentTypesModel? value) {
                controller.companyData.docType = value;
                if (value != null) {
                  controller.isDocTSelected = true;
                } else {
                  controller.isDocTSelected = false;
                }
              },
            ).flexible(flex: (controller.isDocTSelected) ? 1 : 2),
            AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(left: 4),
                width: double.infinity,
                child: TextFormField(
                  initialValue: controller.companyData.vatNo,
                  validator: (value) {
                    final reqVal =
                        RequiredValidator(errorText: "Campo requerido");

                    if (!reqVal.isValid(value)) {
                      return reqVal.errorText;
                    }
                    if (!controller.isValidDocument) {
                      return "Documento en uso";
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    controller.isValidDocument = false;
                    controller.companyData.vatNo = value ?? "";
                  },
                  decoration: InputDecoration(
                      labelText: "Numero de Documento",
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      fillColor: greyLight,
                      filled: true,
                      // hintText: "Numero de Documento",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(radiusValue),
                              bottomRight: Radius.circular(radiusValue)),
                          borderSide: BorderSide.none)),
                )).flexible(flex: controller.isDocTSelected ? 2 : 1)
          ],
        );
      },
    );
  }

  Column _names() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: controller.companyData.firstName,
              textCapitalization: TextCapitalization.words,
              onChanged: (String? value) {
                controller.companyData.firstName = value ?? "";
              },
              validator: RequiredValidator(errorText: "Campo requerido"),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  fillColor: greyLight,
                  filled: true,
                  labelText: "Primer nombre",
                  errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusValue),
                          bottomLeft: Radius.circular(radiusValue)),
                      borderSide: BorderSide(color: errorColor2)),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusValue),
                          bottomLeft: Radius.circular(radiusValue)),
                      borderSide: BorderSide.none)),
            ).paddingRight(4).flexible(flex: 1),
            TextFormField(
              onChanged: (String? value) {
                controller.companyData.secondName = value ?? "";
              },
              textCapitalization: TextCapitalization.words,
              initialValue: controller.companyData.secondName,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  fillColor: greyLight,
                  filled: true,
                  labelText: "Segundo nombre",
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(radiusValue),
                          bottomRight: Radius.circular(radiusValue)),
                      borderSide: BorderSide.none)),
            ).flexible(flex: 1)
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              textCapitalization: TextCapitalization.words,
              initialValue: controller.companyData.firstLastname,
              onChanged: (String? value) {
                controller.companyData.firstLastname = value ?? "";
              },
              validator: RequiredValidator(errorText: "Campo requerido"),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  fillColor: greyLight,
                  filled: true,
                  labelText: "Primer apellido",
                  errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusValue),
                          bottomLeft: Radius.circular(radiusValue)),
                      borderSide: BorderSide(color: errorColor2)),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusValue),
                          bottomLeft: Radius.circular(radiusValue)),
                      borderSide: BorderSide.none)),
            ).paddingRight(4).flexible(flex: 1),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              initialValue: controller.companyData.secondLastname,
              onChanged: (String? value) {
                controller.companyData.secondLastname = value ?? "";
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  fillColor: greyLight,
                  filled: true,
                  labelText: "Segundo apellido",
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(radiusValue),
                          bottomRight: Radius.circular(radiusValue)),
                      borderSide: BorderSide.none)),
            ).flexible(flex: 1)
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 6)
      ],
    );
  }
}
