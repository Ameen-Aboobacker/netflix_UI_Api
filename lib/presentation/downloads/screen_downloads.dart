import 'dart:math';

import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/widgets/app_bar_widget.dart';

class ScreenDownloads extends StatelessWidget {
   ScreenDownloads({Key? key}) : super(key: key);
final _widgetList=[
            const _SmartDownloads(),
            kwidth,
            Section2(),
            const Section3()
          ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarWidget(
            title: 'Download',
          ),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(10),
          itemBuilder: (ctx,index)=>_widgetList[index], 
          separatorBuilder: (ctx,index)=>const SizedBox(height: 15,),
          itemCount: _widgetList.length)
        );
  }
}

class Section2 extends StatelessWidget {
  Section2({Key? key}) : super(key: key);
  final List imagelist = [
    "https://www.themoviedb.org/t/p/w220_and_h330_face/qi9r5xBgcc9KTxlOLjssEbDgO0J.jpg",
    "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/sv1xJUazXeYqALzczSZ3O6nkH75.jpg",
    "https://www.themoviedb.org/t/p/w220_and_h330_face/dm06L9pxDOL9jNSK4Cb6y139rrG.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Text(
          'Introducing Downloads for You',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kwhite,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        kHeight,
        const Text(
          "We will download a personilised selection of\nmovies and shows for you, so there's\nalways something to watch on your\n device.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        SizedBox(
            width: size.width,
            height: size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.6),
                  radius: size.width * 0.37,
                ),
                DownloadsImageWidget(
                  size: Size(size.width * 0.35, size.width * 0.55,),
                  imagelist: imagelist[0],
                  margin: const EdgeInsets.only(left: 170,top:30, ),
                  angle: 20,
                ),
                DownloadsImageWidget(
                    size: Size(size.width * 0.35, size.width * 0.55),
                    imagelist: imagelist[1],
                    margin: const EdgeInsets.only(
                      right: 170,
                      top:30,
                    ),
                    angle: -20),
                DownloadsImageWidget(
                  size: Size(size.width * 0.4, size.width * 0.6),
                  imagelist: imagelist[2],
                  margin: const EdgeInsets.only(
                    bottom: 10,top:20,
                  ),
                  radius: 10,
                ),
              ],
            )),
      ],
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width:double.infinity,
          child: MaterialButton(
            color: kButtonColorblue,
            onPressed: () {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              6,
            )),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Set Up',
                style: TextStyle(
                    color: kwhite, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        kHeight,
        MaterialButton(
          color: kButtonColorwhite,
          onPressed: () {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'See what you can download ',
              style: TextStyle(
                  color: kblack, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        kwidth,
        Icon(
          Icons.settings,
          color: kwhite,
        ),
        kwidth,
        Text('Smart Downloads')
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget({
    super.key,
    required this.size,
    required this.imagelist,
    required this.margin,
    this.angle = 0,
    this.radius = 10,
  });

  final Size size;
  final String imagelist;
  final double angle;
  final EdgeInsets margin;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Transform.rotate(
        angle: angle * pi / 180,
        child: ClipRRect(
           borderRadius: BorderRadius.circular(radius),
          child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
               
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(imagelist))),
          ),
        ),
      ),
    );
  }
}
