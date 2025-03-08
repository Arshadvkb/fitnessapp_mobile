import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fitnessappnew/templates/login.dart';
import 'dart:convert';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _placeController = TextEditingController();
  final _genderController = TextEditingController();
  final _dobController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  // final _addressController = TextEditingController();
  final _goalController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.green),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _mobileController,
                  decoration: const InputDecoration(
                    labelText: 'Mobile',
                    labelStyle: TextStyle(color: Colors.green),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.green),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _placeController,
                  decoration: const InputDecoration(
                    labelText: 'Place',
                    labelStyle: TextStyle(color: Colors.green),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your place';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _dobController,
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    labelStyle: TextStyle(color: Colors.green),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _dobController.text =
                            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your date of birth';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _goalController,
                  decoration: const InputDecoration(
                    labelText: 'Goal',
                    labelStyle: TextStyle(color: Colors.green),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your goal';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.green),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _heightController,
                  decoration: const InputDecoration(
                    labelText: 'Height (cm)',
                    labelStyle: TextStyle(color: Colors.green),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your height';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _weightController,
                  decoration: const InputDecoration(
                    labelText: 'Weight (kg)',
                    labelStyle: TextStyle(color: Colors.green),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your weight';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.green),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmpasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Colors.green),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'Gender:',
                      style: TextStyle(color: Colors.green),
                    ),
                    Radio<String>(
                      value: 'Male',
                      groupValue: _genderController.text,
                      onChanged: (value) {
                        setState(() {
                          _genderController.text = value!;
                        });
                      },
                    ),
                    const Text('Male'),
                    Radio<String>(
                      value: 'Female',
                      groupValue: _genderController.text,
                      onChanged: (value) {
                        setState(() {
                          _genderController.text = value!;
                        });
                      },
                    ),
                    const Text('Female'),
                  ],
                ),
                if (_genderController.text.isEmpty)
                  const Text(
                    'Please select your gender',
                    style: TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('Pick Image'),
                    ),
                    const SizedBox(width: 10),
                    _image != null
                        ? Image.file(
                            _image!,
                            width: 100,
                            height: 100,
                          )
                        : const Text('No image selected'),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Process data.
                      final sh = await SharedPreferences.getInstance();
                      String? url = sh.getString("url");
                      if (url != null) {
                        print("okkkkkkkkkkkkkkkkk");
                        print(url);
                        var request = http.MultipartRequest(
                            'POST', Uri.parse(url + "/user_register"));
                        request.fields['name'] = _nameController.text;
                        request.fields['phone'] = _mobileController.text;
                        request.fields['email'] = _emailController.text;
                        request.fields['place'] = _placeController.text;
                        request.fields['goal'] = _goalController.text;
                        request.fields['description'] =
                            _descriptionController.text;
                        request.fields['password'] = _passwordController.text;
                        request.fields['confirm_password'] =
                            _confirmpasswordController.text;
                        request.fields['gender'] = _genderController.text;
                        request.fields['dob'] = _dobController.text;
                        request.fields['height'] = _heightController.text;
                        request.fields['weight'] = _weightController.text;
                        if (_image != null) {
                          request.files.add(await http.MultipartFile.fromPath(
                              'image', _image!.path));
                        }
                        var response = await request.send();
                        if (response.statusCode == 200) {
                          var responseData =
                              await response.stream.bytesToString();
                          var jsonData = json.decode(responseData);
                          String status = jsonData['status'].toString();
                          if (status == "ok") {
                            print("registerd");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          } else {
                            print("error");
                          }
                        } else {
                          print("Server error");
                        }
                      } else {
                        print("URL not found in SharedPreferences");
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _mobileController.dispose();
    _confirmpasswordController.dispose();
    _placeController.dispose();
    _genderController.dispose();
    _dobController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    // _addressController.dispose();
    _goalController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
