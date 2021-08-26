
class PostValues {
  
  String? date;
  String? imageURL;
  String? quantity;
  String? latitude;
  String? longitude;

  String toString() {
    return 'date: $date, imageURL: $imageURL, quantity: $quantity,latitude: $latitude longitude: $longitude';
  }

  static fromMap(Map<String, dynamic> map) {}}