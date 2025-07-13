import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class utility {
  static Future<void> launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  static List<String> monthNames = ["","January", "February","March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

  static PreferredSizeWidget  app_bar(BuildContext context,Color c, String t){
    return AppBar(
      backgroundColor: c,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          )),
      title: Text(
        t,
        style: GoogleFonts.nunito(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    );
  }

  static Widget floating_action(String youtube_url, String docs_url,BuildContext context,String h1,String h2,String h3,String h4,String c1,String c2,String c3,String c4){
    return Stack(
      children: [
        floating_action_button_element(16,youtube_url,"assets/youtube.png",Colors.red),
        floating_action_button_element(86,docs_url,"assets/gdocs.png",Colors.blue),
        bottom_sheet(156,context, h1, h2, h3, h4, c1, c2, c3, c4)
      ],
    );
  }

  static Widget floating_action_button_element(double position,String docs_url_for_element , String logo_path,Color glowcolor){
    return Positioned(
      bottom: 16,
      right: position,
      child: SizedBox(
        height: 50,
        width: 50,
        child: AvatarGlow(
          glowColor: glowcolor,
          child: FloatingActionButton(
            onPressed: () {
              utility.launchURL(docs_url_for_element);
            },
            backgroundColor: Colors.white,
            child: Image.asset(logo_path,height: 30,),
          ),
        ),
      ),
    );
  }

  static Future<void> deleteData(String docId,String collection_name) async {
      await FirebaseFirestore.instance.collection(collection_name).doc(docId).delete();
  }

  static Future<void> pickDate(
      BuildContext context,
      Color c,
      //DateTime selectedDate,
      Function(DateTime) onDateSelected, // Callback to update the state
      ) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: c, // Header background color
            hintColor: c, // Selection color
            colorScheme: ColorScheme.light(primary: c),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      onDateSelected(pickedDate); // Call the callback with the selected date
    }
  }

  static Future<void> saveData(

      TextEditingController _textController,
      TextEditingController _youtubeUrlController,
      TextEditingController _problemLinkController,
      bool _showTextField,
      String collection_name,
      ) async {

    if (_textController.text.isNotEmpty &&
        _youtubeUrlController.text.isNotEmpty &&
        _problemLinkController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection(collection_name).add({
        'text': _textController.text,
        'youtubeUrl': _youtubeUrlController.text,
        'problemLink': _problemLinkController.text,
        'timestamp': Timestamp.now(), // For recent order sorting
      });
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Data added successfully!')),
      // );
      _textController.clear();
      _youtubeUrlController.clear();
      _problemLinkController.clear();
      // setState(() {
      //   _showTextField = false;
      // });
    }
  }


  static  Future<void> submitData(
      TextEditingController _controller,
      bool _showTextField,
      String collection_name,

      ) async {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      await FirebaseFirestore.instance.collection(collection_name).add({
        'text': text,
        'date': Timestamp.now(),
      });

      _controller.clear(); // Clear the TextField

    }
  }

  static Widget show_data_coding(BuildContext context,String collection_name,Color border_color , Color container_color, DateTime? _selectedDate,  String _searchText){
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(collection_name)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return  Center(child: SpinKitFadingCube(color: border_color));
          }

          final docs = snapshot.data!.docs.where((doc) {
            final text = doc['text'].toString().toLowerCase();
            final date = (doc['timestamp'] as Timestamp).toDate();

            final matchesText = _searchText.isEmpty ||
                text.contains(_searchText.toLowerCase());
            final matchesDate = _selectedDate == null ||
                DateFormat('yyyy-MM-dd').format(date) ==
                    DateFormat('yyyy-MM-dd').format(_selectedDate);

            return matchesText && matchesDate;
          }).toList();

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index];
              final date = (data['timestamp'] as Timestamp).toDate();

              return Card(
                color: container_color,
                elevation: 5, // Elevation for the card shadow
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(15), // Card border radius
                ),

                child: Padding(
                  padding:  EdgeInsets.all(4.0),
                  child: Container(
                    // Creates space for the border
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: border_color, // Border color
                        width: 3, // Border width
                      ),
                      borderRadius:
                      BorderRadius.circular(15), // Border radius
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(4.0),
                      child: ListTile(
                        title: Text(data['text'],style: GoogleFonts.nunito(),),
                        subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () => utility.launchURL(data['youtubeUrl']),
                                  child: Text('YouTube/Doc',style: TextStyle(color: Colors.red),),
                                ),
                                TextButton(
                                  onPressed: () => utility.launchURL(data['problemLink']),
                                  child: Text('Problem',style: TextStyle(color: Colors.green)),
                                ),

                              ],
                            ),

                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(style: GoogleFonts.nunito(),
                                    '   ${date.day} : ${utility.monthNames[date.month]} : ${date.year}'),
                                IconButton(
                                  icon:
                                  Icon(Icons.delete, color: Colors.black),
                                  onPressed: () {
                                    utility.deleteData(data.id,collection_name); // Call delete function
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  static Widget show_data(BuildContext context,String collection_name,Color border_color , Color container_color, DateTime? _selectedDate,  String _searchText){
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(collection_name)
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return  Center(child: SpinKitFadingCube(color: border_color));
          }

          final docs = snapshot.data!.docs.where((doc) {
            final text = doc['text'].toString().toLowerCase();
            final date = (doc['date'] as Timestamp).toDate();

            final matchesText = _searchText.isEmpty ||
                text.contains(_searchText.toLowerCase());
            final matchesDate = _selectedDate == null ||
                DateFormat('yyyy-MM-dd').format(date) ==
                    DateFormat('yyyy-MM-dd').format(_selectedDate);

            return matchesText && matchesDate;
          }).toList();

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index];
              final date = (data['date'] as Timestamp).toDate();

              return Card(
                color: container_color,
                elevation: 5, // Elevation for the card shadow
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(15), // Card border radius
                ),

                child: Padding(
                  padding:  EdgeInsets.all(4.0),
                  child: Container(
                    // Creates space for the border
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: border_color, // Border color
                        width: 3, // Border width
                      ),
                      borderRadius:
                      BorderRadius.circular(15), // Border radius
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(4.0),
                      child: ListTile(
                        title: Text(data['text'],style: GoogleFonts.nunito(),),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(style: GoogleFonts.nunito(),
                                '${date.day} : ${utility.monthNames[date.month]} : ${date.year}'),
                            IconButton(
                              icon:
                              Icon(Icons.delete, color: Colors.black),
                              onPressed: () {
                                utility.deleteData(data.id,collection_name); // Call delete function
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  static Widget data_entry_box(TextEditingController _controller ){
    return TextField(
      controller: _controller,
      maxLines: null, // Allow multiple lines
      decoration: InputDecoration(
        hintText: 'Enter your data...',
        border: OutlineInputBorder(),
      ),
    );
  }

  static ButtonStyle reusableButtonStyle() {
    return ElevatedButton.styleFrom(
      elevation: 10,
      shadowColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11),
      ),
      backgroundColor: Colors.white, // Button color
    );
  }
  static String cdh1="Unit 1: Introduction ";
  static String cdh2="Unit2: Syntax Analysis and Parsing Techniques ";
  static String cdh3="Unit 3: Syntax Directed Translation & Intermediate Code Generation ";
  static String cdh4="Unit4: Runtime Environment& Code Optimization and Generation ";
  static String cd1="Introduction to Compiler, single and multi-pass compilers, Translators, Phases of Compilers,Compiler writing tools, Bootstrapping, Back patching. Finite Automata and Lexical Analyzer: Role of Lexical Analyzer, Specification of tokens, Recognition of tokens, Regular expression, Finite automata, from regular expression to finite automata transition diagrams, Implementation of lexical analyzer Tool for lexical analyzer LEX, Error reporting.";
  static String cd2="Context free grammars, Bottom-up parsing and top down parsing. Top down Parsing: elimination of left recursion, recursive descent parsing, Predicative Parsing, Bottom Up Parsing: Operator precedence parsing, LR parsers, Construction of SLR, canonical LR and LALR parsing tables, Construction of SLR parse tables for Ambiguous grammar, the parser generator – YACC, error recovery in top down and bottom up parsing.";
  static String cd3="Synthesized and inherited attributes, dependency graph, Construction of syntax trees, bottom up and top down evaluation of attributes, S-attributed and L-attributed definitions, Postfix notation; Three address codes, quadruples, triples and indirect triples, Translation of assignment statements, control flow, Boolean expression and Procedure Calls.";
  static String cd4="Storage organization, activation trees, activation records, allocation strategies, Parameter passing symbol table, dynamic storage allocation. Basic blocks and flow graphs, Optimization of basic blocks, Loop optimization, Global data flow analysis, Loop invariant computations. Issue in the design of Code generator, register allocation, the target machine, and simple Code generator.";

  static String aih1="Unit 1: General Issues and Overview of AI";
  static String aih2="Unit 2: Problem Solving through Searching";
  static String aih3="Unit 3: Knowledge and Reasoning";
  static String aih4="Unit 4: Applications of AI&Expert Systems";
  static String aic1="The AI problems: what is an AI technique; Level of model, criteria for success, Characteristics of AIapplications, Intelligent Agents,Problem Solving, State Space Search, Production systems, Problem characteristics, Production System characteristics, Issues in thedesign of search program, Data driven and goal driven search, Exhaustive searches: Depth first &Breadth first search. Case study: Sophia the first Humanoid robot.";
  static String aic2="Heuristics & Heuristic function, Heuristic Search – Generate & test, Hill climbing; Branch and Boundtechnique; Best first search & A* algorithm, AND/OR Graphs, Problem reduction and AO* algorithm,Constraint Satisfaction problems, Means End Analysis, Adversarial search: Game Playing, Minimax search procedure, Alpha-Beta cut-offs, Additional Refinements.";
  static String aic3="Introduction to knowledge representation-Propositional calculus, First Order Predicate Calculus,conversion to clause form, Unification Theorem proving by Resolution, Natural Deduction,InferenceMechanisms, Knowledge representation issues-Representation and mapping,Approaches to Knowledge representation, Frame Problem, Structured knowledge representation,Semantic Networks, Frame representation and Value Inheritance, Conceptual Dependency andScripts, Introduction to Agent based problem solving,Source of Uncertainty, Probabilistic Reasoning and Uncertainty, Probability theory, Bayes Theorem, Non-MonotonicReasoning. Case Study: Industrial AI Robots.";
  static String aic4="Natural language processing: overview, Basic steps followed for the NLP, concept of NLP, Parsing,machine translation, Planning Overview - An Example Domain: The Blocks Word, Component of Planning Systems, Goal Stack Planning (linear planning); Non-linear Planning using constraintposting. Learning, Rote Learning; Learning by Induction, Learning in Problem Solving, Explanation based learning and Discovery, Introduction to LISP and PROLOG, Introduction toExpertSystems, characteristics, Architecture of Expert Systems, Development of Expert System, Software Engineering and Expert System, Expert System Life Cycle model, Expert System Shells; Knowledge Acquisition; Case Study: Autonomous Vehicles.";

  static String cgh1="Unit 1: Overview of Graphics System";
  static String cgh2="Unit 2: Three dimensional transformations and Curve Design";
  static String cgh3="Unit 3: Hidden Surface Removal &Fractals";
  static String cgh4="Unit 4 : Shading, Color Issues and Animation";
  static String cgc1="Basics of Computer Graphics, I/O devices, Raster scan & Random scan system, line and circle generation methods, Filled area primitive, solid area filling algorithms.2-D Transformation, basic geometric transformations, Transformation in homogeneous coordinate system, Line Clipping algorithms; Cohen-Sutherland algorithm, Midpoint subdivision algorithm, Cyrus beck algorithm,";
  static String cgc2="3-D transformations, Projection: parallel projection, perspective projection, Vanishing points. Polygon Clipping Parametric curves, Need for cubic parametric curves c0, c1, c2 continuity, Bezier curves, Generation though ernstein polynomials, Condition for smooth joining of 2 segments, Convex Hull property, BSplineCurves: Properties of B-spline curves, Finding Knot vectors-uniform and open uniform, Nonuniform, rational B-splines, Beta splines, Subdividing curves, Drawing curves using forward differences.";
  static String cgc3="Hidden Surface Removal: Back face removal, Floating Horizon method for curved objects, Z-Bufferor depth buffer algorithm, Painters algorithm (Depth sorting method), Binary space partitioning trees, Scan-line algorithm, Warnock’s algorithm. Fractals: self-similar fractals-fractal dimension, Generation of Terrain-random mid point displacement, Grammar based models, Self-squaring fractals. Soild Modelling: Generation through sweep techniques, Constructive sold geometry,.";
  static String cgc4="Illumination model, Computing reflection vector, Gouraud and Phog shading, Texture mapping &their characteristics, Handling shadows, Radiosity, Lambert’s Law, Modelling transparency, Colorissues: color model for Images, Additive and Subtractive colour models, Wavelength spectrum, CIE colour standards. Animation: Procedural animation, morphing, creating key frames, steps for creating animation, Frame by Frame animation.";



  static Widget bottom_sheet(double position,BuildContext context,String h1,String h2,String h3,String h4,String c1,String c2,String c3,String c4,){
    return Positioned(
      bottom: 16,
      right: position,
      child: SizedBox(
        height: 50,
        width: 50,
        child: AvatarGlow(
          glowColor: Colors.green,
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return Container(
                    width: double.infinity,height: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Syllabus', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          SelectableText(h1,style: GoogleFonts.nunito(color: Colors.red,fontWeight: FontWeight.bold),),SizedBox(height: 10),
                          SelectableText(c1,style: GoogleFonts.nunito(),),SizedBox(height: 20),
                          SelectableText(h2,style: GoogleFonts.nunito(color: Colors.red,fontWeight: FontWeight.bold),),SizedBox(height: 10),
                          SelectableText(c2,style: GoogleFonts.nunito(),),SizedBox(height: 20),
                          SelectableText(h3,style: GoogleFonts.nunito(color: Colors.red,fontWeight: FontWeight.bold),),SizedBox(height: 10),
                          SelectableText(c3,style: GoogleFonts.nunito(),),SizedBox(height: 20),
                          SelectableText(h4,style: GoogleFonts.nunito(color: Colors.red,fontWeight: FontWeight.bold),),SizedBox(height: 10),
                          SelectableText(c4,style: GoogleFonts.nunito(),),SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            backgroundColor: Colors.white,
            child: Image.asset("assets/youtube.png",height: 30,),
          ),
        ),
      ),
    );
  }

}