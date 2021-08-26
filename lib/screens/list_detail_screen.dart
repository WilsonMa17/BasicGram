import 'package:flutter/material.dart';

class ListDetailScreen extends StatelessWidget {

  static var routeName;
  
  final String? imageURL;
  final String? date;
  final String? quantity;
  final String? latitude;
  final String? longtitude;

  ListDetailScreen(this.imageURL,this.date,this.quantity,this.latitude,this.longtitude);

  @override
  Widget build(BuildContext context) {
    
    if (imageURL == null || date == null ||quantity == null ||latitude == null ||longtitude == null){ 
      return Center(child:CircularProgressIndicator());
      } else {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:[
            Image.network(imageURL!),
            Center(
            child: Text(date!,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40))),
            Center(child: Text("Quantity: $quantity",style: TextStyle(
                 
                  fontSize: 20))),
            Center(child: Text("Latitude: $latitude",style: TextStyle(
                  
                  fontSize: 20))),
            Center(child: Text("Longitude: $longtitude",style: TextStyle(
                  
                  fontSize: 20)))
    ]));}
    }
  
}