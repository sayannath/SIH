class Crop {
  int _id;
  String _cropName;
  String _cropInfo;
  String _location;
  String _date;

  Crop(this._cropName, this._cropInfo, this._location, this._date);
  Crop.withId(this._id, this._cropName, this._cropInfo, this._location, this._date);

  
  //Getters
  int get id => _id;
  String get cropName => _cropName;
  String get cropInfo => _cropInfo;
  String get location => _location;
  String get date => _date;

  //Setters
  set cropName(String newCropName) {
    this._cropName = newCropName;
  }

  set cropInfo(String newCropInfo) {
    this._cropInfo = newCropInfo;
  }

  set location(String newLocation) {
    this._location = newLocation;
  }

  set date(String newDate) {
    this._date = newDate;
  }

  //Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['cropName'] = _cropName;
    map['cropInfo'] = _cropInfo;
    map['location'] = _location;
    map['date'] = _date;

    return map;
  }

  // Extract a Note object from a Map object
  Crop.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._cropName = map['cropName'];
    this._cropInfo = map['cropInfo'];
    this._location = map['location'];
    this._date = map['date'];
  }
}