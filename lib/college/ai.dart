import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:google_fonts/google_fonts.dart';
import 'package:incrementer/utility.dart';

class ai extends StatefulWidget {
  const ai({super.key});
  @override
  State<ai> createState() => _aiState();
}

class _aiState extends State<ai> {
  Color c = Colors.yellow;

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
      backgroundColor: Colors.yellow.shade100,
      appBar:
          utility.app_bar(context, Colors.yellow, "Artificial Intelligence"),
      floatingActionButton: utility.floating_action(
          "https://youtube.com/playlist?list=PLxCzCOWd7aiHGhOHV-nwb0HR5US5GFKFI&si=rqomf6ghE1bzwJr7",
          "https://docs.google.com/document/d/14hTf0IljJZJMggWQsswxTqVIeZDA3vte9uxRc9pyGRI/edit?usp=sharing",
          context, utility.aih1, utility.aih2, utility.aih3, utility.aih4, utility.aic1, utility.aic2, utility.aic3, utility.aic4),
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
                      utility.submitData(_controller, _showTextField, 'ai');
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
          utility.show_data(context, 'ai', Colors.yellow, Colors.yellow.shade200, _selectedDate, _searchText),
          //utility.bottom_sheet(156,context, utility.aih1, utility.aih2, utility.aih3, utility.aih4, utility.aic1, utility.aic2, utility.aic3, utility.aic4)

        ],
      ),
    );
  }
}
