class User {
  int _id;
  String _firstName;
  String _lastName;
  String _birthday;
  String _placeOfBirth;
  String _adress;
  String _town;
  int _zipcode;
  bool _isFavorite;

  User(this._firstName, this._lastName, this._birthday, this._placeOfBirth,
      this._adress, this._town, this._zipcode) : _isFavorite = false;

  User.withFavorite(this._firstName, this._lastName, this._birthday, this._placeOfBirth,
      this._adress, this._town, this._zipcode, this._isFavorite);

  User.withId(
      this._id,
      this._firstName,
      this._lastName,
      this._birthday,
      this._placeOfBirth,
      this._adress,
      this._town,
      this._zipcode,
      this._isFavorite);

  int get id => _id;

  int get zipcode => _zipcode;

  set zipcode(int value) {
    _zipcode = value;
  }

  String get town => _town;

  set town(String value) {
    _town = value;
  }

  String get adress => _adress;

  set adress(String value) {
    _adress = value;
  }

  String get placeOfBirth => _placeOfBirth;

  set placeOfBirth(String value) {
    _placeOfBirth = value;
  }

  String get birthday => _birthday;

  set birthday(String value) {
    _birthday = value;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }

  String get firstName => _firstName;

  set firstName(String value) {
    _firstName = value;
  }

  bool get isFavorite => _isFavorite;

  bool switchFavorite() {
    _isFavorite = !_isFavorite;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }

    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['birthday'] = _birthday;
    map['place_of_birth'] = _placeOfBirth;
    map['adress'] = _adress;
    map['town'] = _town;
    map['zipcode'] = _zipcode;
    map['is_favorite'] = (_isFavorite ? 0 : 1);

    return map;
  }

  // Extract a Note object from a Map object
  User.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._firstName = map['first_name'];
    this._lastName = map['last_name'];
    this._birthday = map['birthday'];
    this._placeOfBirth = map['place_of_birth'];
    this._adress = map['adress'];
    this._town = map['town'];
    this._zipcode = map['zipcode'];
    this._isFavorite = (map['is_favorite'] == 0 ? true : false);
  }
}
