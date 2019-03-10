import 'package:flutter/material.dart';
import '../auth/Authenticator.dart';

enum FormMode {
  LOGIN, SIGNUP
}

Authenticator auth = new Authenticator();

class LoginScreen extends StatefulWidget {

  LoginScreen({ this.login, this.signup });

  final Function login;
  final Function signup;

  @override
  _LoginScreenState createState()=> new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _error = '';
  String _email;
  String _password;
  bool _isloading = false;
  var _formMode = FormMode.LOGIN;
  final _formKey = GlobalKey<FormState>();

  Widget _showCircularProgress(){
    if (_isloading) {
      return Center(child: CircularProgressIndicator());
    } return Container(height: 0.0, width: 0.0,);

  }

  Widget _showErrorMessage() {
    if (_error != null && _error.length > 0 ) {
      return new Text(
        _error,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 2.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
  
  _handleLoginRequest() async {
    final form = _formKey.currentState;
    setState((){
      _error = '';
      _isloading = true;
    });
    form.save();
    if(form.validate()){
      var errorMessage;
      if(_formMode == FormMode.LOGIN){
        errorMessage = await widget.login(_email, _password);
      }
      else if(_formMode == FormMode.SIGNUP){
        errorMessage = await widget.signup(_email, _password);
      }
      if (errorMessage != null) {
        if (errorMessage.runtimeType is String) {
          _error = errorMessage;
        } else {
          setState(() {
            _isloading = false;
            if (Theme.of(context).platform == TargetPlatform.iOS) {
              _error = errorMessage.message;
            } else _error = errorMessage.details;
          });
        }
      }
    }
    setState(() {
          _isloading = false;
        });
  }

  _switchToLogin(){
    setState(() {
          _formMode = FormMode.LOGIN;
        });
    _formKey.currentState.reset();
  }

  _switchToSignup(){
    setState(() {
          _formMode = FormMode.SIGNUP;
        });
     _formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context){

    final emailInput = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0)
        ),
      ),
      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
      onSaved: (value) => _email = value,
    );


    final passwordInput = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0)
        ),
      ),
      validator: (value) => value.isEmpty ? 'Passwrod can\'t be empty' : null,
      onSaved: (value) => _password = value,
    );

    final submitButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: _handleLoginRequest,
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text(
          (_formMode == FormMode.LOGIN) ? 'Login':'Sign Up', 
          style: TextStyle(color: Colors.white)),
      ),
    );


    final forgotLabel = FlatButton(
      child: (_formMode == FormMode.LOGIN) ? 
      Text('Forgot Password?', style: TextStyle(color: Colors.black54)) : Container(height: 0.0), 
      // TODO: Implement
      onPressed: (){},
    );

    final createAccount = FlatButton(
      child: Text(
          (_formMode == FormMode.LOGIN) ?
          'Create New Account': 'Already Have an Account? Log In', 
          style: TextStyle(color: Colors.black54),),
        onPressed: 
          (_formMode == FormMode.LOGIN) ?
          _switchToSignup: _switchToLogin,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: _formKey,
          // autovalidate: _autoValidate,
          child: Padding(
            // shrinkWrap: true,
            padding: EdgeInsets.fromLTRB(24.0,80.0,24.0,0.0),
            child: ListView(
              children: <Widget>[
              emailInput,
              SizedBox(height: 48.0),
              passwordInput,
              _showErrorMessage(),
              _showCircularProgress(),
              SizedBox(height: 48.0,),
              submitButton,
              createAccount,
              forgotLabel,
              ],
            )
          ),
        ),
    );

  } 
}