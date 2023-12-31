import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hancock/openai_service.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Entrance extends StatefulWidget{
  @override
  State<Entrance> createState() => EntranceState();
}

class EntranceState extends State<Entrance> {
  final speechToText = SpeechToText();
  String speech='';
  bool hancock2=false;
   String? gerratedContent;
   String? gernartedimage;
  FlutterTts flutterTts = FlutterTts();
  final OpenAISerive openAISerive = OpenAISerive();
  String lastWords='';
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeechtotext();
    initTexttoSpeech();
    getvice();
  }
void  getvice(){
   flutterTts.getVoices.then((value) { try{
    List<Map>vocie = List<Map>.from(value);
    print(vocie);
  }catch(e){

  }});
}

Future<void> initTexttoSpeech()async {
  await flutterTts.setSharedInstance(true);
  await flutterTts.setVoice({"name": "ja-jp-x-htm-network", "locale": "ja-JP"});
  await flutterTts.setSpeechRate(0.6);

  // await flutterTts.setLanguage('')
  setState(() {
    
  });
}
   Future<void> initSpeechtotext() async{
    await speechToText.initialize();
    setState(() {
      
    });
   }
  Future<void> startListening() async {
    await speechToText.listen(onResult: (SpeechRecognitionResult result) {
      setState(() {
        lastWords = result.recognizedWords;
        print(lastWords);
      });
    });
    setState(() {});
  }

 
 Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }
@override
  void dispose() {
    
    super.dispose();
    speechToText.stop();
  }
  // / This is the callback that the SpeechToText plugin calls when
  // /// the platform returns recognized words.
  // void onSpeechResult(SpeechRecognitionResult result) {
  //   setState(() {
  //     lastWords = result.recognizedWords;
  //   });
  // }
   
  @override
  Widget build(BuildContext context) {

   return Scaffold(appBar: AppBar(centerTitle: true,title: Text("Hancock"),),
   body: SingleChildScrollView(
     child: Column(
      children: [
        Center(
          child: Stack(children: [
            Container(margin: const EdgeInsets.only(top: 50),decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),width: 150,height: 110,),
            AnimatedContainer(duration: Duration(milliseconds: 100),margin: EdgeInsets.only(top: 50,left: 20),width: 110,height: 110,decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: AssetImage(hancock2?'images/bh.png':'images/bhh.png'))),)
            
            ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),

          child:  Container(margin: const EdgeInsets.only(top: 20),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20).copyWith(topLeft:Radius.zero),border: Border.all(color: Colors.pink)),child:  Padding(
            padding:   EdgeInsets.all(8.0),
            child:  Text(gerratedContent==null?"Hisashiburna no mugiwara ! What can I do for u ??":gerratedContent!,style: const TextStyle(fontSize: 25),),
          ),),
        ),
         Padding(
          padding: EdgeInsets.all(12.0),
          child: Align(alignment: Alignment.topLeft,child: GestureDetector(onTap:(){systemstop();} ,child: Text(style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold),"Here are new features"))),
        ),
     if(gernartedimage!=null)Image.network(gernartedimage !),
      ],
     ),
   ),
   
   floatingActionButton: FloatingActionButton(backgroundColor: Colors.pink,onPressed: ()async {
     
    if(await speechToText.hasPermission && speechToText.isNotListening){
      await startListening();
      
      hancock2=true;
    

    }
    else if(speechToText.isListening){
      speech= await openAISerive.isArtPromptAPI(lastWords);
       if(speech.contains('https')){
        gernartedimage=speech;
        gerratedContent=null;
        setState(() {
          
        });
       }else{
        gernartedimage=null;
        gerratedContent=speech;
        systemspeek(speech);
        setState(() {
          
        });
       }
       
      print(speech);
      await stopListening();
      

    }else{
      initSpeechtotext();
    }
    
   },child: const Icon(Icons.heart_broken),),
   );
   
  }
  void systemspeek(content){
    flutterTts.speak(content);
  }
  void systemstop (){
  flutterTts.stop();
    
}
  }
 

