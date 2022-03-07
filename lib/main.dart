import 'package:contactapp/models/contact.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final formKey = GlobalKey<FormState>();
  Contact contact = Contact();
  List<Contact> contacts = [];

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
                        validator: (value){
                        if(value ==null || value.isEmpty){
                          return 'please Enter a name';
                        }
                        },
                        onSaved: (value){
                          setState(() {
                            contact.name=value;
                          });

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
                        validator: (value){
                          if(value==null || value.length<10){
                            return "please enter a valid mobile number";
                          }
                        },
                        onSaved: (value){
                          setState(() {
                            contact.number=value;
                          });

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
            Expanded(
              child: Card(
                margin: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: contacts.length,
                    itemBuilder:(context, index){
                      return  Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.account_circle,
                              color: Colors.blue[600],
                              size: 50,
                            ),
                            title: Text('',
                              style: TextStyle(
                                color: Colors.blue[600]
                              ),
                            ),
                            subtitle:  Text(
                                contacts[index].number!
                            ),
                          ),
                          const Divider(height: 15,)
                        ],
                      );
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  onSubmit(){
    var form = formKey.currentState;
    if(form!.validate()){
      form.save();
      setState(() {
        contacts.add(Contact(id: null,name:contact.name,number: contact.number));
      });

      form.reset();
    }

  }
}
