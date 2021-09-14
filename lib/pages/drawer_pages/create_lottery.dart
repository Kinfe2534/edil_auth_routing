// gratitude.dart
import 'dart:convert';

import 'package:edil/model/lottery_model.dart';
import 'package:edil/service/form_bloc.dart';
import 'package:edil/service/http_response_message.dart';
import 'package:edil/service/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class CreateLottery extends StatefulWidget {
  const CreateLottery({Key key}) : super(key: key);

  @override
  _CreateLotteryState createState() => _CreateLotteryState();
}

class _CreateLotteryState extends State<CreateLottery> {
  TextEditingController dateinput = TextEditingController();
  GlobalKey<FormState> _createLotteryFormStateKey = GlobalKey<FormState>();
  CreateLotteryModel createLottery = new CreateLotteryModel();
  String lotteyType;
  void _submitCreateLottery(FormBloc formBloc) async {
    if (_createLotteryFormStateKey.currentState.validate()) {
      _createLotteryFormStateKey.currentState.save();

      http.Response res =
          await formBloc.httpService.createLottery(createLottery);
      try {
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body) as Map<String, dynamic>;
          formBloc.addHttpResponseMessage(data["message"]);
          Navigator.pop(context);
        } else {
          final data = jsonDecode(res.body) as Map<String, dynamic>;
          formBloc.addHttpResponseMessage(data["message"]);
          print(res.statusCode);
          print(data['message']);
          throw Exception("Esception in create lottery");
        }
      } catch (e) {
        print("Exception happened in Create Lottey");
      }
    }
  }

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> lotteryTypeList = ["JACKPOT", "LOTO"];
    FormBloc formBloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Lottery'),
      ),
      body: SafeArea(
        child: Form(
          key: _createLotteryFormStateKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Text("Lottery Type")),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: DropdownButtonFormField(
                        value: lotteyType,
                        hint: Text("Choose Lottery Type"),
                        /* validator: (value) {
                        return value == null ? "empty" : null;
                      },*/
                        items: lotteryTypeList.map((e) {
                              return DropdownMenuItem<String>(
                                child: Text(e.toString()),
                                value: e.toString(),
                              );
                            })?.toList() ??
                            [],
                        onChanged: (value) {
                          setState(() {
                            createLottery.type = value;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            createLottery.type = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Text("Lottery Date")),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: GestureDetector(
                        onTap: () async {
                          DateTime pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2025),
                            initialEntryMode: DatePickerEntryMode.input,
                          );
                          if (pickedDate != null) {
                            String isoDate =
                                pickedDate.toUtc().toIso8601String();
                            // String formattedDate =
                            // DateFormat('yyyy-MM-dd HH:mm:ss')
                            //   .format(pickedDate);
                            setState(() {
                              dateinput.text = isoDate;
                              // formattedDate; //set output date to TextField value.
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: dateinput,
                            /*onTap: () async {
                              DateTime pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2025),
                                initialEntryMode: DatePickerEntryMode.input,
                              );
                              if (pickedDate != null) {
                                String isoDate = pickedDate.toUtc().toIso8601String();
                                // String formattedDate =
                                // DateFormat('yyyy-MM-dd HH:mm:ss')
                                //   .format(pickedDate);
                                setState(() {
                                  dateinput.text = isoDate;
                                  // formattedDate; //set output date to TextField value.
                                });
                              }
                            },*/
                            onChanged: (value) {
                              setState(() {
                                lotteyType = value;
                              });
                            },
                            onSaved: (value) {
                              setState(() {
                                createLottery.lot_day = dateinput.text;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text("Prize")),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                            labelText: 'Lottery Prize',
                            hintText: ""),
                        onSaved: (value) {
                          setState(() {
                            createLottery.prize = int.tryParse(value);
                          });
                        },
                        validator: (value) {
                          return null;
                        },
                        maxLength: 4,
                      )),
                ]),
              ),
              Divider(),
              Container(
                width: 300,
                height: 150,
                child: HttpResponseMessage.AddHttpResponse(formBloc),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  child: Text('Create Lottery'),
                  style: TextButton.styleFrom(
                    primary: Colors.green,
                    backgroundColor: Colors.lightGreen.shade100,
                    onSurface: Colors.pink,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    textStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontStyle: FontStyle.italic),
                  ),
                  onPressed: () => _submitCreateLottery(formBloc),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
