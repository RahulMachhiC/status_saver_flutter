import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:status_saver/screens/privacypolicyscreen.dart';
import 'package:status_saver/screens/recentstatuswa.dart';
import 'package:status_saver/screens/sendmessagescreen.dart';
import 'package:status_saver/screens/statusforwb.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    requestpermission();

    super.initState();
  }

  void requestpermission() async {
    if (await Permission.manageExternalStorage.isDenied) {
      Permission.manageExternalStorage.request();
    }

    if (await Permission.storage.isDenied) {
      Permission.storage.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldkey,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xff25D366),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "STATUS SAVER",
          style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 18.sm,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  if (whatsapp.existsSync()) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RecentStatusWAScreen()));
                  } else {
                    Fluttertoast.showToast(
                        msg: "Whatsapp is Not Installed In Your Device");
                  }
                },
                child: Container(
                  height: 130.sm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.whatsapp,
                        color: Colors.black,
                        size: 60.sm,
                      ),
                      Text(
                        "WA STATUS",
                        style: GoogleFonts.montserrat(
                            color: Colors.black, fontSize: 13.sp),
                      )
                    ],
                  ),
                  width: 130.sm,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                    color: Color(0xFFE0E0E0),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  whatsappbusiness.listSync().map((e) {
                    print(e.path);
                  });
                  if (whatsappbusiness.existsSync()) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => StatusforWB()));
                  } else {
                    Fluttertoast.showToast(
                        msg:
                            "Whatsapp Business Is Not Installed In Your Device");
                  }
                },
                child: Container(
                  height: 130.sm,
                  width: 130.sm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/7417365_whatsapp business_whatsapp_chat_communication_icon.png",
                        height: 70.sm,
                        width: 70.sm,
                      ),
                      Text(
                        "WB STATUS",
                        style: GoogleFonts.montserrat(
                            color: Colors.black, fontSize: 13.sp),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                    color: Colors.grey.shade300,
                  ),
                ),
              )
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SendmessageScreen(),
                ),
              );
            },
            child: Container(
              height: 130.sm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/images/send.webp",
                    height: 65.sm,
                    width: 65.sm,
                  ),
                  Text(
                    "SEND MESSAGE",
                    style: GoogleFonts.montserrat(
                        color: Colors.black, fontSize: 13.sp),
                  )
                ],
              ),
              width: 130.sm,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  15,
                ),
                color: Colors.grey.shade300,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PrivacyPolicyScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 50.sm,
                  width: 50.sm,
                  child: Center(
                    child: Icon(
                      Icons.info,
                      color: Colors.black,
                      size: 30.sm,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Container(
                height: 50.sm,
                width: 50.sm,
                child: Center(
                  child: Icon(
                    Icons.star,
                    color: Colors.black,
                    size: 30.sm,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                height: 50.sm,
                child: Icon(
                  Icons.share,
                  color: Colors.black,
                  size: 30.sm,
                ),
                width: 50.sm,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
