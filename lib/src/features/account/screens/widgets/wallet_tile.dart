import 'package:flutter/material.dart';

Widget walletTile(context) => FlatButton(
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => WalletPage(
        //             token: user.accessToken,
        //           )),
        // );
        // Navigator.pushNamed(context, wallet, arguments: user.accessToken);
      },

      //color: Colors.grey[100],
      padding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 40,
              child: AspectRatio(
                aspectRatio: 1,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Icon(Icons.account_balance_wallet_outlined,
                      color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              flex: 60,
              child: Text(
                "Wallet",
                textScaleFactor: 1.2,
                style: TextStyle(
                  letterSpacing: 0.5,
                  color: Theme.of(context).textTheme.headline1!.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
