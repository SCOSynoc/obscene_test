
import 'dart:io';

import 'package:demo_app/controller/api_controller.dart';
import 'package:demo_app/repository/api_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profanity_filter/profanity_filter.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  TextEditingController textEditingController = TextEditingController();
  TextEditingController imageURlController = TextEditingController();
  String typedWords = "";
  final filter = ProfanityFilter();
  bool hasProfanity = false;
  String networkImage = "";
  List<String> allProfaneWords = [];
  List<String> customBadwords = ["madarchod", "lavde", "bosdike", "gandu", "behenchod", "randi", "gand", "mc" , "bc"];
  double contentA = 0.0;
  String imageMessage = "";
  File impagePath = File("");



  void checkImageContent(File path) async{
    /*final apiService = CheckAdultImageApi();
    dynamic response =await apiService.checkImageContent(path);
    if(response["status"] == "success"){
      contentA = double.parse(response["nudity"]["erotica"].toString()) * 100 ;
      if(contentA > 50) {
        setState(() {
          imageMessage = "Contains nudity";
        });
      }else{
        setState(() {
          imageMessage = "Images are clear";
        });
      }
    }*/
    String futureMessage = await ref.read(obsceneController).getResponseData(path);
   setState(() {
     imageMessage = futureMessage;
   });




  }

  @override
  Widget build(BuildContext context) {
    ProfanityFilter customList = ProfanityFilter.filterAdditionally(customBadwords);
    return Scaffold(
      appBar: AppBar(title:Text("Home"), backgroundColor: Colors.cyan, ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: Container(child: TextFormField(controller: textEditingController, onChanged: (String value) {

                setState(() {
                  hasProfanity = customList.hasProfanity(textEditingController.text);
                  allProfaneWords = customList.getAllProfanity(textEditingController.text);

                });
              },),),
            ),
            Visibility(
              visible: textEditingController.text.isEmpty ? false : true,
              child: Padding(
                padding: const EdgeInsets.all(38.0),
                child: Container(
                    child: hasProfanity ?
                    Text("The text contains bad words: ${allProfaneWords}",style: TextStyle(fontSize: 16),) :
                        Text("The text is clean",style: TextStyle(fontSize: 25),)
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 5),
              child: Center(
                child:
                CupertinoButton(
                        color: Colors.cyan,
                        child: Text("Upload Image"), onPressed: () {
                          pickFilesFromGallery();
                    }),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Visibility(
                visible: impagePath.path.isEmpty ? false : true,
                child: Container(
                  height: 200,
                  width: 200,
                  child: Image.file(impagePath),
                ),
              ),
            ),

            Visibility(
                visible: impagePath.path.isEmpty ? false : true,
                child: Container(child: Text("${imageMessage}", style: TextStyle(fontSize: 25),),
                )
            )

          ],
        ),
      ),
    );
  }

  void pickFilesFromGallery() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path.toString());
      setState(() {
        impagePath = file;
      });

      checkImageContent(impagePath);
    } else {
       print("here data is empty");
      // User canceled the picker
    }
  }
}
