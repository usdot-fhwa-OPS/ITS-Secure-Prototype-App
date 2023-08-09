import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cybersecurity_its_app/utils/zoom_info.dart';

class SettingsScreen extends StatelessWidget {
  /// Creates a SettingsScreen
  SettingsScreen({required this.label, Key? key}) : super(key: key);

  /// The label
  final String label;

  logoutButtonPressed() {
    print('Logout Pressed.');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(label),
        iconTheme: IconThemeData(
          color: Colors.black,
          size: (22 * Provider.of<ZoomInfo>(context).zoomLevel),
        ),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.only(top: 8.0),
              shrinkWrap: true,
              children: <Widget>[
                ZoomLevelAdjustment(),
              ],
            ),
            Expanded(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: MaterialButton(
                        color: Colors.deepOrange,
                        onPressed: () => logoutButtonPressed(),
                        child: const Text('Logout'),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}

class ZoomLevelAdjustment extends StatelessWidget {
  ZoomLevelAdjustment({super.key});

  zoomLevelChanged(BuildContext context, double? value) {
    zoomLevel = value!;
    context.read<ZoomInfo>().updateZoom(zoomLevel);
  }

  double zoomLevel = 1;
  static final List<double> zoomListLabel = <double>[1.0, 1.25, 1.5, 2];

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Expanded(
            child: Align (
              alignment: Alignment.centerRight,
              child: Icon(Icons.zoom_in,
                size: (18 * Provider.of<ZoomInfo>(context).zoomLevel),
              ),
            ),
        ),
        const Expanded(
          child: Padding(
              padding: EdgeInsets.only(right: 1),
              child: Text(
                "Zoom Level",
                textAlign: TextAlign.center,
              )),
        ),
        Expanded(
            child:
            Padding(
                padding: const EdgeInsets.all(1),
                child: DropdownButton(
                  value: Provider.of<ZoomInfo>(context, listen: false).zoomLevel,
                  onChanged: (double? value) {
                    zoomLevelChanged(context, value);
                  },
                  items: zoomListLabel
                      .map<DropdownMenuItem<double>>((double value) {
                    return DropdownMenuItem<double>(
                      value: value,
                      child: Text("$value"),
                    );
                  }).toList(),
            )),
        ),
      ],
    );
  }

}