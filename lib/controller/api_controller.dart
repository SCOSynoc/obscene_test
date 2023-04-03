

import 'dart:io';

import 'package:demo_app/models/data_model.dart';
import 'package:demo_app/repository/api_service.dart';
import 'package:riverpod/riverpod.dart';

final obsceneController = Provider((ref){
  final contentRepository = ref.watch(checkAdultApi);
  return CheckAdultApiController(ref: ref, apiRepository: contentRepository);
});

class CheckAdultApiController {
   final CheckAdultImageApi apiRepository;
   final ProviderRef ref;

   CheckAdultApiController({required this.ref,required this.apiRepository});

   Future<String> getResponseData(File file) async{
     final ResponseObsceneData data = await apiRepository.checkImageContent(file);
     double contentA = 0;
     String imageMessage = "";
     if(data.status == "success"){
       contentA = data.nudity == null ? 0 :double.parse(data.nudity!.erotica.toString()) * 100 ;
       if(contentA > 50) {
           imageMessage = "Contains nudity";
       }else{
           imageMessage = "Images are clear";
       }
     }else{
       imageMessage = "Something went wrong";
     }
     return imageMessage;
   }


}