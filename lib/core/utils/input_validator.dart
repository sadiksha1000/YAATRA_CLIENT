import 'dart:async';

import 'package:dartz/dartz.dart';

import '../errors/failure.dart';

class InputValidator {
  Either<Failure, String> validatePhoneNumber(String phone) {
    try {
      final integer = int.parse(phone);
      if (integer < 10) throw const FormatException();
      return Right(phone);
    } on FormatException {
      return const Left(InvalidInputFailure(properties: []));
    }
  }
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure({required List properties})
      : super(properties: properties);
}

mixin InputValidatorMixin {
  var emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.isEmpty) {
      return sink.addError('Email cannot be empty');
    } else if (email.length < 5) {
      return sink.addError('Email must be at least 5 characters long');
    }
    // regex to validate email
    else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return sink.addError('Email is not valid');
    } else {
      sink.add(email);
    }
  });

  var emptyValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) => {
      if (value.isEmpty)
        {sink.addError('This field cannot be empty')}
      else
        {sink.add(value)}
    },
  );

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.isEmpty) {
      return sink.addError('Password cannot be empty');
    } else if (password.length < 8) {
      return sink.addError('Password must be at least 8 characters long');
    }
    // regex to validate password
    else if (!RegExp(
            r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#$^+=!*()@%&]).{8,}$")
        .hasMatch(password)) {
      return sink.addError('Password is not valid');
    } else {
      sink.add(password);
    }
  });
  var phoneValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (phone.isEmpty) {
      return sink.addError('Phone cannot be empty');
    } else if (phone.length != 10) {
      return sink.addError('Phone must be 10 characters long');
    }
    // regex to validate phone
    else if (!RegExp(r"^[0-9]{10}$").hasMatch(phone)) {
      return sink.addError('Phone is not valid');
    } else {
      sink.add(phone);
    }
  });
  var otpValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (otp, sink) {
    if (otp.isEmpty) {
      return sink.addError('Otp cannot be empty');
    } else if (otp.length != 6) {
      return sink.addError('Otp must be 6 characters long');
    }
    // regex to validate otp
    else if (!RegExp(r"^[0-9]{6}$").hasMatch(otp)) {
      return sink.addError('Otp is not valid');
    } else {
      sink.add(otp);
    }
  });
}
