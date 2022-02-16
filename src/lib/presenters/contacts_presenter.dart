import 'dart:async';
import 'package:rolodex/data/database_helper.dart';
import 'package:rolodex/models/contact.dart';
import 'package:rolodex/views/base_view.dart';

class ContactsPresenter {
  late final BaseView _view;

  ContactsPresenter();
  ContactsPresenter.withView(this._view);

  Future<List<Contact>> getAll() async {
    List<Map> list = await DatabaseHelper.internal().query("contacts");
    List<Contact> contacts = [];

    for (int i = 0; i < list.length; i++) {
      contacts.add(Contact.map(list[i]));
    }

    return contacts;
  }

  save(Contact contact) async {
    if (contact.id != null) {
      return DatabaseHelper.internal().update("contacts", contact);
    }
    return DatabaseHelper.internal().insert("contacts", contact);
  }

  delete(Contact contact) async {
    print(contact.id);
    await DatabaseHelper.internal().delete("contacts", contact);
    updateScreen();
  }

  updateScreen() {
    _view.screenUpdate();
  }
}