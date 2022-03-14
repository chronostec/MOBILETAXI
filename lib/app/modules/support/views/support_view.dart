import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

import '../controllers/support_controller.dart';

class SupportView extends GetView<SupportController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ecrire au support'),
        centerTitle: true,
        // backgroundColor: Colors.grey,
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: ctlSupport.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownSearch<String>(
                  mode: Mode.MENU,
                  items: ctlSupport.mesobjets,
                  onChanged: (value) {
                    ctlSupport.objet.value = value!;
                  },
                  selectedItem: ctlSupport.objet.value,
                  hint: "Choisir objet",
                  label: "Objet",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 35.h,
                  width: 100.w,
                  child: TextFormField(
                    maxLength: 255,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: ctlSupport.messageTF,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Ecrire ici",
                        labelText: "Contenu du message"),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Vous n'avez rien saisi encore!";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 100.w,
                child: CupertinoButton(
                  onPressed: () async {
                    if (ctlSupport.formKey.currentState!.validate()) {
                      ctlSupport.isSending.value
                          ? const Center(
                              child: SpinKitWave(
                                color: Colors.blueGrey,
                              ),
                            )
                          : null;
                      await ctlSupport
                          .postMessage(
                              client_id: 1,
                              objetc: ctlSupport.objet.value,
                              contenu: ctlSupport.messageTF.text)
                          .then((value) async {
                        if (value.message == "succes") {
                          await Alert(
                            context: context,
                            type: AlertType.success,
                            title: "message envoyé",
                            buttons: [
                              DialogButton(
                                child: const Text(
                                  "FERMER",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () {
                                  ctlSupport.messageTF.text = "";
                                  Get.back();
                                },
                                gradient: LinearGradient(
                                    colors: [AppColor.CRED, AppColor.CRED]),
                              )
                            ],
                          ).show();
                        } else {}
                      });
                    }
                  },
                  child: Text(
                    "ENVOYER",
                    style: TextStyle(
                        color: AppColor.CBLACK,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  color: AppColor.CGREY,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
