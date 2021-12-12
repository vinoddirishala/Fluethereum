import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Home();
  }
}

class Home extends State<HomePage> {
  String walletConnectionStatus = "";

  void initialiseWalletProvider() async {
    if (ethereum != null) {
      print("ethereum wallet found");
      setState(() {
        walletConnectionStatus = "ethereum wallet found";
      });
      try {
        final acc = await ethereum.requestAccount();

        setState(() {
          walletConnectionStatus = acc[0];
        });

        print(acc);
      } on EthereumUserRejected {
        print("User reject sign in");
        setState(() {
          walletConnectionStatus = "User rejected sign in";
        });
      }
    } else {
      print("ethereum wallet not found");
      setState(() {
        walletConnectionStatus = "ethereum wallet not found";
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          child: FlatButton(
            child: Text('Login'),
            color: Colors.blueAccent,
            textColor: Colors.white,
            onPressed: () {
              initialiseWalletProvider();
            },
          ),
        ),
        Text(walletConnectionStatus)
      ],
    ));
  }
}
