import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SendmessageScreen extends StatefulWidget {
  const SendmessageScreen({Key? key}) : super(key: key);

  @override
  State<SendmessageScreen> createState() => _SendmessageScreenState();
}

class _SendmessageScreenState extends State<SendmessageScreen> {
  Country? selectedCountry;

  void initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      selectedCountry = country;
    });
  }

  TextEditingController phonenumber = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController messagecontroller = TextEditingController();
  @override
  void initState() {
    initCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final country = selectedCountry;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xff25D366),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        title: Text(
          "SEND MESSAGE",
          style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 18.sm,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              top: 30.r,
            ),
            height: 550.sm,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(
                19,
              ),
            ),
            width: 370.sm,
            padding: EdgeInsets.only(
              top: 10.r,
              left: 20.r,
              right: 20.r,
              bottom: 20.r,
            ),
            child: country != null
                ? Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 45.sm,
                        ),
                        Text(
                          "Send a message to any number registred on\nWhatsapp without saving.\nYou can also send a message to yourself.",
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 15.sm,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 65.sm,
                        ),
                        InkWell(
                          onTap: () {
                            onPressedShowBottomSheet();
                          },
                          child: Container(
                            height: 45.sm,
                            width: double.infinity,
                            padding: EdgeInsets.only(
                              top: 10.r,
                              left: 10.r,
                              right: 10.r,
                              bottom: 10.r,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      country.flag,
                                      package: countryCodePackageName,
                                      width: 40,
                                    ),
                                    Text(
                                      '${country.callingCode} ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15.sm),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                  size: 20.sm,
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 25.sm,
                        ),
                        TextFormField(
                          controller: phonenumber,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Mobile Number";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.only(left: 10.r),
                              hintText: "Phone Number",
                              hintStyle: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 15.sm,
                                  fontWeight: FontWeight.w400)),
                        ),
                        SizedBox(
                          height: 25.sm,
                        ),
                        TextFormField(
                          controller: messagecontroller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.only(left: 10.r),
                              hintText: "Write Message (Optional)",
                              hintStyle: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 15.sm,
                                  fontWeight: FontWeight.w400)),
                        ),
                        SizedBox(
                          height: 25.sm,
                        ),
                        InkWell(
                          onTap: () async {
                            if (formkey.currentState!.validate()) {
                              print("object");
                              await launch(
                                  "https://wa.me/${selectedCountry!.callingCode + phonenumber.text}?text=${messagecontroller.text}");
                            }
                          },
                          child: Center(
                            child: Container(
                              height: 40.sm,
                              child: Center(
                                child: Text(
                                  "SEND",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 15.sm,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              width: 140.sm,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
      ),
    );
  }

  void onPressedShowBottomSheet() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      setState(() {
        selectedCountry = country;
      });
    }
  }
}
