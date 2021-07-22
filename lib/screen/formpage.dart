import 'dart:io';
import 'dart:ui';

import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:first_desktop/common/commontextfield.dart';
import 'package:first_desktop/model/datamodel.dart';
import 'package:first_desktop/screen/savedlist.dart';
import 'package:first_desktop/path/getdirectory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:path/path.dart' as path;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String path1;

  bool _loading = false;
  bool saved = false;
  File result;
  String name;
  String message;
  String email;
  String phone;

  FilePickerCross filePickerCross;
  Set<String> lastFiles;
  FileQuotaCross quota = FileQuotaCross(quota: 0, usage: 0);
  
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/blackWave.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Material(
                      elevation: 5,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      border: Border.all(color: Colors.black),
                                      image: DecorationImage(
                                          image: AssetImage(
                                            "assets/18350-stay-home.gif",
                                          ),
                                          fit: BoxFit.cover)),
                                )),
                            Expanded(
                              flex: 3,
                              child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  color: Colors.black.withOpacity(0.1),
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1),
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1),
                                            CommonTextFieldWidget(
                                              controller: nameController,
                                              keyboardType: TextInputType.text,
                                              hintText: "Full Name",
                                              obscureText: false,
                                              node: node,
                                              suffix: false,
                                              suffixIcon: Icons.person,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  name = "Enter Your name";
                                                  message = null;
                                                  email = null;
                                                  phone = null;
                                                  return "";
                                                } else {
                                                  name = null;
                                                  return null;
                                                }
                                              },
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            CommonTextFieldWidget(
                                              controller: emailController,
                                              keyboardType: TextInputType.text,
                                              hintText: "Email",
                                              obscureText: false,
                                              node: node,
                                              suffix: false,
                                              suffixIcon: Icons.email,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  email = "Enter Your email";
                                                  phone = null;
                                                  return "";
                                                } else {
                                                  email = null;
                                                  return null;
                                                }
                                              },
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            CommonTextFieldWidget(
                                              controller: phoneController,
                                              keyboardType: TextInputType.phone,
                                              hintText: "Mobile Number",
                                              obscureText: false,
                                              node: node,
                                              suffix: false,
                                              suffixIcon: Icons.phone,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  phone =
                                                      "Enter Your Mobile Number";
                                                  return "";
                                                } else if (value.length != 10) {
                                                  phone =
                                                      "Please Enter 10 digit Mobile Number";
                                                  return "";
                                                } else {
                                                  phone = null;
                                                  return null;
                                                }
                                              },
                                            ),
                                            SizedBox(
                                              height: 40,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.050,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xff171717),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.010,
                                                        )),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.010,
                                                      ),
                                                      child: MaterialButton(
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.010,
                                                            vertical: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.010,
                                                          ),
                                                          child: FittedBox(
                                                            fit:
                                                                BoxFit.fitWidth,
                                                            child: Text(
                                                              "Pick an image",
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          final file =
                                                              await selectFile(
                                                                  context);

                                                          setState(() {
                                                            result = File(file);
                                                          });
                                                        },
                                                      ),
                                                    )),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.030,
                                                ),
                                                result == null
                                                    ? Container()
                                                    : Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.08,
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: Image.file(
                                                          File(result.path),
                                                          fit: BoxFit.contain,
                                                        ),
                                                      )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Container(
                                              height: 50,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Color(0xff171717),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: CupertinoButton(
                                                  onPressed: () async {
                                                    if (_formKey.currentState
                                                            .validate() &&
                                                        result != null) {
                                                      setState(() {
                                                        _loading = true;
                                                      });
                                                      final id = Localstore
                                                          .instance
                                                          .collection('paras')
                                                          .doc()
                                                          .id;
                                                      path1 = Localstore
                                                          .instance
                                                          .collection('paras')
                                                          .path;

                                                      var basNameWithExtension =
                                                          path.basename(
                                                              result.path);
                                                      final File newImage = await File(
                                                              result.path)
                                                          .copy(await GetDirectory()
                                                                  .createFolder() +
                                                              '$basNameWithExtension');

                                                      final item = Todo(
                                                          id: id,
                                                          name: nameController
                                                              .text,
                                                          email: emailController
                                                              .text,
                                                          mobile:
                                                              phoneController
                                                                  .text,
                                                          imagePath:
                                                              newImage.path);
                                                      try {
                                                        item.save();
                                                      } catch (e) {
                                                        print(e.toString());
                                                      }
                                                      setState(() {
                                                        _loading = false;
                                                        saved = false;
                                                        result = null;
                                                        nameController.clear();
                                                        emailController.clear();
                                                        phoneController.clear();
                                                      });
                                                    } else {
                                                      if (result == null) {
                                                        setState(() {
                                                          message =
                                                              "Please select an image";
                                                        });
                                                      } else {
                                                        message = null;
                                                      }

                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: Text(name ??
                                                            email ??
                                                            phone ??
                                                            message),
                                                      ));
                                                    }

                                                    //_items.putIfAbsent(item.id, () => item);
                                                  },
                                                  child: Center(
                                                    child: _loading
                                                        ? CircularProgressIndicator()
                                                        : Text(
                                                            "Save",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                  )),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            )
                          ],
                        ),
                      ))),
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => SavedList(),
                ));
          },
          backgroundColor: Color(0xff171717),
          label: floatingButton(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Row floatingButton() {
    return Row(
      children: [
        Text(
          "Go to Saved List",
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          width: 15,
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 14,
        )
      ],
    );
  }

  Future<String> selectFile(context) async {
    FilePickerCross myFile = await FilePickerCross.importFromStorage(
      type: FileTypeCross.any,
    );

    print("This is Selected File Path ${myFile.path}");
    return myFile.path;
  }
}
