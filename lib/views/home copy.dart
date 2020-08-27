//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:deefirstapp/shared/routing_constants.dart';
import '../views/signin_view.dart';
import 'package:flutter/material.dart';
//import './dialogs.dart';
//import 'package:provider/provider.dart';
//import './signin.dart';
import '../services/auth_service.dart';
//import './networkconnectivity.dart';
//import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/employee_services.dart';
//import '../shared/routing_constants.dart';
class HomePage extends StatefulWidget {
  final String title = 'Flutter Data Table';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//   String _useremail = '';
//   String _token = '';
//   getname() async {
//     var instance = await FirebaseAuth.instance.currentUser();

//     setState(() {
//       _useremail = instance.email.toString();
//     });

//     print(_useremail);
//   }

//   @override
//   void initState() {
//     super.initState();
//     getname();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var connectionStatus = Provider.of<ConnectivityStatus>(context);
//     print('***------>$connectionStatus');
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Welcome to Home Page",
//           style: TextStyle(
//             fontSize: 20,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         automaticallyImplyLeading: false,
//       ),
//       body: connectionStatus == ConnectivityStatus.Offline
//           ? Dialogs.showNoInternetDialog(context)
//           : Container(
//               height: MediaQuery.of(context).size.height,
//               child: Center(
//                 child: Column(
//                   children: <Widget>[
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       "Welcome User :$_useremail",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       "Welcome User :$_token",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     RaisedButton(
//                       child: Text("Sign out"),
//                       onPressed: () {
//                         try {
//                           //FirebaseAuth.instance.signOut();
//                           Fauth().signOutUser();

//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => Signin()),
//                           );
//                         } catch (e) {
//                           print(e);
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }

// class DataTableDemo extends StatefulWidget {
//   //
//   DataTableDemo() : super();

//   final String title = 'Flutter Data Table';

//   @override
//   DataTableDemoState createState() => DataTableDemoState();
// }

//class DataTableDemoState extends State<DataTableDemo> {
  List<Employee> _employees;
  GlobalKey<ScaffoldState> _scaffoldKey;
  // controller for the First Name TextField we are going to create.
  TextEditingController _firstNameController;
  // controller for the Last Name TextField we are going to create.
  TextEditingController _lastNameController;
  Employee _selectedEmployee;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _employees = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _getEmployees();

   
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _createTable() {
    _showProgress('Creating Table...');
    Services.createTable().then((result) {
      if ('success' == result) {
        // Table is created successfully.
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }
      print(result);
    });
  }

  // Now lets add an Employee
  _addEmployee() {
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    _showProgress('Adding Employee...');
    Services.addEmployee(_firstNameController.text, _lastNameController.text)
        .then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh the List after adding each employee...
        _clearValues();
      }
    });
  }

  _getEmployees() {
    _showProgress('Loading Employees...');
    Services.getEmployees().then((employees) {
      setState(() {
        _employees = employees;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${employees.length}");
    });
  }

  _updateEmployee(Employee employee) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Employee...');
    Services.updateEmployee(
            employee.id, _firstNameController.text, _lastNameController.text)
        .then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteEmployee(Employee employee) {
    _showProgress('Deleting Employee...');
    Services.deleteEmployee(employee.id).then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh after delete...
      }
    });
  }

  // Method to clear TextField values
  _clearValues() {
    _firstNameController.text = '';
    _lastNameController.text = '';
  }

  _showValues(Employee employee) {
    _firstNameController.text = employee.firstName;
    _lastNameController.text = employee.lastName;
  }

  // Let's create a DataTable and show the employee list in it.
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('ID'),
            ),
            DataColumn(
              label: Text('FIRST NAME'),
            ),
            DataColumn(
              label: Text('LAST NAME'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: _employees
              .map(
                (employee) => DataRow(cells: [
                  DataCell(
                    Text(employee.id),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.firstName.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      employee.lastName.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteEmployee(employee);
                    },
                  ))
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress), // we show the progress in the title...
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEmployees();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Text(emailid),
            RaisedButton(
              child: Text("Sign out"),
              onPressed: () {
                try {
                  //FirebaseAuth.instance.signOut();
                  AuthService().signOutUser();

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInView()),
                  );
                } catch (e) {
                  print(e);
                }
              },
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _firstNameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'First Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _lastNameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Last Name',
                ),
              ),
            ),
            // Add an update button and a Cancel Button
            // show these buttons only when updating an employee
            _isUpdating
                ? Row(
                    children: <Widget>[
                      OutlineButton(
                        child: Text('UPDATE'),
                        onPressed: () {
                          _updateEmployee(_selectedEmployee);
                        },
                      ),
                      OutlineButton(
                        child: Text('CANCEL'),
                        onPressed: () {
                          setState(() {
                            _isUpdating = false;
                          });
                          _clearValues();
                        },
                      ),
                    ],
                  )
                : Container(),
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEmployee();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
