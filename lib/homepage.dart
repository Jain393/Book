import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import 'login.dart';

class Homepage extends StatefulWidget {

  const Homepage({super.key, required this.username});

  final String username;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? selectedBook;
  DateTime? returnDate;
  final TextEditingController issuedByController = TextEditingController();
  List<Map<String, String>> issuedBooks = [];
  List<Map<String, String>> filteredBooks = [];
  final TextEditingController searchController = TextEditingController();

  List<String> books = ['Book 1', 'Book 2', 'Book 3', 'Book 4']; // Example book list

  @override
  void initState() {
    super.initState();
    filteredBooks = issuedBooks;
    searchController.addListener(() {
      filterBooks();
    });
  }

  void filterBooks() {
    setState(() {
      filteredBooks = issuedBooks
          .where((book) =>
          book['bookName']!.toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _selectReturnDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != returnDate) {
      setState(() {
        returnDate = picked;
      });
    }
  }

  void _saveDetails() {
    if (selectedBook != null && returnDate != null && issuedByController.text.isNotEmpty) {
      setState(() {
        issuedBooks.add({
          'bookName': selectedBook!,
          'issuedBy': issuedByController.text,
          'issueDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
          'returnDate': DateFormat('yyyy-MM-dd').format(returnDate!),
        });
        filteredBooks = issuedBooks;
      });
    }
  }


  void _deleteBook(int index) {
    setState(() {
      issuedBooks.removeAt(index);
      filterBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(Icons.person),
          ),
        ),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return Login();
            }
            ));
          }, icon: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(Icons.logout),)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text("Welcome!", style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800)),
              Text(widget.username, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              SizedBox(height: 30),
              Text("Select the book: ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4), // Add padding inside the container
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: DropdownButton<String>(
                  hint: Text('Select a Book'),
                  value: selectedBook,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedBook = newValue;
                    });
                  },
                  items: books.map((String book) {
                    return DropdownMenuItem<String>(
                      value: book,
                      child: Text(book),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10),
              Text("Issued by:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              TextField(
                controller: issuedByController,
                decoration: InputDecoration(
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Text(returnDate == null
                      ? 'Select Return Date: '
                      : 'Return Date: ${DateFormat('yyyy-MM-dd').format(returnDate!)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: _selectReturnDate,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 40,
                  width: 100,
                  child: ElevatedButton(onPressed:_saveDetails,style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
                      backgroundColor: Colors.blue.shade900,
                      foregroundColor: Colors.white
                  ), child: Text("Save",style: TextStyle(fontSize: 16),)),
                ),
              ),
              SizedBox(height: 22),
              Text("Recent issued books:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              SizedBox(height: 12),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                    labelText: 'Search Books',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: filteredBooks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 0.5, color: Colors.grey),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(-3, 3)
                              )
                            ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(filteredBooks[index]['bookName']!, style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('Issued By: ${filteredBooks[index]['issuedBy']}'),
                                Text('Return Date: ${filteredBooks[index]['returnDate']}')
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                _deleteBook(index);
                              },
                              icon: Icon(Icons.delete, color: Colors.redAccent),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
