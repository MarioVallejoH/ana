import 'package:customer_app/utils/params/gender.dart';
import 'package:customer_app/register/controller/register_controller.dart';
import 'package:customer_app/register/widgets/image_pick.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../theme/color.dart';
import '../../utils/constant.dart';

class CompRegPage4 extends GetView<RegisterController> {
  const CompRegPage4({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKeyP4,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            controller.companyData.typePerson == "2"
                ? _names()
                : const SizedBox(
                    height: 0,
                  ),
            genderSelection().paddingSymmetric(horizontal: 16, vertical: 6),
            _email().paddingSymmetric(horizontal: 16, vertical: 6),
            _phone().paddingSymmetric(horizontal: 16, vertical: 6),
            _userName().paddingSymmetric(horizontal: 16, vertical: 6),
            _password().paddingSymmetric(horizontal: 16, vertical: 6)
          ],
        ),
      ),
    );
  }

  Widget _names() {
    return Column(
      children: [
        TextFormField(
          initialValue: controller.userData().firstName,
          onChanged: (String? value) {
            controller.setUserData(firstName: value);
          },
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.text,
          validator: RequiredValidator(errorText: "Campo obligatorio"),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              fillColor: greyLight,
              filled: true,
              hintText: "Primer nombre",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radiusValue),
                  borderSide: BorderSide.none)),
        ).paddingSymmetric(horizontal: 16, vertical: 6),
        TextFormField(
          initialValue: controller.userData().firstLastname,
          onChanged: (String? value) {
            controller.setUserData(firstLastName: value);
          },
          validator: RequiredValidator(errorText: "Campo requerido"),
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              fillColor: greyLight,
              filled: true,
              hintText: "Primer apellido",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radiusValue),
                  borderSide: BorderSide.none)),
        ).paddingSymmetric(horizontal: 16, vertical: 6)
      ],
    );
  }

  TextFormField _phone() {
    return TextFormField(
      initialValue: controller.userData().phone,
      onChanged: (String? value) {
        // controller.comercialPhone = value ?? "";
        controller.setUserData(phone: value);
      },
      validator: (value) {
        final reqVal = RequiredValidator(errorText: "Campo requerido");

        if (!reqVal.isValid(value)) {
          return reqVal.errorText;
        }
        if (!controller.isValidPhone) {
          return "Teléfono en uso";
        }
        return null;
      },
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          fillColor: greyLight,
          filled: true,
          hintText: "Teléfono",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radiusValue),
              borderSide: BorderSide.none)),
    );
  }

  TextFormField _email() {
    // final email = controller.userData().email;
    return TextFormField(
      initialValue: controller.userData().email,
      onChanged: (String? value) {
        controller.setUserData(email: value);
      },
      validator: (value) {
        final reqVal = RequiredValidator(errorText: "Campo requerido");

        final emailVal = EmailValidator(errorText: "Ingresa un correo valido");
        if (!reqVal.isValid(value)) {
          return reqVal.errorText;
        }
        if (!emailVal.isValid(value)) {
          return emailVal.errorText;
        }
        if (!controller.isValidEmail) {
          return "Correo en uso";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          fillColor: greyLight,
          filled: true,
          hintText: "Email",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radiusValue),
              borderSide: BorderSide.none)),
    );
  }

  TextFormField _userName() {
    return TextFormField(
      initialValue: controller.userData().username,
      onChanged: (String? value) {
        controller.setUserData(username: value);
      },
      validator: (value) {
        final reqVal = RequiredValidator(errorText: "Campo requerido");

        if (!reqVal.isValid(value)) {
          return reqVal.errorText;
        }

        if (!controller.isValidUName) {
          return "Nombre de usuario en uso";
        }
        return null;
      },
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          fillColor: greyLight,
          filled: true,
          hintText: "Nombre de usuario",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radiusValue),
              borderSide: BorderSide.none)),
    );
  }

  TextFormField _password() {
    return TextFormField(
      initialValue: controller.userData().password,
      onChanged: (String? value) {
        controller.setUserData(password: value);
      },
      keyboardType: TextInputType.visiblePassword,
      validator: MultiValidator([
        RequiredValidator(errorText: "Campo requerido"),
        LengthRangeValidator(
            min: 8,
            max: 10,
            errorText: "La contraseña debe tener entre 8 y 10 caracteres"),
        PatternValidator(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$",
            errorText: "La contraseña debe contener mínimo 1 numero y 1 letra")
      ]),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          fillColor: greyLight,
          filled: true,
          hintText: "Contraseña",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radiusValue),
              borderSide: BorderSide.none)),
    );
  }

  Widget genderSelection() {
    return DropdownButtonFormField<String>(
      value: controller.companyData.gender,
      isExpanded: true,
      selectedItemBuilder: (context) {
        return gendersT.map((
          Map<String, String> e,
        ) {
          return Text(e["text"] ?? "");
        }).toList();
      },
      decoration: InputDecoration(
          labelText: "Género",
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          fillColor: greyLight,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radiusValue),
              borderSide: BorderSide.none)),
      validator: (value) {
        if (value == null) {
          return "Campo obligatorio";
        }
        return null;
      },
      borderRadius: BorderRadius.circular(radiusValue),
      items: gendersT.map((e) {
        return DropdownMenuItem<String>(
            child: Text(e["text"] ?? ""), value: e["value"]);
      }).toList(),
      onChanged: (String? value) {
        controller.companyData.gender = value;
      },
    );
  }
}
