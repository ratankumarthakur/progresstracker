import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../utility.dart';

class leetcode extends StatefulWidget {
  @override
  _leetcodeState createState() => _leetcodeState();
}

class _leetcodeState extends State<leetcode> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _youtubeUrlController = TextEditingController();
  final TextEditingController _problemLinkController = TextEditingController();
  TextEditingController _searchController = TextEditingController();

  DateTime? _selectedDate;
  String _searchText = "";
  bool _isFormVisible = false;

  // Function to save data to Firestore

  void _updateSelectedDate(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }

  Color c = Color(0xfffaae2a);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffffd285),
      appBar: utility.app_bar(context, c, "Leetcode"),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 18.0, right: 18, top: 8, bottom: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by Text',
                labelStyle: GoogleFonts.nunito(),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchText = "";
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value.trim();
                });
              },
            ),
          ),

          // Search by Date
          Padding(
            padding:
                const EdgeInsets.only(left: 18.0, right: 18, top: 8, bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.black38)),
              child: Padding(
                padding: EdgeInsets.only(left: 8.0, top: 4, bottom: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        style: GoogleFonts.nunito(fontSize: 16),
                        _selectedDate == null
                            ? 'No Date Selected'
                            : 'Selected Date: ${DateFormat('d : MMMM : y').format(_selectedDate!)}',
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        utility.pickDate(
                            context, Colors.yellow, _updateSelectedDate);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _selectedDate = null;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _isFormVisible = !_isFormVisible;
              });
            },
          ),
          // Form for entering data
          if (_isFormVisible)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                        labelText: 'Description', border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: _youtubeUrlController,
                    decoration: InputDecoration(
                        labelText: 'YouTube URL', border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: _problemLinkController,
                    decoration: InputDecoration(
                        labelText: 'Problem Link',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      utility.saveData(_textController, _youtubeUrlController,
                          _problemLinkController, _isFormVisible, 'leetcode');
                      setState(() {
                        _isFormVisible = false;
                      });
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          // Display fetched data
          utility.show_data_coding(context, 'leetcode', Color(0xfffaae2a),
              Color(0xffffd285), _selectedDate, _searchText),
          Card(
            margin: EdgeInsets.all(16),
            child: ListTile(
              hoverColor: Color(0xfffaae2a),
              title: Center(child: Text('Visit Leetcode')),
              trailing: Icon(Icons.open_in_new),
              onTap: () =>
                  utility.launchURL('https://leetcode.com/u/Ratan_Kumar_Thakur/'),
            ),
          ),
        ],
      ),
    );
  }
}
