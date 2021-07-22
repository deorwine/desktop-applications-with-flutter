import 'dart:async';
import 'dart:io';
import 'package:first_desktop/model/datamodel.dart';
import 'package:first_desktop/path/getdirectory.dart';
import 'package:first_desktop/screen/formpage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

class SavedList extends StatefulWidget {
  SavedList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  File updatedFile;
  int pageNumber = 0;
  int perPage = 10;
  final _db = Localstore.instance;
  final _items = <String, Todo>{};
  StreamSubscription<Map<String, dynamic>> _subscription;
  double paginatlength;
  int paginatLength;
  var path;
  int selected = 0;
  List paginatedList = [];
  var chunks = [];
  var indexx;
  Todo item2;

  getDirectory() async {
    path = await GetDirectory().createDirecory();
  }

  getCollection() {
    _db.collection('paras').get().then((value) {
      setState(() {
        value?.entries.forEach((element) {
          final item = Todo.fromMap(element.value);
          _items.putIfAbsent(item.id, () => item);
        });
      });
    });
  }

  @override
  void initState() {
    getDirectory();
    getCollection();
    //  print("thsis is collection ${_db.collection('paras').get()}");
// try{
//   _subscription = _db.collection('paras').stream.listen((event) {
//     print("this nis event $event");
//     setState(() {
//       final item = Todo.fromMap(event);
//       _items.putIfAbsent(item.id, () => item);
//     });
//   });
// }catch(e){
//   print("thoisinsins is error ${e.toString()}");
//}
//     if (kIsWeb) _db.collection('paras').stream.asBroadcastStream();
    super.initState();
  }

  addAllList() {
    paginatedList.clear();
    for (int i = 0; i <= _items.keys.length - 1; i++) {
      setState(() {
        paginatedList.add(_items.keys.elementAt(i));
      });
    }
  }

  getPaginatedList() {
    chunks.clear();
    for (var i = 0; i < paginatedList.length; i += perPage) {
      setState(() {
        chunks.add(paginatedList.sublist(
            i,
            i + perPage > paginatedList.length
                ? paginatedList.length
                : i + perPage));
      });
    }

    return chunks;
  }

