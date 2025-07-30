import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuntius/features/chats/cubit/chats_cubit.dart';
import 'package:nuntius/features/home/cubit/home_cubit.dart';

part 'contacts_cubit.freezed.dart';
part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  final HomeCubit _homeCubit;
  final ChatsCubit _chatsCubit;
  ContactsCubit({
    required HomeCubit homeCubit,
    required ChatsCubit chatsCubit,
  })  : _homeCubit = homeCubit,
        _chatsCubit = chatsCubit,
        super(const ContactsState.initial());

  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? companyController;
  TextEditingController? emailController;
  TextEditingController? phoneController;
  GlobalKey<FormState>? formKey;

  void initControllers() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    companyController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    formKey = GlobalKey<FormState>();
    emit(const ContactsState.initControllers());
  }

  void disposeControllers() {
    firstNameController!.dispose();
    lastNameController!.dispose();
    companyController!.dispose();
    emailController!.dispose();
    phoneController!.dispose();
    formKey = null;
    emit(const ContactsState.disposeControllers());
  }

  Future<void> addNewContact() async {
    emit(const ContactsState.addContactLoading());
    try {
      Contact contact = Contact(
          displayName:
              "${firstNameController!.text} ${lastNameController!.text}",
          phones: [Phone(phoneController!.text)],
          organizations: [Organization(company: companyController!.text)],
          emails: [Email(emailController!.text)]);
      await FlutterContacts.insertContact(contact);

      await _homeCubit.getContacts(isAddContact: true);
      await _chatsCubit.getChats();
      firstNameController!.clear();
      lastNameController!.clear();
      companyController!.clear();
      emailController!.clear();
      phoneController!.clear();
      emit(const ContactsState.addContact());
    } catch (error) {
      emit(const ContactsState.addContactError(
          "we faces some troubles to add that contact , please try again later."));
    }
  }
}
