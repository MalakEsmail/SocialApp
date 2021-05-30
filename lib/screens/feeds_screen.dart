import 'package:flutter/material.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                      'https://image.freepik.com/free-photo/young-beautiful-brunette-businesswoman-smiling-pointing-finger-side_176420-9920.jpg'),
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
                        radius: 20.0,
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
                              Text('Malak Esmail',
                                  style: TextStyle(height: 1.4)),
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
                      )),
                      IconButton(icon: Icon(Icons.more_horiz), onPressed: () {})
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ),
                  Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 5),
                    child: Container(
                      width: double.infinity,
                      child: Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: 6),
                            child: Container(
                                height: 20,
                                child: MaterialButton(
                                  onPressed: () {},
                                  child: Text(
                                    '#software',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  padding: EdgeInsets.zero,
                                  minWidth: 1.0,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: 6),
                            child: Container(
                                height: 20,
                                child: MaterialButton(
                                  onPressed: () {},
                                  child: Text(
                                    '#software development',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  padding: EdgeInsets.zero,
                                  minWidth: 1.0,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: 6),
                            child: Container(
                                height: 20,
                                child: MaterialButton(
                                  onPressed: () {},
                                  child: Text(
                                    '#flutter',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  padding: EdgeInsets.zero,
                                  minWidth: 1.0,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 200.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://image.freepik.com/free-photo/young-beautiful-brunette-businesswoman-smiling-pointing-finger-side_176420-9920.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                IconButton(
                                    icon: Icon(Icons.favorite_border),
                                    onPressed: () {}),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('120')
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    icon: Icon(Icons.comment),
                                    onPressed: () {}),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('120 comments')
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  )
               ,Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ), ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
