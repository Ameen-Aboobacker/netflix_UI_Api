import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix/presentation/widgets/video_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String posterPath;
  final String movieName;
  final String description;

  const ComingSoonWidget({
    super.key,
    required this.id,
    required this.month,
    required this.day,
    required this.posterPath,
    required this.movieName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: 55,
          height: 550,
          child: Column(
            children:  [
              Text(
                month,
                style: const TextStyle(fontSize: 16, color: kGrey),
              ),
              Text(
                day,
                style: const TextStyle(
                  fontSize: 30,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width - 55-10,
          height: 550,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               VideoWidget(image: posterPath,),
              kHeight,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      movieName,
                      style: GoogleFonts.kaushanScript(
                        textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const CustomButtonWidget(
                    icon: Icons.notifications,
                    title: 'Remind me',
                    textSize: 10,
                  ),
                  kwidth,
                 const  CustomButtonWidget(
                    icon: Icons.info_outlined,
                    title: 'info',
                    textSize: 10,
                  ),
                  kwidth15,
                ],
              ),
              kHeight,
              Text('coming on $month-$day  '),
              kHeight20,
               Text(
                movieName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              kHeight,
              Text(
                description,
                style: const TextStyle(
                  color: kGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
