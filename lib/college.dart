import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'college/ai.dart';
import 'college/cd.dart';
import 'college/cg.dart';
import 'college/cmc.dart';
import 'college/cns.dart';
import 'college/ml.dart';

class college extends StatefulWidget {
  const college({super.key});

  @override
  State<college> createState() => _collegeState();
}

class _collegeState extends State<college> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("College"),
      ),
      body: ListView(
        children: [
          Card(color: Colors.yellow,
            child: ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ai()));
              },
              title: Wrap(children: [
                CircleAvatar(radius: 10,child: Image.asset("assets/dsa_logo.png")),SizedBox(width: 10,)
                ,Text("Artificial Intelligence",style: GoogleFonts.nunito(color: Colors.white),)]),

            ),
          ),
          Card(color: Colors.green,
            child: ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>cd()));
              },
              title: Wrap(children: [
                CircleAvatar(radius: 10,child: Image.asset("assets/dsa_logo.png")),SizedBox(width: 10,)
                ,Text("Compiler Design",style: GoogleFonts.nunito(color: Colors.white),)]),

            ),
          ),
          Card(color: Colors.red,
            child: ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>cg()));
              },
              title: Wrap(children: [
                CircleAvatar(radius: 10,child: Image.asset("assets/dsa_logo.png")),SizedBox(width: 10,)
                ,Text("Computer Graphics",style: GoogleFonts.nunito(color: Colors.white),)]),

            ),
          ),
          Card(color: Colors.blue,
            child: ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>cmc()));
              },
              title: Wrap(children: [
                CircleAvatar(radius: 10,child: Image.asset("assets/dsa_logo.png")),SizedBox(width: 10,)
                ,Text("CMC",style: GoogleFonts.nunito(color: Colors.white),)]),

            ),
          ),
          Card(color: Colors.orange,
            child: ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>cns()));
              },
              title: Wrap(children: [
                CircleAvatar(radius: 10,child: Image.asset("assets/dsa_logo.png")),SizedBox(width: 10,)
                ,Text("Cryptography and Network Security",style: GoogleFonts.nunito(color: Colors.white),)]),

            ),
          ),
          Card(color: Colors.purple,
            child: ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ml()));
              },
              title: Wrap(children: [
                CircleAvatar(radius: 10,child: Image.asset("assets/dsa_logo.png")),SizedBox(width: 10,)
                ,Text("Machine Learning",style: GoogleFonts.nunito(color: Colors.white),)]),

            ),
          ),

        ],
      ),
    );
  }
}

    