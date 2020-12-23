import 'package:covid19_ui/database/database_manager.dart';
import 'package:covid19_ui/models/users.dart';
import 'package:covid19_ui/screens/home/screen_header.dart';
import 'package:covid19_ui/utils/constants.dart';
import 'package:covid19_ui/utils/masked_formatter.dart';
import 'package:covid19_ui/widgets/users_all_duplicate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditFormScreen extends StatelessWidget {

  final User _user;
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _placeBirthController = TextEditingController();
  final _adressController = TextEditingController();
  final _townController = TextEditingController();
  final _zipcodeController = TextEditingController();
  final AllUsersDuplicateState state;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  EditFormScreen(this._scaffoldKey, this._user, this.state) {

    _firstNameController.text = _user.firstName;
    _lastNameController.text = _user.lastName;
    _birthdayController.text = _user.birthday;
    _placeBirthController.text = _user.placeOfBirth;
    _adressController.text = _user.adress;
    _townController.text = _user.town;
    _zipcodeController.text = _user.zipcode.toString();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 45.0, horizontal: 10.0),
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ScreenHeader("Modification d'un utilisateur", "Pour enregistrer les modifications, il vous suffit de cliquer sur le bouton ci-dessous, pour supprimer l'utilisateur, il s'agit du boutons rouge au dessus."),
                SizedBox(height: kSpacingUnit * 3),
                _customTextFormField(_firstNameController, 'Prénom', []),
                SizedBox(height: kSpacingUnit * 2),
                _customTextFormField(_lastNameController, 'Nom', []),
                SizedBox(height: kSpacingUnit * 2),
                _customTextFormField(_birthdayController, 'Date de naissance', [
                  LengthLimitingTextInputFormatter(10),
                  WhitelistingTextInputFormatter.digitsOnly,
                  DateTextFormatter(10),
                ]),
                SizedBox(height: kSpacingUnit * 2),
                _customTextFormField(_placeBirthController, 'Lieu de naissance', []),
                SizedBox(height: kSpacingUnit * 2),
                _customTextFormField(_adressController, 'Adresse', []),
                SizedBox(height: kSpacingUnit * 2),
                _customTextFormField(_townController, 'Ville', []),
                SizedBox(height: kSpacingUnit * 2),
                _customTextFormField(_zipcodeController, 'Code postal', [WhitelistingTextInputFormatter.digitsOnly]),
                SizedBox(height: kSpacingUnit * 2),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(16, 16, 16, 1),
        onPressed: () {
          if (_formKey.currentState.validate()) {

            DatabaseManager().updateUser(User.withId(_user.id, _firstNameController.value.text, _lastNameController.value.text, _birthdayController.value.text, _placeBirthController.value.text, _adressController.value.text, _townController.value.text, int.parse(_zipcodeController.value.text), _user.isFavorite)).then((value) => {

              _scaffoldKey.currentState.showSnackBar(new SnackBar(
                content: new Text("Les modifications ont été enregistrés."),
                duration: new Duration(seconds: 3),
                backgroundColor: Color.fromRGBO(123, 237, 159, 1),
              ),
              ),

            });

            Navigator.of(context).pop();
            Navigator.of(context).pop();
            state.reloadUsers();
          }
        },
        child: Icon(Icons.done),
      ),
    );
  }

  TextFormField _customTextFormField(TextEditingController controller, String label, List<TextInputFormatter> list) {
    return TextFormField(
      controller: controller,
      inputFormatters: list,
      validator: (value) => value.isEmpty ? 'Veuillez compléter ce champ.' : null,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(kSpacingUnit * 2))
      ),
    );
  }
}
