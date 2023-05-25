import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/my_app.dart';
import 'package:sasuki/app/shared_funs/pre_init_app.dart';

void main() async {
  await preRun();
  // 
  runApp(MyApp());

}



// import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget child;

  const ResponsiveWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: _buildLayout(constraints, orientation),
            );
          },
        );
      },
    );
  }

  Widget _buildLayout(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      // Customize your responsive layout for portrait mode
      if (constraints.maxHeight > 800) {
        // Example: Use a different layout for devices with height greater than 600
        return Container(
          color: Colors.blue,
          child: child,
        );
      } else {
        return Container(
          color: Colors.green,
          child: child,
        );
      }
    } else {
      // Customize your responsive layout for landscape mode
      return Container(
        color: Colors.orange,
        child: child,
      );
    }
  }
}

class MyAapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Responsive App'),
        ),
        body: ResponsiveWidget(
          child: Center(
            child: Text(
              'Hello, Flutter!',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}

void maiwn() {
  runApp(MyApp());
}
