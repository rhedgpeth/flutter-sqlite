import 'package:flutter/material.dart';
import 'package:rolodex/presenters/contacts_presenter.dart';
import 'contact_details.dart';
import 'models/contact.dart';

class ContactList extends StatelessWidget {
  late List<Contact> contacts;
  late ContactsPresenter contactsPresenter;

  ContactList(
      this.contacts,
      this.contactsPresenter, {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
                child: Center(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 40.0,
                        child: Text(getInitials(contacts[index]),
                            style: const TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        backgroundColor: const Color(0xFF20283e)
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                contacts[index].firstName + " " + contacts[index].lastName,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                contacts[index].phone,
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.green),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                contacts[index].email,
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Color(0xFF167F67),
                            ),
                            onPressed: () => edit(contacts[index], context),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_forever,
                                color: Color(0xFF167F67)),
                            onPressed: () =>
                                contactsPresenter.delete(contacts[index]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
          );
        });
  }

  displayRecord() {
    contactsPresenter.updateScreen();
  }

  edit(Contact contact, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          ContactDialog().build(context, this, true, contact),
    );
    contactsPresenter.updateScreen();
  }

  String getInitials(Contact contact) {
    String initials = "";
    if (contact.firstName.isNotEmpty) {
      initials = contact.firstName.substring(0, 1) + ".";
    }
    if (contact.lastName.isNotEmpty) {
      initials = initials + contact.lastName.substring(0, 1) + ".";
    }
    return initials;
  }
}