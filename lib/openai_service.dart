import 'dart:convert';

import 'package:hancock/secret.dart';
import 'package:http/http.dart' as http;
class OpenAISerive{
  final List<Map<String ,String >> mesaage=[];
  Future<String > isArtPromptAPI(String prompt) async{
    try{
        final res = await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
           'Authorization': 'Bearer $apikey',
        },
        body: jsonEncode({
           'model': 'gpt-3.5-turbo',
    "messages": [
      {
        'role': 'user',
        'content': 'Does this message want to generate an ai picture similar? $prompt Just answer in yes or no format',
      }
    ],
        }),

        );
        print(res.body);
        if(res.statusCode ==200){
          String  content = jsonDecode(res.body)['choices'][0]['message']['content']; 
          content = content.trim();
        switch (content) {
          case 'Yes':
          case 'yes':
          case 'Yes.':
          case 'yes.':
            final res = await dallEAPI(prompt);
            
            return res;
          default:
          final res =await ChatGPTAPI(prompt);
          return res;
        }
        }
        return 'Mugiwara';
    }catch(e){
      return e.toString();
    }
  }
  
  Future<String> ChatGPTAPI(String prompt)async {
    mesaage.add({
        'role':'user',
        'content':prompt,
    });
     try{
        final res = await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
           'Authorization': 'Bearer $apikey',
        },
        body: jsonEncode({
           'model': 'gpt-3.5-turbo',
    "messages": mesaage,
     
        }),

        );
        
        if(res.statusCode ==200){
          String  content = jsonDecode(res.body)['choices'][0]['message']['content']; 
          content = content.trim();
          mesaage.add({
            'role':'assistant',
            'content':content,
          });
          return content;
        }
        return 'Mondey D.Luffy';
    }catch(e){
      return e.toString();
    }
  }

  
  
  Future<String > dallEAPI(String prompt) async {
    mesaage.add({
        'role':'user',
        'content':prompt,
    });
     try{
        final res = await http.post(Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: {
          'Content-Type': 'application/json',
           'Authorization': 'Bearer $apikey',
        },
        body: jsonEncode({
           'prompt':prompt,
           'n':1,
     
        }),

        );
        
        if(res.statusCode ==200){
          String  imaageurl = jsonDecode(res.body)['data'][0]['url']; 
          imaageurl = imaageurl.trim();
          mesaage.add({
            'role':'assistant',
            'content':imaageurl,
          });
          return imaageurl;
        }
        return 'Mugiwara';
    }catch(e){
      return e.toString();
    }
  }
 
  }
