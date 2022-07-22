import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/screens/details/widgets/date_picker.dart';
import 'package:task_app/screens/details/widgets/task_timeline.dart';
import 'package:task_app/screens/details/widgets/task_title.dart';
import 'package:task_app/screens/home/home.dart';

class DetailPage extends StatelessWidget {
  final Task task;
  DetailPage(this.task);

  @override
  Widget build(BuildContext context) {
    final detailList = task.desc;
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(slivers: [
        _buildAppBar( context),
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [DatePicker(), TaskTitle()]),
          ),
        ),
        detailList == null
            ? SliverFillRemaining(
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'No task today',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                ),
              )
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                    (_, index) => TaskTimeline(
                          detailList[index],
                        ),
                    childCount: detailList.length),
              ),
      ]),
    );
  }

  Widget _buildAppBar(context) {
    return SliverAppBar(
      expandedHeight: 90,
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, size: 20),
        onPressed: (){ 
          // print('You clicked me');
          // Navigator.of(context).pop;
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
        }
      ),
      actions: [
        Icon(
          Icons.more_vert,
          size: 40,
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
          title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(
              task.title! + ' tasks',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'You have ${task.left} task for today!',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            )
          ])),
    );
  }
}
