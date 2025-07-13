import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'college.dart';
import 'data_structure.dart';
import 'exercise.dart';
import 'transaction.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Homepage",
            style: GoogleFonts.nunito(
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => data_structure()));
              },
              title: Wrap(children: [
                CircleAvatar(
                    radius: 10, child: Image.asset("assets/dsa_logo.png")),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Data Structures",
                  style: GoogleFonts.nunito(),
                )
              ]),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => college()));
              },
              title: Wrap(children: [
                CircleAvatar(
                    radius: 10, child: Image.asset("assets/college_logo.png")),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "College",
                  style: GoogleFonts.nunito(),
                )
              ]),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => exercise()));
              },
              title: Wrap(children: [
                CircleAvatar(
                    radius: 10, child: Image.asset("assets/exercise_logo.png")),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Exercise",
                  style: GoogleFonts.nunito(),
                )
              ]),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => transaction()));
              },
              title: Wrap(children: [
                CircleAvatar(
                    radius: 10,
                    child: Image.asset("assets/transaction_logo.png")),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Transaction",
                  style: GoogleFonts.nunito(),
                )
              ]),
            )
          ],
        ));
  }
}