  int selectedIndex = -1;
  bool selectValue = false;
  @override
  Widget build(BuildContext context) {
    addAllList();
    getPaginatedList();
    paginatlength = _items.keys.length / perPage;
    paginatLength = paginatlength.ceil();
    return Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          title: Text("Saved List"),
          backgroundColor: Color(0xff171717),
        ),
        body: Column(
          children: [
            Expanded(
                flex: 9,
                child: chunks == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                              showCheckboxColumn: false,
                              dataRowHeight: 65,
                              headingTextStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              decoration: BoxDecoration(color: Colors.white),
                              columns: [
                                DataColumn(
                                    label: SingleChildScrollView(
                                        child: Text(
                                  "Serial No.",
                                  overflow: TextOverflow.ellipsis,
                                ))),
                                DataColumn(
                                    label: SingleChildScrollView(
                                        child: Text(
                                  "Name",
                                  overflow: TextOverflow.ellipsis,
                                ))),
                                DataColumn(
                                    label: SingleChildScrollView(
                                        child: Text(
                                  "Email Address",
                                  overflow: TextOverflow.ellipsis,
                                ))),
                                DataColumn(
                                    label: SingleChildScrollView(
                                        child: Text(
                                  "Mobile No.",
                                  overflow: TextOverflow.ellipsis,
                                ))),
                                DataColumn(
                                    label: SingleChildScrollView(
                                        child: Text(
                                  "Image",
                                  overflow: TextOverflow.ellipsis,
                                ))),
                              ],
                              rows: List.generate(
                                  chunks.isEmpty
                                      ? 0
                                      : chunks[pageNumber].length, (index) {
                                final key = chunks[pageNumber].elementAt(index);
                                var item = _items[key];
                                indexx = paginatedList.indexOf(key);
                                return DataRow(
                                    selected: index == selectedIndex,
                                    onSelectChanged: (val) {
                                      print(val);
                                      if (val) {
                                        setState(() {
                                          item2 = item;
                                          selectedIndex = index;
                                          selectValue = true;
                                        });
                                      } else {
                                        setState(() {
                                          selectedIndex = -1;
                                          selectValue = false;
                                        });
                                      }
                                    },
                                    cells: [
                                      DataCell(
                                        SingleChildScrollView(
                                          child: Text(
                                            (indexx + 1).toString(),
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Color(0xff171717)),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        SingleChildScrollView(
                                          child: Text(
                                            item.name,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Color(0xff171717)),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          item.email,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color(0xff171717)),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          item.mobile,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color(0xff171717)),
                                        ),
                                      ),
                                      DataCell(
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  item2 = item;
                                                });
                                                showImageDialog(context, item2);
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Image.file(
                                                  File(item.imagePath),
                                                  height: 30,
                                                  width: 30,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  print(item.id);
                                                  var indexx1 = paginatedList
                                                      .indexOf(item.id);
                                                  showEditDialog(
                                                      context,
                                                      (indexx1 + 1).toString(),
                                                      item);
                                                });
                                              },
                                              icon: Icon(Icons.edit),
                                              iconSize: 15,
                                              splashRadius: 15,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10.0),
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    item.delete();
                                                    _items.remove(item.id);
                                                  });
                                                },
                                                icon: Icon(Icons.delete),
                                                iconSize: 15,
                                                splashRadius: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]);
                              })),
                        ),
                      )),
            Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    paginatLength,
                    (index) => Container(
                      margin: EdgeInsets.all(10),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: selected == index
                              ? Colors.white
                              : Color(0xff171717),
                          borderRadius: BorderRadius.circular(5)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                pageNumber = index;
                                selected = index;
                              });
                            },
                            child: Center(
                                child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                  color: selected == index
                                      ? Color(0xff171717)
                                      : Colors.white,
                                  fontSize: 16),
                            ))),
                      ),
                    ),
                  ),
                ))
          ],
        ));
  }

  showImageDialog(BuildContext context, var item) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        print(item);
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.75,
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(File(item.imagePath)),
                      fit: BoxFit.contain),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, -0.15)).animate(anim),
          child: child,
        );
      },
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  showEditDialog(BuildContext context, String serialNumber, Todo item3) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setStatee) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1,
                    vertical: MediaQuery.of(context).size.height * 0.2,
                  ),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DataTable(
                            showCheckboxColumn: false,
                            dataRowHeight: 65,
                            headingTextStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: BoxDecoration(color: Colors.white),
                            columns: [
                              DataColumn(
                                  label: SingleChildScrollView(
                                      child: Text(
                                        "Serial No.",
                                        overflow: TextOverflow.ellipsis,
                                      ))),
                              DataColumn(
                                  label: SingleChildScrollView(
                                      child: Text(
                                        "Name",
                                        overflow: TextOverflow.ellipsis,
                                      ))),
                              DataColumn(
                                  label: SingleChildScrollView(
                                      child: Text(
                                        "Email Address",
                                        overflow: TextOverflow.ellipsis,
                                      ))),
                              DataColumn(
                                  label: SingleChildScrollView(
                                      child: Text(
                                        "Mobile No.",
                                        overflow: TextOverflow.ellipsis,
                                      ))),
                              DataColumn(
                                  label: SingleChildScrollView(
                                      child: Text(
                                        "Image",
                                        overflow: TextOverflow.ellipsis,
                                      ))),
                            ],
                            rows: [
                              DataRow(cells: [
                                DataCell(
                                  SingleChildScrollView(
                                    child: Text(
                                      serialNumber,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontSize: 15, color: Color(0xff171717)),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SingleChildScrollView(
                                    child: TextFormField(
                                      controller: nameController,
                                      decoration: InputDecoration(
                                        hintText: item3.name,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      hintText: item3.email,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  TextFormField(
                                    controller: phoneController,
                                    decoration: InputDecoration(
                                      hintText: item3.mobile,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  GestureDetector(
                                    onTap: () async {
                                      final file = await MyHomePage()
                                          .createState()
                                          .selectFile(context);
                                      setStatee(() {
                                        updatedFile = File(file);
                                      });
                                      //  showLocaleDialog(context, item2);
                                    },
                                    child: Container(
                                      child: Image.file(
                                        updatedFile ?? File(item3.imagePath),
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                )
                              ])
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.030,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 20),
                                  decoration: BoxDecoration(
                                      color: Color(0xff171717),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: MaterialButton(
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Save",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      onPressed: () {
                                        print(item3.id);
                                        print(nameController.text != null
                                            ? nameController.text
                                            : item3.name);
                                        final item = Todo(
                                            id: item3.id,
                                            name: nameController.text?.isNotEmpty ??
                                                true
                                                ? nameController.text
                                                : item3.name,
                                            email:
                                            emailController.text?.isNotEmpty ??
                                                true
                                                ? emailController.text
                                                : item3.email,
                                            mobile:
                                            phoneController.text?.isNotEmpty ??
                                                true
                                                ? phoneController.text
                                                : item3.mobile,
                                            imagePath: updatedFile != null
                                                ? updatedFile.path
                                                : item3.imagePath);
                                        item.save();
                                        setState(() {
                                          pageNumber = 0;
                                          // _items.remove(item2.id);
                                        });
                                        Navigator.pop(context);
                                        updatedFile = null;
                                      },
                                    ),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  decoration: BoxDecoration(
                                      color: Color(0xff171717),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: MaterialButton(
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        updatedFile = null;
                                      },
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.030,
                          ),
                        ],
                      ),
                    ),
                  )
                ),
              ),
            );
          });
        });
  }

  @override
  void dispose() {
    if (_subscription != null) _subscription?.cancel();
    super.dispose();
  }
}

