import 'package:flutter/material.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 10.0,
          margin: EdgeInsets.all(8.0),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Image(
                image: NetworkImage(
                    'https://image.freepik.com/free-photo/young-beautiful-brunette-businesswoman-smiling-pointing-finger-side_176420-9925.jpg'),
                fit: BoxFit.cover,
                height: 200.0,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'communicate with friends',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Card(
          elevation: 10.0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/portrait-young-beautiful-playful-woman-with-bun-posing_176420-12392.jpg'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Malak Esmail', style: TextStyle(height: 1.4)),
                            SizedBox(
                              width: 7.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16.0,
                            )
                          ],
                        ),
                        Text(
                          'january 21,,2021 at 8:00 pm',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(height: 1.4),
                        )
                      ],
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
