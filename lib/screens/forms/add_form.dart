import 'package:covid19_ui/database/database_manager.dart';
import 'package:covid19_ui/models/users.dart';
import 'package:covid19_ui/screens/choose_logo.dart';
import 'package:covid19_ui/utils/constants.dart';
import 'package:covid19_ui/utils/masked_formatter.dart';
import 'package:covid19_ui/widgets/users_all_duplicate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../home/screen_header.dart';

class AddFormScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String logo;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _placeBirthController = TextEditingController();
  final _adressController = TextEditingController();
  final _townController = TextEditingController();
  final _zipcodeController = TextEditingController();
  final AllUsersDuplicateState state;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  AddFormScreen(this._scaffoldKey, this.state) : logo = '1';

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
                ScreenHeader("Ajout d'un nouvel utilisateur",
                    "Pour ajouter un nouvel utilisateur, il vous suffit de remplir le formulaire ci-dessous et d'appuyer sur le bouton 'enregistrer'"),
                SizedBox(height: kSpacingUnit),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context1) =>
                              ChooseLogoScreen(int.parse(logo)))),
                  child: Container(
                    height: 60,
                    width: 60,
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color.fromRGBO(16, 16, 16, 1),
                    ),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage:
                          AssetImage('assets/icons/avatars/$logo.png'),
                      backgroundColor: kSilverColor,
                    ),
                  ),
                ),
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
                _customTextFormField(
                    _placeBirthController, 'Lieu de naissance', []),
                SizedBox(height: kSpacingUnit * 2),
                _customTextFormField(_adressController, 'Adresse', []),
                SizedBox(height: kSpacingUnit * 2),
                _customTextFormField(_townController, 'Ville', []),
                SizedBox(height: kSpacingUnit * 2),
                _customTextFormField(_zipcodeController, 'Code postal',
                    [WhitelistingTextInputFormatter.digitsOnly]),
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
            DatabaseManager()
                .insertUser(User.withFavorite(
                    _firstNameController.value.text,
                    _lastNameController.value.text,
                    _birthdayController.value.text,
                    _placeBirthController.value.text,
                    _adressController.value.text,
                    _townController.value.text,
                    int.parse(_zipcodeController.value.text),
                    false))
                .then((value) => {
                      state.reloadUsers(),
                      _scaffoldKey.currentState.showSnackBar(
                        new SnackBar(
                          content: new Text(
                              "${_firstNameController.value.text} ${_lastNameController.value.text} a été enregistré."),
                          duration: new Duration(seconds: 3),
                          backgroundColor: Color.fromRGBO(123, 237, 159, 1),
                        ),
                      ),
                    });

            Navigator.of(context).pop();
          }
        },
        child: Icon(Icons.done),
      ),
    );
  }

  TextFormField _customTextFormField(TextEditingController controller,
      String label, List<TextInputFormatter> list) {
    return TextFormField(
      controller: controller,
      inputFormatters: list,
      validator: (value) =>
          value.isEmpty ? 'Veuillez compléter ce champ.' : null,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kSpacingUnit * 2))),
    );
  }
}
