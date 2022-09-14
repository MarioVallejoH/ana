import 'package:customer_app/models/city_model.dart';
import 'package:customer_app/models/country_model.dart';
import 'package:customer_app/models/state_model.dart';
import 'package:customer_app/models/subzone_model.dart';
import 'package:customer_app/models/zone_model.dart';
import 'package:customer_app/register/controller/register_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/color.dart';
import '../../utils/constant.dart';

class CompRegPage3 extends GetView<RegisterController> {
  const CompRegPage3(
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKeyP3,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DropdownSearch<CountryModel>(
              popupProps: PopupProps.menu(
                  emptyBuilder: (context, String? string) {
                    return const Center(
                      child: Text("No se encontraron países"),
                    );
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
                  showSearchBox: true),
              compareFn: (i1, i2) => i1.nombre == i2.nombre,
              dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      labelText: "País",
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      fillColor: greyLight,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(radiusValue),
                          borderSide: BorderSide.none))),
              selectedItem: controller.companyData.selCountry,
              asyncItems: (search) async {
                return await controller.countries();
              },
              validator: (value) {
                if (value == null) {
                  return "Campo requerido";
                }
                return null;
              },
              onChanged: (CountryModel? value) async {
                if (controller.companyData.selCountry?.codigo !=
                    value?.codigo) {
                  controller.companyData.selCountry = value;

                  await controller.reloadStateCity();
                }
              },
            ).paddingSymmetric(horizontal: 16, vertical: 6),
            StreamBuilder<List<StateModel>>(
              stream: controller.statesStream,
              initialData: controller.statesI ?? [],
              builder: (BuildContext context,
                  AsyncSnapshot<List<StateModel>> snapshot) {
                return DropdownSearch<StateModel>(
                  enabled:
                      snapshot.hasData && (snapshot.data?.isNotEmpty ?? false),
                  popupProps: PopupProps.menu(
                      emptyBuilder: (context, String? string) {
                        return const Center(
                          child: Text("No se encontraron departamentos"),
                        );
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
                                  borderRadius:
                                      BorderRadius.circular(radiusValue),
                                  borderSide: BorderSide.none))),
                      showSelectedItems: true,
                      fit: FlexFit.loose,
                      showSearchBox: true),
                  compareFn: (i1, i2) => i1.departamento == i2.departamento,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                          labelText: "Departamento",
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          fillColor: greyLight,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(radiusValue),
                              borderSide: BorderSide.none))),
                  selectedItem: controller.companyData.selState,
                  items: snapshot.data!,
                  validator: (value) {
                    if (value == null) {
                      return "Campo requerido";
                    }
                    return null;
                  },
                  onChanged: (StateModel? value) async {
                    if (controller.companyData.selState?.coddepartamento !=
                        value?.coddepartamento) {
                      controller.companyData.selState = value;

                      await controller.reloadCity();
                    }
                  },
                );
              },
            ).paddingSymmetric(horizontal: 16, vertical: 6),
            StreamBuilder<List<CityModel>>(
              stream: controller.citiesStream,
              initialData: controller.citiesI ?? [],
              builder: (BuildContext context,
                  AsyncSnapshot<List<CityModel>> snapshot) {
                return DropdownSearch<CityModel>(
                  enabled:
                      snapshot.hasData && (snapshot.data?.isNotEmpty ?? false),
                  popupProps: PopupProps.menu(
                      emptyBuilder: (context, String? string) {
                        return const Center(
                          child: Text("No se encontraron ciudades"),
                        );
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
                                  borderRadius:
                                      BorderRadius.circular(radiusValue),
                                  borderSide: BorderSide.none))),
                      showSelectedItems: true,
                      fit: FlexFit.loose,
                      showSearchBox: true),
                  compareFn: (i1, i2) => i1.codigo == i2.codigo,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                          labelText: "Ciudad",
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          fillColor: greyLight,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(radiusValue),
                              borderSide: BorderSide.none))),
                  selectedItem: controller.companyData.selCity,
                  items: snapshot.data!,
                  validator: (value) {
                    if (value == null) {
                      return "Campo requerido";
                    }
                    return null;
                  },
                  onChanged: (CityModel? value) async {
                    if (controller.companyData.selCity?.codigo !=
                        value?.codigo) {
                      controller.companyData.selCity = value;

                      await controller.reloadZones();
                    }
                  },
                );
              },
            ).paddingSymmetric(horizontal: 16, vertical: 6),
            TextFormField(
              onChanged: (String? value) {
                controller.companyData.address = value ?? "";
              },
              initialValue: controller.companyData.address,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  fillColor: greyLight,
                  filled: true,
                  hintText: "Dirección",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radiusValue),
                      borderSide: BorderSide.none)),
            ).paddingSymmetric(horizontal: 16, vertical: 6),
            TextFormField(
              onChanged: (String? value) {
                controller.companyData.postalCode = value ?? "";
              },
              initialValue: controller.companyData.postalCode,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  fillColor: greyLight,
                  filled: true,
                  hintText: "Codigo postal",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radiusValue),
                      borderSide: BorderSide.none)),
            ).paddingSymmetric(horizontal: 16, vertical: 6)
          ],
        ),
      ),
    );
  }
}
