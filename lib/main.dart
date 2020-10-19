import 'dart:ffi';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './fancy.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translator/translator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Voice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SpeechScreen(),
    );
  }
}

class Item {
  const Item(this.name);
  final String name;
}

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';

  String out = " ";
  String la;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(),
    );
  }

  Item selectedUser;
  List<Item> users = <Item>[
    const Item(
      'Afrikaans(af)',
    ),
    const Item(
      'Irish(ga)',
    ),
    const Item(
      'Albanian(sq)',
    ),
    const Item(
      'Italian(it)',
    ),
    const Item(
      'Arabic(ar)',
    ),
    const Item(
      'Japanese(ja)',
    ),
    const Item(
      'Azerbaijani(az)',
    ),
    const Item(
      'Kannada(kn)',
    ),
    const Item(
      'Basque(eu)',
    ),
    const Item(
      'Korean(ko)',
    ),
    const Item(
      'Bengali(bn)',
    ),
    const Item(
      'Latin(la)',
    ),
    const Item(
      'Belarusian(be)',
    ),
    const Item(
      'Latvian(lv)',
    ),
    const Item(
      'Bulgarian(bg)',
    ),
    const Item(
      'Lithuanian(lt)',
    ),
    const Item(
      'Catalan(ca)',
    ),
    const Item(
      'Macedonian(mk)',
    ),
    const Item(
      'Chinese Simplified(zh-CN)',
    ),
    const Item(
      'Malay(ms)',
    ),
    const Item(
      'Chinese Traditional(zh-TW)',
    ),
    const Item(
      'Maltese(mt)',
    ),
    const Item(
      'Croatian(hr)',
    ),
    const Item(
      'Norwegian(no)',
    ),
    const Item(
      'Czech(cs)',
    ),
    const Item(
      'Persian(fa)',
    ),
    const Item(
      'Danish(da)',
    ),
    const Item(
      'Polish(pl)',
    ),
    const Item(
      'Dutch(nl)',
    ),
    const Item(
      'Portuguese(pt)',
    ),
    const Item(
      'English(en)',
    ),
    const Item(
      'Romanian(ro)',
    ),
    const Item(
      'Esperanto(eo)',
    ),
    const Item(
      'Russian(ru)',
    ),
    const Item(
      'Serbian(sr)',
    ),
    const Item(
      'Filipino(tl)',
    ),
    const Item(
      'Slovak(sk)',
    ),
    const Item(
      'Finnish(fi)',
    ),
    const Item(
      'Slovenian(sl)',
    ),
    const Item(
      'French(fr)',
    ),
    const Item(
      'Spanish(es)',
    ),
    const Item(
      'Galician(gl)',
    ),
    const Item(
      'Swahili(sw)',
    ),
    const Item(
      'Georgian(ka)',
    ),
    const Item(
      'Swedish(sv)',
    ),
    const Item(
      'German(de)',
    ),
    const Item(
      'Tamil(ta)',
    ),
    const Item(
      'Greek(el)',
    ),
    const Item(
      'Telugu(te)',
    ),
    const Item(
      'Gujarati(gu)',
    ),
    const Item(
      'Thai(th)',
    ),
    const Item(
     'Haitian Creole(ht)',
    ),
    const Item(
      'Turkish(tr)',
    ),
    const Item(
      'Hebrew(iw)',
    ),
    const Item(
      'Ukrainian(uk)',
    ),
    const Item(
      'Hindi(hi)',
    ),
    const Item(
      'Urdu(ur)',
    ),
    const Item(
      'Hungarian(hu)',
    ),
    const Item(
      'Vietnamese(vi)',
    ),
    const Item(
      'Icelandic(is)',
    ),
    const Item(
      'Welsh(cy)',
    ),
    const Item(
      'Indonesian(id)',
    ),
    const Item(
      'Yiddish(yi)',
    ),
    const Item(
      'Malayalam(ml)',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    void trans(String text, String lang) {
      GoogleTranslator translator = new GoogleTranslator();

      translator.translate(text, to: lang) //translating to hi = hindi
          .then((output) {
        setState(() {
          out = output
              .toString(); //placing the translated text to the String to be used
        });
        print(out);
      });
    }

    void _listen() async {
      if (!_isListening) {
        bool available = await _speech.initialize(
          onStatus: (val) => print('onStatus: $val'),
          onError: (val) => print('onError: $val'),
        );
        if (available) {
          setState(() => _isListening = true);
          _speech.listen(
            onResult: (val) => setState(() {
              _text = val.recognizedWords;

              print(_text);
            }),
          );
        }
      } else {
        setState(() => _isListening = false);
        _speech.stop();
      }
    }

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Color(0xff051E38),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          backgroundColor: Color(0xff064a7a),
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SafeArea(
        child: Container(
            height: queryData.size.height,
            width: queryData.size.width,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: queryData.size.height / 2.4,
                      width: queryData.size.width,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                height: queryData.size.width / 1.75,
                                width: queryData.size.height / 1.85,
                                decoration: BoxDecoration(
                                  color: Color(0xff064a7a),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Column(children: [
                                  new Center(
                                    child: Center(
                                      child: new Text(
                                        _text,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 22),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ])),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(155.0, 0, 0, 0),
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: DropdownButton<Item>(
                                        dropdownColor: Color(0xff051E38),
                                        
                                        
                                        hint: Center(
                                          child: Text("Select language",
                                              style: TextStyle(
                                                color: Colors.white,
                                              )),
                                        ),
                                        value: selectedUser,
                                        onChanged: (Item Value) {
                                          setState(() {
                                            selectedUser = Value;
                                            if (selectedUser.name ==
                                                    ('Chinese Simplified(zh-CN)') ||
                                                selectedUser.name ==
                                                    ('Chinese Traditional(zh-TW)')) {
                                              la = selectedUser.name.substring(
                                                      (selectedUser.name.length - 4) -
                                                          2)[0] +
                                                  selectedUser.name.substring(
                                                      (selectedUser.name.length - 4) -
                                                          2)[1] +
                                                  selectedUser.name.substring(
                                                      (selectedUser.name.length - 4) -
                                                          2)[2] +
                                                  selectedUser.name
                                                      .substring((selectedUser.name.length - 4) - 2)[3] +
                                                  selectedUser.name.substring((selectedUser.name.length - 4) - 2)[4];print(la);
                                            } else
                                              la = (selectedUser.name.substring(
                                                      (selectedUser
                                                                  .name.length -
                                                              1) -
                                                          2)[0] +
                                                  selectedUser.name.substring(
                                                      (selectedUser
                                                                  .name.length -
                                                              1) -
                                                          2)[1]);
                                          });
                                        },
                                        items: users.map((Item user) {
                                          return DropdownMenuItem<Item>(
                                           
                                            value: user,
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  user.name,
                                                  style: TextStyle(
                                                      color: Colors.white,backgroundColor:  Color(0xff051E38)),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: queryData.size.height / 3,
                  width: queryData.size.width,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: queryData.size.width / 1.75,
                          width: queryData.size.height / 1.85,
                          decoration: BoxDecoration(
                            color: Color(0xff064a7a),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: new Center(
                            child: new Text(
                              out,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 40.0),
                      child: Container(
                        height: queryData.size.height / 11,
                        width: queryData.size.width / 3,
                        child: FancyButton(
                          onPressed: () {
                            trans(_text, la);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

//appBar: AppBar(
//title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
//),
/*  floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child:  Column(children: <Widget>[
        
      Container(
           padding: const EdgeInsets.fromLTRB(30.0, 70.0, 30.0, 20.0),
          child: Column(children: <Widget>[
          Text(_text),
          
       
      
          
             Text(out
           ),
         ]),
       ),
       Align(
            alignment: Alignment.bottomRight,

            child: RaisedButton( 
              color: Colors.blue,
             child: Text(
                 "Press !!"), //on press to translate the language using function
              onPressed: () {
                trans(_text);
              },
            ),),]
      ),
    ),); 
    );
  }

   void trans(String text) {
    GoogleTranslator translator = new GoogleTranslator();
   
    translator.translate(text, to: 'hi') //translating to hi = hindi
        .then((output) {
      setState(() {
        out=output.toString(); //placing the translated text to the String to be used
      });
      print(out);
    });
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            
            _text = val.recognizedWords;
            
            print(_text);

            
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
*/
