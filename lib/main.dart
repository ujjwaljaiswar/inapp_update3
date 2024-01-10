import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('Check for Updates'),
            onPressed: () async {
              await checkForUpdates(context);
            },
          ),
        ),
      ),
    );
  }

  Future<void> checkForUpdates(BuildContext context) async {
    try {
      // Check for update
      InAppUpdate.checkForUpdate().then((updateStatus) {
        if (updateStatus.updateAvailable)
        {
          InAppUpdate.performFlexibleUpdate();
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Information'),
                content: Text('The app is up to date.'),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      });
    } catch (e) {
      print('Error checking for updates: $e');
    }
  }
}
