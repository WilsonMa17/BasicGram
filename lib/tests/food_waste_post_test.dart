
import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/post_values.dart';

void main(){
  test('Center',(){
    final date =  DateTime.parse('2021-01-21');
    const url ='fake';
    const quantity =  1;
    const latitude = 1;
    const longitude = 2;
  
  final postValues = PostValues.fromMap({
    'date' : DateTime.parse('2021-01-21'),
    'url' : 'fake',
    'quantity' : 1,
    'latitude' : 1,
    'longitude' : 2
  });

expect(postValues.date,date);
expect(postValues.url,url);
expect(postValues.quantity,quantity);
expect(postValues.latitude,latitude);
expect(postValues.longitude,longitude);
  
  });
}

