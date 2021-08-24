import 'dart:async';

class ValidationMixin {
  final validatorFullname = new StreamTransformer<String, String>.fromHandlers(
      handleData: (fullname, sink) {
    if (fullname.isEmpty) {
      sink.addError('Full name  is required');
    } else {
      sink.add(fullname);
    }
  });
  final validatorUsername = new StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    if (username.isEmpty) {
      sink.addError('username is required');
    } else {
      sink.add(username);
    }
  });
  final validatorPhonenumber =
      new StreamTransformer<String, String>.fromHandlers(
          handleData: (phonenumber, sink) {
    if (phonenumber.isEmpty) {
      sink.addError('Phone is required');
    } else {
      sink.add(phonenumber);
    }
  });
  final validatorEmail = new StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {
    if (email.isEmpty) {
      sink.addError("Email is required");
    } else if (email.length < 8) {
      sink.addError("email is to short");
    } else if (!email.contains('@')) {
      sink.addError('Please enter a valid email');
    } else if (email.contains(' ')) {
      sink.addError('Space not allowed');
    } else {
      sink.add(email);
    }
  });
  final validatorPassword = new StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 8) {
      sink.add(password);
    } else {
      sink.addError('Use more than 8 character');
    }
  });
}
