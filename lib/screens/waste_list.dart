import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/models/post_values.dart';
import '../screens/waste_entry_form.dart';
import '../screens/list_detail_screen.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? image;
  final picker = ImagePicker();
  final PostEntryValues = PostValues();

/*
* Pick an image from the gallery, upload it to Firebase Storage and return 
* the URL of the image in Firebase Storage.
*/
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    setState(() {});
    Navigator.of(context).push(
      MaterialPageRoute(
      builder: (context) => WasteEntryForm(image!)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Wasteagram"))),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData &&
              snapshot.data!.docs != null &&
              snapshot.data!.docs.length > 0) {
            return Column(
              children: [Expanded(
                  child: 
                  ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                    var post = snapshot.data!.docs[index];
                      return ElevatedButton(
                      onPressed: () { 
                        PostEntryValues.imageURL = post['imageURL'].toString();
                        PostEntryValues.date = post['date'].toString();
                        PostEntryValues.quantity = post['quantity'].toString();
                        PostEntryValues.latitude = post['latitude'].toString();
                        PostEntryValues.longitude = post['longitude'].toString();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                          builder: (context) => ListDetailScreen(
                            PostEntryValues.imageURL,
                            PostEntryValues.date,
                            PostEntryValues.quantity,
                            PostEntryValues.latitude,
                            PostEntryValues.longitude,)));
                         },
                      child: ListTile(
                          leading: Text(post['date'].toString()),
                          title: Text(post['quantity'].toString()),
                          ));
                    },
                  ),
                ),
                
                Semantics(child: FloatingActionButton(
                  child: Icon(Icons.camera_alt),
                  onPressed: () => getImage()
                ),
                button: true,
                enabled: true,
                onTapHint: 'Select image from gallery',)],
            );
          } else {
            return Column(
              children: [
                Center(child: CircularProgressIndicator()),
                ElevatedButton(
                  child: Icon(Icons.camera),
                  onPressed: () =>
                   getImage(),
                ),
              ],
            );
          }
        }));
  }
}

