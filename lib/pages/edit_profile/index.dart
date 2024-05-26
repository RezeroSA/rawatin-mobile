import 'dart:io';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rawatin/constraint/constraint.dart';
import 'package:rawatin/pages/home/index.dart';
import 'package:rawatin/service/authentication.dart';
import 'package:rawatin/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthenticationService _authenticationService =
      Get.put(AuthenticationService());

  final box = GetStorage();

  String avatar = '';
  bool _isLoading = false;

  Future getProfile() async {
    setState(() {
      _isLoading = true;
    });
    final res =
        await _authenticationService.getProfile(phoneNum: box.read('phoneNum'));

    if (res != null) {
      setState(() {
        _isLoading = false;
        nameController.text = res['name'];
        dateController.text = res['bday'];
        emailController.text = res['email'];
        avatar = res['avatar'] != null ? res['avatar'] : '';
      });
    } else {
      setState(() {
        _isLoading = false;
        nameController.text = res['name'];
        dateController.text = res['bday'];
        emailController.text = res['email'];
        avatar = res['avatar'] != null ? res['avatar'] : '';
      });
    }
  }

  XFile? image = null;

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    if (img != null) {
      setState(() {
        avatar = img!.path;
        image = img;
      });
    }
  }

  final ImagePicker picker = ImagePicker();

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: RawatinColorTheme.white,
            surfaceTintColor: RawatinColorTheme.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text(
              'Pilih media yang akan dipilih',
              style: TextStyle(fontFamily: 'Arial Rounded', fontSize: 20),
            ),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 8,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: RawatinColorTheme.white,
                      surfaceTintColor: RawatinColorTheme.white,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.image,
                          color: RawatinColorTheme.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Dari Galeri',
                          style: TextStyle(color: RawatinColorTheme.black),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: RawatinColorTheme.white,
                      surfaceTintColor: RawatinColorTheme.white,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: RawatinColorTheme.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Dari Kamera',
                          style: TextStyle(color: RawatinColorTheme.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RawatinColorTheme.white,
      appBar: AppBar(
        title: const Text(
          'Ubah Profil',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Arial Rounded',
          ),
        ),
        surfaceTintColor: RawatinColorTheme.white,
        backgroundColor: RawatinColorTheme.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Skeletonizer(
          enabled: _isLoading,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                                color: RawatinColorTheme.orange, width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: avatar == ''
                              ? const Icon(
                                  FontAwesomeIcons.user,
                                  size: 35,
                                )
                              : image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.file(
                                        //to show image, you type like this.
                                        File(image!.path),
                                        fit: BoxFit.fitHeight,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 110,
                                      ),
                                      // child: Image(
                                      //   image: AssetsLocation.imageLocation(
                                      //       'jiro'),
                                      //   height: 110.0,
                                      //   width: 110.0,
                                      //   fit: BoxFit.cover,
                                      //   alignment: Alignment.topCenter,
                                      // ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image(
                                        image:
                                            NetworkImage(onlineAssets + avatar),
                                        height: 110.0,
                                        width: 110.0,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                      ),
                                    ),
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          myAlert();
                        },
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: RawatinColorTheme.orange,
                          child: const Icon(
                            FontAwesomeIcons.plus,
                            size: 18,
                            color: RawatinColorTheme.white,
                          ),
                        ))
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              TextFormField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    suffixIcon: Icon(Icons.person),
                                    labelText: 'Nama Lengkap',
                                    labelStyle: TextStyle(
                                        color: RawatinColorTheme.black),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: RawatinColorTheme.black),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: RawatinColorTheme.black),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Nama tidak boleh kosong';
                                    } else {
                                      return null;
                                    }
                                  }),
                              const SizedBox(
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                              ),
                              TextFormField(
                                readOnly: true,
                                decoration: const InputDecoration(
                                  suffixIcon:
                                      Icon(Icons.calendar_month_outlined),
                                  labelText: 'Tanggal Lahir',
                                  labelStyle:
                                      TextStyle(color: RawatinColorTheme.black),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: RawatinColorTheme.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: RawatinColorTheme.black),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                controller: dateController,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          DateTime.now(), //get today's date
                                      firstDate: DateTime(
                                          2000), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101));

                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd').format(
                                            pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

                                    setState(() {
                                      dateController.text =
                                          formattedDate; //set foratted date to TextField value.
                                    });
                                  } else {}
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Tanggal lahir tidak boleh kosong';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.email_outlined),
                                  labelText: 'Email',
                                  labelStyle:
                                      TextStyle(color: RawatinColorTheme.black),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: RawatinColorTheme.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: RawatinColorTheme.black),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email tidak boleh kosong';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    () async {
                                      var res = await _authenticationService
                                          .updateProfile(
                                              name: nameController.text,
                                              email: emailController.text,
                                              bday: dateController.text,
                                              avatar: image);

                                      if (res == true) {
                                        Get.offAll(() => const Home());
                                        ArtSweetAlert.show(
                                            context: context,
                                            artDialogArgs: ArtDialogArgs(
                                                type: ArtSweetAlertType.success,
                                                title: 'Berhasil',
                                                text:
                                                    'Profil berhasil diperbarui',
                                                confirmButtonText: 'OK',
                                                confirmButtonColor:
                                                    RawatinColorTheme.orange));
                                      } else {}
                                    }();
                                  }
                                },
                                style: TextButton.styleFrom(
                                  minimumSize: const Size.fromHeight(40),
                                  backgroundColor: RawatinColorTheme.orange,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                child: Text('Simpan',
                                    style: RawatinColorTheme
                                        .secondaryTextTheme.titleSmall),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
