import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(19, 55, 19, 0),
        reverse: true,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset("lib/assets/arrow.png"),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 25.0)),
            const Text("Регистрация",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "SFProDisplay",
                fontWeight: FontWeight.w800,
                color: Color.fromRGBO(76, 80, 95, 1),
                fontSize: 24,
              )
            ),
            const Padding(padding: EdgeInsets.only(bottom: 17.0)),
            const Text("Заполните все поля, чтобы создать аккаунт",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                color: Color.fromRGBO(149, 149, 149, 1),
                fontSize: 14
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 57.0)),
            const TextField(
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(76, 80, 95, 1)
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.supervisor_account),
                hintText: "Name",
                hintStyle: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(208, 208, 208, 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(208, 208, 208, 1), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    borderSide: BorderSide(color: Color.fromRGBO(16, 168, 229, 1), width: 2)
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 30.0)),
            const TextField(
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(76, 80, 95, 1)
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail_outline_outlined),
                hintText: "Email",
                hintStyle: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(208, 208, 208, 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(208, 208, 208, 1), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    borderSide: BorderSide(color: Color.fromRGBO(16, 168, 229, 1), width: 2)
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 30.0)),
            const TextField(
              obscureText: true,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(76, 80, 95, 1)
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline),
                hintText: "Password",
                hintStyle: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(208, 208, 208, 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(208, 208, 208, 1), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    borderSide: BorderSide(color: Color.fromRGBO(16, 168, 229, 1), width: 2)
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 30.0)),
            const TextField(
              obscureText: true,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(76, 80, 95, 1)
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline),
                hintText: "Confirm Password",
                hintStyle: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(208, 208, 208, 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide(color: Color.fromRGBO(208, 208, 208, 1), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    borderSide: BorderSide(color: Color.fromRGBO(16, 168, 229, 1), width: 2)
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 45.0)),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/map');
                },
                child: const Text("СОЗДАТЬ",
                  style: TextStyle(
                    fontFamily: "SFProDisplay",
                    fontWeight: FontWeight.w500,
                    fontSize: 14
                  ),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: const BorderSide(color: Color.fromRGBO(16, 168, 229, 1)),
                        )
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(Size(169, 47))
                )
            ),
            const Padding(padding: EdgeInsets.only(bottom: 25.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Уже есть аккаунт?",
                    style: TextStyle(
                        fontFamily: "SFProDisplay",
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(149, 149, 149, 1),
                        fontSize: 14
                    )
                ),
                TextButton(
                  child: const Text("Войдите",
                    style: TextStyle(
                        fontFamily: "SFProDisplay",
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(16, 168, 229, 1),
                        fontSize: 14
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
