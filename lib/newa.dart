import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Newa extends StatefulWidget {
  const Newa({super.key});

  @override
  State<Newa> createState() => _NewaState();
}

class _NewaState extends State<Newa> {
  final _keyForm = GlobalKey<FormState>();
  final nbreController = TextEditingController();
  TextStyle stile = const TextStyle(fontSize: 16);

  var styleOne = const TextStyle(
    color: Colors.black,
    fontSize: 40,
  );
  var styleZero = const TextStyle(
    color: Colors.grey,
    fontSize: 40,
  );
  String valueInput = "";
  String choix = "decimale";
  String binary = "0";
  String decimal = "";
  String hexa = "";
  String octal = "";
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Convert",
          textScaleFactor: 1.2,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.info,
                  animType: AnimType.topSlide,
                  title: "Information",
                  desc:
                      "Convert est une application qui vous aide dans vos conversions.",
                  btnCancelOnPress: () {},
                ).show();
              },
              color: Colors.white,
              icon: const Icon(Icons.info_sharp)),
          IconButton(
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  title: "Attention",
                  desc: "Vous-êtes sure de vouloir sortir de l'application? ",
                  btnOkOnPress: () => SystemNavigator.pop(),
                  btnCancelOnPress: () {},
                ).show();
              },
              color: Colors.white,
              icon: const Icon(Icons.output_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(65),
                border: Border.all(
                  color: Colors.blue,
                  width: 5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 24.0, top: 2),
                    child: Row(
                      children: [
                        Text("0", style: styleZero),
                        Text("1", style: styleOne),
                        Text("0", style: styleZero),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 24.0),
                    margin: const EdgeInsets.only(bottom: 2.0),
                    child: Row(
                      children: [
                        Text("1", style: styleOne),
                        Text("0", style: styleZero),
                        Text("1", style: styleOne),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Form(
              key: _keyForm,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Valeur du nombre",
                              textAlign: TextAlign.center,
                              textScaleFactor: 1.2,
                            ),
                            SizedBox(
                              width: size.width * 0.4,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: "Entrer un nombre",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 30),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Veuillez entrer un nombre";
                                  }
                                  return null;
                                },
                                controller: nbreController,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              "Base du nombre",
                              textAlign: TextAlign.end,
                              textScaleFactor: 1.2,
                            ),
                            SizedBox(
                              width: size.width * 0.4,
                              child: DropdownButtonFormField(
                                items: const [
                                  DropdownMenuItem(
                                      value: 'binaire', child: Text("Binaire")),
                                  DropdownMenuItem(
                                      value: 'decimale',
                                      child: Text("Decimale")),
                                  DropdownMenuItem(
                                      value: 'octal', child: Text("Octale")),
                                  DropdownMenuItem(
                                      value: 'Hexadecimal',
                                      child: Text("Hexadecimal")),
                                ],
                                value: 'decimale',
                                onChanged: (value) {
                                  choix = value!;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 21.0),
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15)),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if (_keyForm.currentState!.validate()) {
                                switch (choix) {
                                  case "binaire":
                                    binary = nbreController.text;
                                    decimal = baseToDecimal(2);
                                    decimalToHexadecimal(decimal);
                                    // binary = decimalToBase(decimal, 2);

                                    octal = decimalToBase(decimal, 8);
                                    break;
                                  case "decimale":
                                    decimal = nbreController.text;
                                    binary = decimalToBase(decimal, 2);
                                    decimalToHexadecimal(decimal);
                                    octal = decimalToBase(decimal, 8);
                                    break;
                                  case "octal":
                                    String o = baseToDecimal(8);
                                    binary = decimalToBase(o, 2);
                                    decimalToHexadecimal(decimal);
                                    octal = decimalToBase(decimal, 8);
                                    break;
                                  case "Hexadecimal":
                                    hexadecimalToDecimal(nbreController.text);
                                    binary = decimalToBase(decimal, 2);
                                    decimalToHexadecimal(decimal);
                                    octal = decimalToBase(decimal, 8);
                                }
                                _isVisible = true;
                              }
                            });
                          },
                          style: const ButtonStyle(),
                          child: const Text(
                            "Valider",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.06),
                    Visibility(
                      visible: _isVisible,
                      child: Card(
                        color: Colors.white,
                        elevation: 30.0,
                        child: SizedBox(
                          width: size.width * 0.85,
                          child: Column(
                            children: [
                              Text(
                                "les valeurs: ".toUpperCase(),
                                style: const TextStyle(fontSize: 25),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text("Decimal:  $decimal", style: stile),
                              const SizedBox(height: 8),
                              Text(
                                "Binaire:  $binary",
                                style: stile,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Hexadecimal: $hexa",
                                style: stile,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Octal: $octal",
                                style: stile,
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Container(
                                width: 100,
                                height: 40,
                                color: Colors.white,
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _isVisible = false;
                                      });
                                    },
                                    child: Text("ok".toUpperCase())),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.06),
                    Text(
                      "Crée par Pessidjo Germann",
                      style: stile,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void decimalToBinary() {
    /*
     * 8/2=4  et reste 0
     * 4/2=2 et reste 0
     * 2/2=1 et reste 0
     * 1/2=0 et reste 1
     * */
    setState(() {
      //DecimaleToBinary();
    });
  }

  String decimalToBase(String t, int base) {
    int d = int.parse(t);
    int reste = 0;
    double quotient = 1;
    List<int> nbre = [];
    while (quotient != 0) {
      reste = d % base; //r=1
      quotient = (d - reste) / base;
      nbre.add(reste);
      d = quotient.toInt();
    }
    //nbre.add(d);
    //print(nbre);
    Iterable<int> o = nbre.reversed;
    return o.join();
  }

  String baseToDecimal(int binar) {
    valueInput = nbreController.text;
    int b = int.parse(valueInput);
    List<int> l = [];
    l = b.toString().split('').map((String digit) {
      return int.parse(digit);
    }).toList(); //Transformer un nombre en liste

    int? nbr = 0;
    Iterable<int> d = l.reversed; //je renverse la liste
    List<int> h = [];
    h.addAll(
        d); //ajoute les elements de la liste iterable en une nouvelle liste de int.
    for (int i = 0; i < h.length; i++) {
      nbr = (nbr! + (pow(binar, i) * h[i])) as int?;
    }
    decimal = nbr.toString();
    return decimal;
  }

  void hexadecimalToDecimal(String hex) {
    List<String> maListe = [];
    Map maMap = {
      'A': 10,
      'a': 10,
      'B': 11,
      'b': 11,
      'C': 12,
      'c': 12,
      'D': 13,
      'd': 13,
      'E': 14,
      'e': 14,
      'F': 15,
      'f': 15,
    };
    maListe = hex.split('');
    int? nbr = 0;
    Iterable<String> d = maListe.reversed; //je renverse la liste
    List<String> newAList = [];
    newAList.addAll(
        d); //ajoute les elements de la liste iterable en une nouvelle liste de int.
    for (int i = 0; i < newAList.length; i++) {
      if (maMap.containsKey(newAList[i])) {
        nbr = (nbr! + (pow(16, i) * maMap[newAList[i]])) as int?;
      } else {
        nbr = (nbr! + (pow(16, i) * int.parse(newAList[i]))) as int?;
      }
    }
    decimal = nbr.toString();
  }

  void decimalToHexadecimal(String t) {
    Map maMap = {10: 'A', 11: 'B', 12: 'C', 13: 'D', 14: 'E', 15: 'F'};
    int d = int.parse(t);
    int reste = 0;
    double quotient = 1;
    List<String> nbre = [];

    while (quotient != 0) {
      reste = d % 16; //r=1
      quotient = (d - reste) / 16;
      if (maMap.containsKey(reste)) {
        nbre.add(maMap[reste]);
      } else {
        nbre.add(reste.toString());
      }
      d = quotient.toInt();
    }
    Iterable<String> o = nbre.reversed;
    hexa = o.join();
  }
}
