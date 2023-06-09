import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:demo_app/models/data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';


final checkAdultApi = Provider((ref) =>  CheckAdultImageApi());

class CheckAdultImageApi {

  Future<ResponseObsceneData> checkImageContent( File file) async{

    Uri uri = Uri.parse("https://api.sightengine.com/1.0/check.json");
    var request = http.MultipartRequest("POST", uri);
    request.fields["models"] = 'nudity-2.0';
    request.fields['api_user']= '1334858036';
    request.fields['api_secret'] = 'qhA2cVsdLnfjTHe2mjXe';
    request.files.add(await http.MultipartFile.fromPath("media", file.path ));

    try {
      http.StreamedResponse response = await request.send();
      if(response.statusCode == 200){
        final  data = await response.stream.bytesToString();
        return ResponseObsceneData.fromJson(json.decode(data));
      }else{
        final  data = await response.stream.bytesToString();
        return  ResponseObsceneData.fromJson(json.decode(data));
      }

    }catch(e){
      throw Exception("$e");
    }



  }



}