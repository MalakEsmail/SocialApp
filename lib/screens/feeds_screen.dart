import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/models/post_model.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, state) {
          return ConditionalBuilder(
              condition: SocialCubit.get(context).posts.length > 0 &&
                  SocialCubit.get(context).userModel != null,
              fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ),
              builder: (context) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
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
                      ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10.0,
                        ),
                        itemBuilder: (context, index) => buildPostItem(
                            SocialCubit.get(context).posts[index],
                            context,
                            index),
                        itemCount: SocialCubit.get(context).posts.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                );
              });
        },
        listener: (context, state) {});
  }

  Widget buildPostItem(PostModel model, context, index) => Card(
        elevation: 10.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage('${model.image}'),
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
                          Text('${model.name}', style: TextStyle(height: 1.4)),
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
                        '${model.dateTime}',
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
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              /*SizedBox(
                height: 15,
              )*/
              /*Padding(
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
                  ),*/
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 15),
                  child: Container(
                    height: 200.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                          image: NetworkImage('${model.postImage}'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.favorite_border),
                              onPressed: () {}),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                          )
                        ],
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
                                icon: Icon(Icons.comment), onPressed: () {}),
                            SizedBox(
                              width: 5,
                            ),
                            Text('0 comments')
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3.0),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).userModel.image}'),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            'write commnet ...',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(height: 1.4),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.favorite_border),
                              onPressed: () {
                                String id =
                                    SocialCubit.get(context).postsId[index];
                                SocialCubit.get(context).likePost(id);
                              }),
                          Text('Like')
                        ],
                      ),
                    ),
                    onTap: () {},
                  )
                ],
              )
            ],
          ),
        ),
      );
}
