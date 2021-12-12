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

  /**
   * 0 -- not connected yet
   * 1 -- request account
   * 2 -- connected to account
   * 3 -- different chain id
   * 4 -- different account
   * 5 -- user denied sign request
   */

  int connectionStatus = 0;


  void initialiseWalletProvider() async {
    if (ethereum != null) {
      print("ethereum wallet found");
      setState(() {
        connectionStatus = 1;
        walletConnectionStatus = "ethereum wallet found";
      });
      try {
        final acc = await ethereum.requestAccount();

        setState(() {
          connectionStatus = 2;
          walletConnectionStatus = acc[0];
        });

        print(acc);
        changeChainID();
        changeAccount();
      } on EthereumUserRejected {
        connectionStatus = 5;
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

  void changeChainID() async{
    if(ethereum != null){
      await ethereum.onChainChanged((chainId) {
        setState(() {
          walletConnectionStatus = "chain id changed to "+chainId.toString()+" ";
        });
      });
    }else{
      print("ethereum wallet not found");
      setState(() {
        walletConnectionStatus = "ethereum wallet not found";
      });
    }
  }

  void changeAccount() async{
    if(ethereum != null){
      await ethereum.onAccountsChanged((account) {
        setState(() {
          walletConnectionStatus = "chain id changed to "+account[0].toString()+" ";
        });
      });
    }else{
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

        Offstage(
          offstage: connectionStatus == 0 ? false:true,
          child: Container(
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
        ),

        Text(walletConnectionStatus)
      ],
    ));
  }
}
