import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUsersDetails extends StatefulWidget {
  const AddUsersDetails({Key? key}) : super(key: key);

  @override
  _AddUsersDetailsState createState() => _AddUsersDetailsState();
}

class _AddUsersDetailsState extends State<AddUsersDetails> {
  //
  CollectionReference people = FirebaseFirestore.instance.collection('people');

  //
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  //
  @override
  void initState() {
    super.initState();
  }

  //
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Add User Details'),
      ),
      //
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Name
          TextField(
            controller: nameController,
            textCapitalization: TextCapitalization.words,
            //
            decoration: InputDecoration(
              hintText: 'Name',
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),

          // Email
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            //
            decoration: InputDecoration(
              hintText: 'Email',
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 16),

          //Add Button
          ElevatedButton(
            child: Text('Add Data'),
            onPressed: () {
              addData();
            },
          ),
        ],
      ),
    );
  }

  Future<void> addData() async {
    String name = nameController.text;
    String email = emailController.text;
    List<String> nameSearch = [];

    for (int i = 0; i < name.length; i++) {
      nameSearch.add(name.substring(0, i + 1));
    }

    await people.add({
      'name': name,
      'email': email,
      'nameSearch': nameSearch,
    });

    //
    nameController.clear();
    emailController.clear();
  }
}
