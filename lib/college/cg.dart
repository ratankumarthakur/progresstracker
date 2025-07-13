import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:google_fonts/google_fonts.dart';
import 'package:incrementer/utility.dart';

class cg extends StatefulWidget {
  const cg({super.key});
  @override
  State<cg> createState() => _cgState();
}

class _cgState extends State<cg> {
  Color c = Colors.red;

  bool _showTextField = false; // Toggle for showing TextField

  TextEditingController _controller = TextEditingController();

  TextEditingController _searchController = TextEditingController();

  DateTime? _selectedDate;

  void hide_textfield(bool _showTextField) {
    setState(() {
      _showTextField = false; // Hide TextField after submission
    });
  }

  void _updateSelectedDate(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }

  String _searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      appBar:
      utility.app_bar(context, c, "Computer Graphics"),
      floatingActionButton: utility.floating_action(
          "https://youtube.com/playlist?list=PLxCzCOWd7aiHGhOHV-nwb0HR5US5GFKFI&si=rqomf6ghE1bzwJr7",
          "https://docs.google.com/document/d/1q4dlhYaM-ea2AFwGYIbbBCrQhr9ZLKOKvQE6RQKjJB8/edit?usp=sharing",
          context, utility.cgh1, utility.cgh2, utility.cgh3, utility.cgh4, utility.cgc1, utility.cgc2, utility.cgc3, utility.cgc4
      ),
      body: Column(
        children: [
          // Search by Text
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
                            context, c, _updateSelectedDate);
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
            icon: Icon(Icons.add, size: 30),
            onPressed: () {
              setState(() {
                _showTextField = !_showTextField;
              });
            },
          ),
          // TextField and Submit Button
          if (_showTextField)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  utility.data_entry_box(_controller),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      utility.submitData(_controller, _showTextField, 'cg');
                      setState(() {
                        _showTextField = false;
                      });
                    },
                    style: utility.reusableButtonStyle(),
                    child: Text('Add', style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 16),
          // Display Filtered Data
          utility.show_data(context, 'cg', c, Colors.red.shade200, _selectedDate, _searchText),
         // utility.bottom_sheet(156,context, utility.cgh1, utility.cgh2, utility.cgh3, utility.cgh4, utility.cgc1, utility.cgc2, utility.cgc3, utility.cgc4)
        ],
      ),
    );
  }
}
