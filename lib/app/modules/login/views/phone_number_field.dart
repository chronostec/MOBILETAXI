import 'package:flutter/material.dart';
import 'package:alfred_taxi_client/app/common/controllers.dart' show ctlLogin;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhonenumberFIELD extends StatelessWidget {
  PhonenumberFIELD({
    Key? key,
  }) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: InternationalPhoneNumberInput(
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: const TextStyle(color: Colors.black),
            initialValue: ctlLogin.number.value,
            textFieldController: ctlLogin.phoneTF,
            hintText: '01 01 01 01 01',
            formatInput: false,
            keyboardType: TextInputType.phone,
            onInputValidated: (bool value) {},
            inputBorder: InputBorder.none,
            onSaved: (value) {
              print("PHONE NUMBER: ${ctlLogin.phoneNumber.value}");
              ctlLogin.phoneNumber.value = value.phoneNumber.toString();
            },
            onInputChanged: (value) {
              print("PHONE NUMBER: ${ctlLogin.phoneNumber.value}");
              ctlLogin.phoneNumber.value = value.phoneNumber.toString();
            }),
      ),
    );
  }
}

/* 
class PhoneField extends StatelessWidget {
  final hint;

  const PhoneField({Key? key, this.hint = "Téléphone"}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: signinCTL.phoneCTL,
            maxLength: 14,
            onChanged: (value) => print(signinCTL.phoneCTL.text),
            decoration: InputDecoration(
                hintText: hint.toString(),
                prefixIcon: CountryCodePicker(
                  onChanged: (value) =>
                      signinCTL.codeDigit.value = value.toString(),
                  // Initial selection and favorite can be one of code ('CI') OR dial_code('+225')
                  initialSelection: 'CI',
                  favorite: const ['+225', 'CI', "+1", "USA"], showFlag: true,
                  showFlagDialog: true,
                  // optional. Shows only country name and flag
                  showCountryOnly: false,
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed: false,
                  // optional. aligns the flag and the Text left
                  alignLeft: false,
                )),
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
          ),
        ),
      ],
    );
  }
} */