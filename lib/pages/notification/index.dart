import 'package:rawatin/components/custom_follow_notification.dart';
import 'package:rawatin/components/custom_liked_notification.dart';
import 'package:flutter/material.dart';
import 'package:rawatin/utils/utils.dart';

class NotitcationTap extends StatelessWidget {
  NotitcationTap({Key? key}) : super(key: key);
  final List newItem = ["liked", "follow"];
  final List todayItem = ["follow", "liked", "liked"];
  final List oldesItem = ["follow", "follow", "liked", "liked"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: RawatinColorTheme.white,
        surfaceTintColor: RawatinColorTheme.white,
        title: const Text('Notifikasi',
            style: TextStyle(
                fontFamily: 'Arial Rounded', fontWeight: FontWeight.w300)),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text("Notifikasi",
              //     style:
              //         TextStyle(fontFamily: 'Arial Rounded', fontSize: 30)),
              const Text("Baru",
                  style: TextStyle(fontFamily: 'Arial Rounded', fontSize: 30)),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: newItem.length,
                itemBuilder: (context, index) {
                  return newItem[index] == "follow"
                      ? const CustomFollowNotifcation()
                      : const CustomLikedNotifcation();
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Hari Ini",
                  style: TextStyle(fontFamily: 'Arial Rounded', fontSize: 30),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: todayItem.length,
                itemBuilder: (context, index) {
                  return todayItem[index] == "follow"
                      ? const CustomFollowNotifcation()
                      : const CustomLikedNotifcation();
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "7 Hari Terakhir",
                  style: TextStyle(fontFamily: 'Arial Rounded', fontSize: 30),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: oldesItem.length,
                itemBuilder: (context, index) {
                  return oldesItem[index] == "follow"
                      ? const CustomFollowNotifcation()
                      : const CustomLikedNotifcation();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
