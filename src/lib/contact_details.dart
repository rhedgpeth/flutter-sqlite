import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rolodex/presenters/contacts_presenter.dart';
import 'models/contact.dart';

class ContactDialog {
  final teFirstName = TextEditingController();
  final teLastName = TextEditingController();
  final tePhone = TextEditingController();
  final teEmail = TextEditingController();

  late Contact contact;

  final ContactsPresenter contactsPresenter = ContactsPresenter();

  static const TextStyle linkStyle = TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  Widget build(BuildContext context, viewState, bool isEdit, Contact? contact) {
    if (contact != null) {
      this.contact = contact;
      teFirstName.text = this.contact.firstName;
      teLastName.text = this.contact.lastName;
      tePhone.text = this.contact.phone;
      teEmail.text = this.contact.email;
    }

    return AlertDialog(
      title: Text(isEdit ? 'Edit contact' : 'Add new contact'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Enter first name", teFirstName),
            getTextField("Enter last name", teLastName),
            getTextField("Enter phone number", tePhone),
            getTextField("Enter email", teEmail),
            GestureDetector(
              onTap: () async {
                await saveContact(isEdit);
                viewState.displayRecord();
                Navigator.of(context).pop();
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: getAppBorderButton(
                    isEdit ? "Edit" : "Add", const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextField(String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        controller: inputBoxController,
        decoration: InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );
    return loginBtn;
  }

  Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = Container(
      margin: margin,
      padding: const EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
      ),
      child: Text(
        buttonLabel,
        style: const TextStyle(
          color: Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return loginBtn;
  }

  Future saveContact(bool isEdit) async {
    var contact = Contact(teFirstName.text, teLastName.text, tePhone.text, teEmail.text);

    if (isEdit && this.contact.id != null) {
      contact.setId(this.contact.id!);
    }

    return contactsPresenter.save(contact);
  }
}