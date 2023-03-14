import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix/presentation/widgets/video_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 500,
          child: Column(
            children: const [
              Text(
                'FEB',
                style: TextStyle(fontSize: 16, color: kGrey),
              ),
              Text(
                '11',
                style: TextStyle(
                  fontSize: 30,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width - 50,
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VideoWidget(),
              kHeight,
              Row(
                children: [
                  Text(
                    'TALL GIRL 2',
                    style: GoogleFonts.kaushanScript(
                      textStyle: const TextStyle(
                        fontSize: 35,
                        letterSpacing: -4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: const [
                      CustomButtonWidget(
                        icon: Icons.notifications,
                        title: 'Remind me',
                        textSize: 10,
                      ),
                      kwidth,
                      CustomButtonWidget(
                        icon: Icons.info_outlined,
                        title: 'info',
                        textSize: 10,
                      ),
                      kwidth15,
                    ],
                  ),
                ],
              ),
              kHeight,
              const Text('coming on friday '),
              kHeight20,
              const Text(
                'TALL GIRL 2',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              kHeight,
              const Text(
                'Landing the lead in the school musical is a dream come true for Jodi, until the pressure sends her confidence — and her relationship — into a tailspin.',
                style: TextStyle(
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
