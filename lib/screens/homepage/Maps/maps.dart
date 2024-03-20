import 'package:apoorv_app/constants.dart';
import 'package:apoorv_app/screens/homepage/Maps/maps_full_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  String? chosenLocation;

  @override
  Widget build(BuildContext context) {
    var l = Constants.mapLinks;
    return Scaffold(
      body: Column(children: [
        Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: [
                    Constants.gradientHigh,
                    Constants.gradientMid,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.all(24),
              width: MediaQuery.of(context).size.width,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Constants.gap,
                  Text(
                    "Map View",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Constants.gap,
                  Text(
                    "Here you can view the location of the events happening in the campus during Apoorv!!",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Constants.gap,
            Constants.gap,
            Center(
              child: DropdownMenu(
                onSelected: (value) => setState(() {
                  chosenLocation = value as String;
                }),
                hintText: "Enter location",
                inputDecorationTheme: const InputDecorationTheme(
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder()),
                textStyle: const TextStyle(color: Colors.white, fontSize: 16),
                dropdownMenuEntries: List.generate(
                  l.length,
                  (ii) => DropdownMenuEntry<String>(
                    value: l.keys.elementAt(ii),
                    label: l.keys.elementAt(ii),
                  ),
                ),
              ),
            ),
          ],
        ),
        Constants.gap,
        if (chosenLocation == null) ...[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              alignment: Alignment.center,
              width: double.infinity,
              child: const Text(
                'Choose a location from the dropdown to begin',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
        if (chosenLocation != null)
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03),
                width: double.infinity,
                child: Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  alignment: WrapAlignment.center,
                  children: l[chosenLocation]!
                      .entries
                      .map(
                        (entry) => GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushNamed(MapsFullView.routeName, arguments: {
                            'text': entry.key,
                            'url': entry.value,
                          }),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.width * 0.45,
                            child: Card(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Hero(
                                      tag: entry.value,
                                      child: Image.network(
                                        entry.value,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      entry.key,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          )
      ]),
    );
  }
}
