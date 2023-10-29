// ignore_for_file: sort_child_properties_last, unused_element, unnecessary_null_comparison, non_constant_identifier_names, deprecated_member_use, depend_on_referenced_packages

import 'dart:html' as File;

import 'dart:io' as File;
import 'dart:io';
import 'dart:io' as io;
import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:universal_html/html.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';
import 'package:flutter_application_1/add.dart';

import 'dart:math';

class Proposal extends StatefulWidget {
  const Proposal({super.key});

  @override
  _ProposalState createState() => _ProposalState();
}

TextEditingController _titleController1 = TextEditingController();
TextEditingController _type1Controller1 = TextEditingController();
TextEditingController _categoryControlle1 = TextEditingController();
TextEditingController _industrialpartnerController1 = TextEditingController();
TextEditingController _problemstatementController1 = TextEditingController();
TextEditingController _objectiesController1 = TextEditingController();
TextEditingController _probbackgroundController1 = TextEditingController();
TextEditingController _proposedsolutionController1 = TextEditingController();
TextEditingController _relatedtechnologiesController1 = TextEditingController();

TextEditingController _proposedtoolsController1 = TextEditingController();
TextEditingController _proposedmethodogiesController1 = TextEditingController();
TextEditingController _projectrationaleController1 = TextEditingController();
TextEditingController _scheduleController1 = TextEditingController();

var projecttype;

class _ProposalState extends State<Proposal> {
  bool checkedValue1 = false;
  bool checkedValue2 = false;
  bool checkedValue3 = false;
  bool checkedValue4 = false;
  bool checkedValue5 = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _groupValue = -1;
  var category;

  List listitem = [
    'Industrial',
    'Textile related',
    'Research and Development',
    'Freelancing Project',
    'Own Idea'
  ];

  List<Map> projectcategory = [
    {'Field': 'Web Based', "isChecked": false},
    {'Field': 'Mobile App', "isChecked": false},
    {
      'Field': 'Computer Application',
      "isChecked": false,
    },
    {'Field': 'Research and Development', "isChecked": false},
    {'Field': 'Others', "isChecked": false},
  ];

  String imageurl = '';

  String generateRandomString(int length) {
    final random = Random();
    const availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();

    return randomString;
  }

  // uploadtostorage() {
  //   FileUploadInputElement() => InputElement(type: 'file');
  //   InputElement input = FileUploadInputElement()..accept = 'images/*';
  //   FirebaseStorage fs = FirebaseStorage.instance;
  //   input.click();
  //   input.onChange.listen((event) {
  //     final file = input.files!.first;
  //     final reader = FileReader();
  //     reader.readAsDataUrl(file);

  //     reader.onLoadEnd.listen((event) async {
  //       var snapshot =
  //           await fs.ref().child(generateRandomString(5)).putBlob(file);

