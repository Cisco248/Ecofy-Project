import 'package:e_wms_mobile/data/model/auth_model.dart';

class AuthDatabase extends AuthModel {
  AuthDatabase()
    : super(
        userId: '0001',
        userFirstName: 'John',
        userLastName: 'Doe',
        userEmail: 'johndoe@example.com',
        userPassword: 'Test@1234',
        userMobileNum: 0701234567,
      );
}
