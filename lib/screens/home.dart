import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer/icon/my_icon_icons.dart';

import 'package:prayer/provider/pray.dart';
import 'package:prayer/widgets/detail_time.dart';
import 'package:prayer/widgets/next_prayer.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime selectedDate = DateTime.parse(
      DateFormat("yyyy-MM-dd").format(DateTime.now()).toString());
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: Colors.blue[800]),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  String dropdownValue = 'cairo';
  @override
  Widget build(BuildContext context) {
    bool _fajr = false;
    bool _dhuhr = false;
    bool _asr = false;
    bool _maghrib = false;
    bool _isha = false;

    final pray = Provider.of<Pray>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: FutureBuilder(
        future: pray.fetchAndSet(selectedDate.toString(), dropdownValue),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.zero,
                  height: mediaQuery.size.height * .67,
                  width: mediaQuery.size.width * .8,
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: pray.items.length,
                    itemBuilder: (context, i) {
                      String dateFajr =
                          DateFormat("yyyy-MM-dd").format(DateTime.now()) +
                              ' ' +
                              pray.items[i].times['Fajr'];
                      String dateDhuhr =
                          DateFormat("yyyy-MM-dd").format(DateTime.now()) +
                              ' ' +
                              pray.items[i].times['Dhuhr'];
                      String dateAsr =
                          DateFormat("yyyy-MM-dd").format(DateTime.now()) +
                              ' ' +
                              pray.items[i].times['Asr'];
                      String dateMaghrib =
                          DateFormat("yyyy-MM-dd").format(DateTime.now()) +
                              ' ' +
                              pray.items[i].times['Maghrib'];
                      String dateIsha =
                          DateFormat("yyyy-MM-dd").format(DateTime.now()) +
                              ' ' +
                              pray.items[i].times['Isha'];
                      String dateNow =
                          DateFormat("yyyy-MM-dd HH:MM").format(DateTime.now());

                      int difference = DateTime.parse(dateFajr)
                          .difference(DateTime.parse(dateNow))
                          .inSeconds;
                      int difference1 = DateTime.parse(dateDhuhr)
                          .difference(DateTime.parse(dateNow))
                          .inSeconds;
                      int difference2 = DateTime.parse(dateAsr)
                          .difference(DateTime.parse(dateNow))
                          .inSeconds;
                      int difference3 = DateTime.parse(dateMaghrib)
                          .difference(DateTime.parse(dateNow))
                          .inSeconds;
                      int difference4 = DateTime.parse(dateIsha)
                          .difference(DateTime.parse(dateNow))
                          .inSeconds;

                      if (difference.isNegative) {
                        difference = 10000000000;
                      }

                      if (difference1.isNegative) {
                        difference1 = 1000000000;
                      }
                      if (difference2.isNegative) {
                        difference2 = 1000000000;
                      }
                      if (difference3.isNegative) {
                        difference3 = 1000000000;
                      }
                      if (difference4.isNegative) {
                        difference4 = 1000000000;
                      }
                      if (difference < difference1 &&
                          difference < difference2 &&
                          difference < difference3 &&
                          difference < difference4) {
                        _fajr = true;
                        _asr = false;
                        _isha = false;
                        _dhuhr = false;
                        _maghrib = false;
                      }
                      if (difference1 < difference &&
                          difference1 < difference2 &&
                          difference1 < difference3 &&
                          difference1 < difference4) {
                        _fajr = false;
                        _asr = false;
                        _isha = false;
                        _dhuhr = true;
                        _maghrib = false;
                      }
                      if (difference2 < difference &&
                          difference2 < difference1 &&
                          difference2 < difference3 &&
                          difference2 < difference4) {
                        _fajr = false;
                        _asr = true;
                        _isha = false;
                        _dhuhr = false;
                        _maghrib = false;
                      }
                      if (difference3 < difference &&
                          difference3 < difference1 &&
                          difference3 < difference2 &&
                          difference3 < difference4) {
                        _fajr = false;
                        _asr = false;
                        _isha = false;
                        _dhuhr = false;
                        _maghrib = true;
                      }
                      if (difference4 < difference &&
                          difference4 < difference1 &&
                          difference4 < difference2 &&
                          difference4 < difference3) {
                        _fajr = false;
                        _asr = false;
                        _isha = true;
                        _dhuhr = false;
                        _maghrib = false;
                      }

                      return Column(
                        children: [
                          (_fajr)
                              ? NextPrayer('Fajr', MyIcon.sunrise,
                                  pray.items[0].times['Fajr'])
                              : DetailTime('Fajr', MyIcon.sunrise,
                                  pray.items[0].times['Fajr']),
                          (_dhuhr)
                              ? NextPrayer('Dhuhr', MyIcon.sun_inv,
                                  pray.items[0].times['Dhuhr'])
                              : DetailTime('Dhuhr', MyIcon.sun_inv,
                                  pray.items[0].times['Dhuhr']),
                          (_asr)
                              ? NextPrayer(
                                  'Asr', MyIcon.sun, pray.items[0].times['Asr'])
                              : DetailTime('Asr', MyIcon.sun,
                                  pray.items[0].times['Asr']),
                          (_maghrib)
                              ? NextPrayer('Maghrib', MyIcon.fog_sun,
                                  pray.items[0].times['Maghrib'])
                              : DetailTime('Maghrib', MyIcon.fog_sun,
                                  pray.items[0].times['Maghrib']),
                          (_isha)
                              ? NextPrayer('Isha', MyIcon.moon_sun,
                                  pray.items[0].times['Isha'])
                              : DetailTime('Isha', MyIcon.moon_sun,
                                  pray.items[0].times['Isha']),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: mediaQuery.size.width * .8,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date is: ",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Text(
                                "${DateFormat("yyyy-MM-dd").format(selectedDate)}",
                                style: TextStyle(
                                  fontSize: 20,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>[
                            'shanghai',
                            'istanbul',
                            'buenos-air',
                            'mumbai',
                            'mexico-city',
                            'beijing',
                            'karachi',
                            'tianjin',
                            'guangzhou',
                            'delhi',
                            'moscow',
                            'shenzhen',
                            'dhaka-bd-bd-4933',
                            'seoul',
                            'sao-paulo',
                            'wuhan',
                            'lagos-11021',
                            'jakarta',
                            'tokyo',
                            'new-york',
                            'dongguan',
                            'taipei',
                            'kinshasa',
                            'lima',
                            'cairo',
                            'bogota-co',
                            'london',
                            'chongqing',
                            'chengdu-cn',
                            'baghdad',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                'City is: $value',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            );
                          }).toList(),
                        ),
                        Text(
                          'Country is: ${pray.items[0].location['country']}',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Country Code is: ${pray.items[0].location['country_code']}',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Timezone is: ${pray.items[0].location['timezone']}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      backgroundColor: Colors.grey[400],
    );
  }
}
