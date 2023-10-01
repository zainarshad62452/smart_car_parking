class CarParkingModel{
  String? uid;
  String? parkingName;
  bool? isReserved;
  String? reservedBy;
  bool? isParked;
  String? carNumber;
  double? latitude;
  DateTime? reservedAt;
  double? longitude;

  CarParkingModel({this.uid,this.parkingName,this.isReserved,this.longitude,this.latitude,this.reservedBy,this.isParked,this.carNumber,this.reservedAt}
      );

  CarParkingModel.fromJson(Map<String, dynamic> json) {
    parkingName = json['parkingName'];
    isReserved = json['isReserved'];
    reservedBy = json['reservedBy'];
    latitude = json['latitude'];
    isReserved = json['isReserved'];
    uid = json['uid'];
    isParked = json['isParked'];
    carNumber = json['carNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parkingName'] = parkingName;
    data['isReserved'] = isReserved;
    data['reservedBy'] = reservedBy;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['isParked'] = isParked;
    data['carNumber'] = carNumber;
    data['reservedAt'] = DateTime.now();
    data['uid'] = uid;
    return data;
  }
}