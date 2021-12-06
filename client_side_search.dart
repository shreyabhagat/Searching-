import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientSideSearch extends StatefulWidget {
  const ClientSideSearch({Key? key}) : super(key: key);

  @override
  _ClientSideSearchState createState() => _ClientSideSearchState();
}

class _ClientSideSearchState extends State<ClientSideSearch> {
  //
  CollectionReference people = FirebaseFirestore.instance.collection('people');
  //
  String searchKey = '';
  List<People> userList = [];
  //
  @override
  void initState() {
    super.initState();
    getData();
  }

  //
  @override
  void dispose() {
    super.dispose();
  }

  void getData() async {
    QuerySnapshot rawData = await people.get();
    List<DocumentSnapshot> documentSnapshot = rawData.docs;

    documentSnapshot.forEach((singleElement) {
      userList.add(People.fromDocumentSnapshot(singleElement));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Side Search'),
      ),
      body: Column(
        children: [
          //
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (String newValue) {
                setState(() {
                  searchKey = newValue;
                });
              },
            ),
          ),
          //
          Expanded(
            child: searchKey == ''
                ? Container()
                : ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (BuildContext context, int index) {
                      String? name = userList[index].name;
                      return name!
                              .toLowerCase()
                              .contains(searchKey.toLowerCase())
                          ? ListTile(
                              title: Text('${userList[index].name}'),
                              subtitle: Text('${userList[index].email}'),
                            )
                          : Container();
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class People {
  String? name;
  String? email;

  People.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    this.name = snapshot['name'];
    this.email = snapshot['email'];
  }
}
