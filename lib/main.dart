import 'package:contactapp/models/contact.dart';
import 'package:contactapp/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  DatabaseHelper instance =DatabaseHelper.instance;
  final formKey = GlobalKey<FormState>();
  List<Contact> contacts = [Contact(id: 1,name: 'kelvin',number: '09027454638'),Contact(id: 2, name: 'dave', number: '08184489193')];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Center(child: Text('CRUD')),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key:formKey ,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: nameController,
                        validator: (value){
                        if(value ==null || value.isEmpty){
                          return 'please Enter a name';
                        }
                        },
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Enter full name'
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: numberController,
                        validator: (value){
                          if(value==null || value.length<10){
                            return "please enter a valid mobile number";
                          }
                        },

                          keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            labelText: 'Enter Mobile number'
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        color: Colors.grey,
                        child: TextButton(
                            onPressed: ()=>onSubmit(),
                            child:const Text('Submit',
                              style: TextStyle(
                                color: Colors.white
                              ),
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Expanded(
            //   child: Card(
            //     margin: const EdgeInsets.all(10),
            //     child: ListView.builder(
            //       itemCount: contacts.length,
            //         itemBuilder:(context, index){
            //           return  Column(
            //             children: [
            //               ListTile(
            //                 leading: Icon(
            //                   Icons.account_circle,
            //                   color: Colors.blue[600],
            //                   size: 50,
            //                 ),
            //                 title: Text(contacts[index].name!,
            //                   style: TextStyle(
            //                     color: Colors.blue[600]
            //                   ),
            //                 ),
            //                 subtitle:  Text(
            //                     contacts[index].number!
            //                 ),
            //               ),
            //               const Divider(height: 15,)
            //             ],
            //           );
            //         }
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  onSubmit() async {
    String name;
    String number;
    var form = formKey.currentState;
    Map<String, dynamic> row = {
          'name':'VERSHIMA',
          'number':'123455678'
        };

    print( await instance.query());
    await instance.update(row);
    print( await instance.query());

    // if(form!.validate()){
    //   name = nameController.text.toString();
    //   number = numberController.text.toString();
    //   Map<String, dynamic> row = {
    //     'name':name,
    //     'number':number
    //   };
    //  int returns = await instance.insert(row);
    //
    //  print(await instance.query());
    //   setState(() {
    //     contacts.add(Contact(id: 4,name: name,number: number));
    //   });
    //   form.reset();
    // }

  }
}
