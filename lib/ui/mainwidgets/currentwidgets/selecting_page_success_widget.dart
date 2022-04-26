import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usoundradio/ui/customized/custom_text.dart';

import '../../colors_assets.dart';

class SelectingPageSuccess extends StatefulWidget {
  const SelectingPageSuccess({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _StateSuccessSelectingPage();
  
}
class _StateSuccessSelectingPage extends State<SelectingPageSuccess>{
  var listImages = ['assets/happy_frame.png','assets/sad_frame.png',
    'assets/calm_frame.png','assets/cheerful_frame.png'];
  var listTitles = ['Радостное', 'Печальное', 'Спокойное', 'Бодрое'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [beginBackColor, endBackColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            firstSliver()
          ],
        ),
      ),
    );
  }
  Widget firstSliver() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listImages.length,
          itemBuilder: (context, index) {
            return GestureDetector(child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Stack(
                  children: [
                    Positioned(
                      top: 5,
                      bottom: 25,
                      left: 30,
                      right: 30,
                      child: Image.asset(listImages[index]),),
                    Positioned(
                        bottom: 4,
                        right: 0,
                        left: 0,
                        child: Align(alignment: Alignment.bottomCenter,
                          child: GradientText(listTitles[index],
                            style: GoogleFonts.roboto(fontSize: 15),
                            gradient: LinearGradient(colors: [Colors.white,
                              Colors.white.withOpacity(0.3)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),),) )
                  ],
                )
            ),
              onTap: (){

              },
            );
          },
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 2 / 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5
          ),
        ),
      ),
    );
  }
  
}
