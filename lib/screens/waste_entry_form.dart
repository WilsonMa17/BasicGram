import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:wasteagram/models/post_values.dart';
import 'package:intl/date_symbol_data_local.dart';

class WasteEntryForm extends StatelessWidget {

  static var routeName;
  
  File image;
  WasteEntryForm(this.image);

  LocationData? locationData;
  var locationService = Location();

  final formKey = GlobalKey<FormState>();
  final PostEntryValues = PostValues();

  Future addImage () async{
    var fileName = DateTime.now().toString() + '.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    print(url);
    PostEntryValues.imageURL = url; 
  }

  Future getLocation () async{
    PostEntryValues.latitude = '${locationData!.latitude}';
    PostEntryValues.longitude ='${locationData!.longitude}';
  }

  void addDateToFirestore(){
    DateTime date = DateTime.now();
    PostEntryValues.date = DateFormat('yMMMMd').format(date).toString();
  }
  void uploadData() async {
    final getter = await addImage();
    final getter1 = await getLocation();
    final url = PostEntryValues.imageURL;
    final date = PostEntryValues.date;
    final quantity = PostEntryValues.quantity;
    final longitude = PostEntryValues.longitude;
    final latitude = PostEntryValues.latitude;
    
    FirebaseFirestore.instance
        .collection('posts')
        .add({'date': date, 'imageURL': url, 'quantity': quantity ,'latitude': latitude, 'longitude':longitude});
  }

  @override
  Widget build(BuildContext context) {
    if (image == null){ 
      return Center(child:CircularProgressIndicator());
      } else {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Padding(padding: const EdgeInsets.all(10),
            child:Image.file(image)),
        Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Number of Items', border: OutlineInputBorder()
              ),
              onSaved: (value)  {
                PostEntryValues.quantity = value;
              },
            validator: (value) {
      if (value == null) {
        return 'Please enter quantity value';
      }
      return null;
    },
  ),
    SizedBox(height: 10),
      ElevatedButton(
        child: Text('Save'),
          onPressed: () {
            if (formKey.currentState!.validate()){
              
              formKey.currentState!.save();
              retrieveLocation();
              getLocation();
              addDateToFirestore();
              uploadData();
              Navigator.pop(context);
                    }  
                  }
              )
          ],
          ),
        )
        )]));}
    }

void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
  }

}





