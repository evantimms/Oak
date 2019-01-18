import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_note_app/model/model.dart';
import 'package:flutter_note_app/controllers/database_controller.dart';

void main() {
  test("Database User Test", () async {
    // Setup user
    User user = User();
    user.email = 'crutkows@ualberta.ca';
    user.name = 'Chase Rutkowski';
    user.uuid = 'YEPANL14bpPuPaQL3X9iWMEQhJK2';
    user.username = 'crutkows';

    DatabaseController controller = DatabaseController();
    await controller.addUser(user);
    }
  );

  
}