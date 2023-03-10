import 'package:flutter/cupertino.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/search/widgets/title.dart';

const imageUrl="https://www.themoviedb.org/t/p/w533_and_h300_bestv2/5pMy5LF2JAleBNBtuzizfCMWM7k.jpg";
class SearchIdle extends StatelessWidget {
  const SearchIdle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        const SearchTextTitle(title: "Top Searches",),
        kHeight20,
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (ctx, index) =>const  TopSearchItemTile(), 
            separatorBuilder: (ctx, index) =>kHeight20, 
            itemCount: 10),
        ),
      ],

    );
  }
}



class TopSearchItemTile extends StatelessWidget {
const TopSearchItemTile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final screenWidth=MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screenWidth*0.35,
          height: 70,
          decoration: const BoxDecoration(
            image:DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl)) ),
        ),
        kwidth,
        const Expanded(
          child: Text(
            'Movie Name',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const Icon(CupertinoIcons.play_circle, color: kwhite,size:50,)
      
      ],
    );
  }
}
