import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incrementer/data_structure/codechef.dart';
import 'package:incrementer/data_structure/codeforces.dart';
import 'package:incrementer/data_structure/coding_ninja.dart';
import 'package:incrementer/data_structure/gfg.dart';
import 'package:incrementer/data_structure/leetcode.dart';


class data_structure extends StatefulWidget {
  const data_structure({super.key});

  @override
  State<data_structure> createState() => _data_structureState();
}

class _data_structureState extends State<data_structure> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Structures"),
      ),
      body: ListView(
        children: [
          Card(color: Colors.yellow,
            child: ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>gfg()));
              },
              title: Wrap(children: [
                CircleAvatar(radius: 10,child: Image.asset("assets/dsa_logo.png")),SizedBox(width: 10,)
                ,Text("Geeks For Geeks",style: GoogleFonts.nunito(color: Colors.white),)]),

            ),
          ),
          Card(color: Colors.green,
            child: ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>leetcode()));
              },
              title: Wrap(children: [
                CircleAvatar(radius: 10,child: Image.asset("assets/dsa_logo.png")),SizedBox(width: 10,)
                ,Text("Leetcode",style: GoogleFonts.nunito(color: Colors.white),)]),

            ),
          ),
          Card(color: Colors.red,
            child: ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>coding_ninja()));
              },
              title: Wrap(children: [
                CircleAvatar(radius: 10,child: Image.asset("assets/dsa_logo.png")),SizedBox(width: 10,)
                ,Text("Coding Ninja",style: GoogleFonts.nunito(color: Colors.white),)]),

            ),
          ),
          Card(color: Colors.blue,
            child: ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>codeforces()));
              },
              title: Wrap(children: [
                CircleAvatar(radius: 10,child: Image.asset("assets/dsa_logo.png")),SizedBox(width: 10,)
                ,Text("Codeforces",style: GoogleFonts.nunito(color: Colors.white),)]),

            ),
          ),
          Card(color: Colors.orange,
            child: ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>codechef()));
              },
              title: Wrap(children: [
                CircleAvatar(radius: 10,child: Image.asset("assets/dsa_logo.png")),SizedBox(width: 10,)
                ,Text("Codechef",style: GoogleFonts.nunito(color: Colors.white),)]),

            ),
          ),

        ],
      ),
    );
  }
}