  //       String downloadurl = await snapshot.ref.getDownloadURL();
  //       setState(() {
  //         imageurl = downloadurl;
  //       });
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext dx) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 232, 242, 244),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              Center(
                child: Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 250),
                  child: Column(children: <Widget>[
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 57, 120, 125),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: const [
                                SizedBox(
                                  width: 45,
                                ),
                                Text(
                                  'BSIT FYP Proposal Submission',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "* Required ",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Main Topic Details",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                        color:
                                            Color.fromARGB(255, 57, 120, 125),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    const Text(
                                      '2. Document Upload *',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        'Only images',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                        height: 50,
                                        width: double.infinity,
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.grey[100],
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30,
                                                        vertical: 15)),
                                            child: const Text("Upload File",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15)),
                                            onPressed: () {
                                              // uploadtostorage();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        'File number limit: 1, Single file size limit: 10MB, Allowed file types: Images',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                        height: 40,
                                        width: 170,
                                        child: ElevatedButton(
                                          child: const Text('Submit'),
                                          onPressed: () {
                                            setState(() {
                                              var db = FirebaseFirestore
                                                  .instance
                                                  .collection("zeeshan");

                                              db.add({
                                                "url": imageurl,
                                              });

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Test()),
                                              );
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: const Color.fromARGB(
                                                  255, 57, 120, 125),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 60,
                                                      vertical: 20),
                                              textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        )),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                        height: 40,
                                        width: 170,
                                        child: ElevatedButton(
                                          child: const Text('View Image'),
                                          onPressed: () {
                                            setState(() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Test()),
                                              );
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: const Color.fromARGB(
                                                  255, 57, 120, 125),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 60,
                                                      vertical: 20),
                                              textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ))
                                  ],
                                ),
                              )),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ],
          ),
        )));
  }

  void StoreProposal() {
    var db = FirebaseFirestore.instance.collection("Zeeshan");

    db.add({
      "url": imageurl,
    });
  }
}

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  List<Widget> itemPhotosWidgetList = <Widget>[];

  late final String title;

  final ImagePicker _picker = ImagePicker();

  late io.File file;
  List<XFile>? photo = <XFile>[];
  List<XFile> itemImagesList = <XFile>[];

  List<String> downloadUrl = <String>[];

  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    double _screenwidth = MediaQuery.of(context).size.width,
        _screenheight = MediaQuery.of(context).size.height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 480) {
        return displayPhoneUploadFormScreen(_screenwidth, _screenheight);
      } else {
        return displayWebUploadFormScreen(_screenwidth, _screenheight);
      }
    });
  }

  displayPhoneUploadFormScreen(_screenwidth, _screenheight) {
    return Container();
  }

  displayWebUploadFormScreen(_screenwidth, _screenheight) {
    return OKToast(
        child: Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100.0,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white70,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(0.0, 0.5),
                    blurRadius: 30.0,
                  )
                ]),
            width: 400,
            height: 50.0,
            child: Center(
              child: itemPhotosWidgetList.isEmpty
                  ? Center(
                      child: MaterialButton(
                        onPressed: pickPhotoFromGallery,
                        child: Container(
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.file_upload_outlined,
                                  size: 30,
                                ),
                                Text('Upload File'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Wrap(
                        spacing: 5.0,
                        direction: Axis.horizontal,
                        children: itemPhotosWidgetList,
                        alignment: WrapAlignment.spaceEvenly,
                        runSpacing: 10.0,
                      ),
                    ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 40,
                width: 170,
                child: ElevatedButton(
                  onPressed: uploading
                      ? null
                      : () {
                          upload();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Test()),
                          );
                        },
                  child: uploading
                      ? const SizedBox(
                          child: CircularProgressIndicator(),
                          height: 15.0,
                        )
                      : const Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 57, 120, 125),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 40,
                  width: 170,
                  child: ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Test()),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 57, 120, 125),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 20),
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  )),
            ],
          ),
        ],
      ),
    ));
  }

  addImage() {
    for (var bytes in photo!) {
      itemPhotosWidgetList.add(Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          height: 90.0,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              child: Column(
                children: const [
                  Text('File Attached'),

                  // kIsWeb
                  //     ? Image.network(io.File(bytes.path).path)
                  //     : Image.file(
                  //         io.File(bytes.path),
                  //       ),
                ],
              ),
            ),
          ),
        ),
      ));
    }
  }

  pickPhotoFromGallery() async {
    photo = await _picker.pickMultiImage();
    if (photo != null) {
      setState(() {
        itemImagesList = itemImagesList + photo!;
        addImage();
        photo!.clear();
      });
    }
  }

  upload() async {
    String productId = await uplaodImageAndSaveItemInfo();
    setState(() {
      uploading = false;
    });
    showToast("Image Uploaded Successfully");
  }

  Future<String> uplaodImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });
    PickedFile? pickedFile;
    String? productId = const Uuid().v4();
    for (int i = 0; i < itemImagesList.length; i++) {
      file = io.File(itemImagesList[i].path);
      pickedFile = PickedFile(file.path);

      await uploadImageToStorage(pickedFile, productId);
    }
    return productId;
  }

  uploadImageToStorage(PickedFile? pickedFile, String productId) async {
    String? pId = const Uuid().v4();
    Reference reference =
        FirebaseStorage.instance.ref().child('Items/$productId/product_$pId');
    await reference.putData(
      await pickedFile!.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    );
    String value = await reference.getDownloadURL();
    downloadUrl.add(value);
    var db = FirebaseFirestore.instance.collection("zeeshan");

    db.add({
      "url": value,
    });
  }
}
