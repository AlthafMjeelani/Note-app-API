import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:noteapp/core/constants.dart';
import 'package:noteapp/model/api_response.dart';
import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/model/note_post_model.dart';
import 'package:noteapp/model/single_note_model.dart';

class ApiService {
  Future<APIResponse<List<NotesModel>>> getNotes() async {
    try {
      final response = await http.get(
          Uri.parse('${ApiConstants.baseUrl}/notes'),
          headers: ApiConstants.headers);

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        log(response.body);
        final List decodedData = jsonDecode(response.body);
        final List<NotesModel> data =
            decodedData.map((i) => NotesModel.fromJson(i)).toList();
        return APIResponse(
          data: data,
          error: false,
          errormessage: '',
        );
      } else {
        return APIResponse(
            data: [], error: true, errormessage: 'Error Occured');
      }
    } on SocketException {
      return APIResponse(
          data: [], error: true, errormessage: 'Error With Connection');
    } on HttpException {
      return APIResponse(
          data: [], error: true, errormessage: 'Invalid HTTP Request');
    } catch (e) {
      return APIResponse(data: [], errormessage: 'Error Occured');
    }
  }

  Future<APIResponse<SingleNotesModel>> getsingleNotes(String noteId) async {
    try {
      final response = await http.get(
          Uri.parse('${ApiConstants.baseUrl}/notes/$noteId'),
          headers: ApiConstants.headers);

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        log(response.body);
        final decodedData = jsonDecode(response.body);
        final data = SingleNotesModel.fromJson(decodedData);
        return APIResponse(
          data: data,
          error: false,
          errormessage: '',
        );
      } else {
        return APIResponse(error: true, errormessage: 'Error Occured');
      }
    } on SocketException {
      return APIResponse(error: true, errormessage: 'Error With Connection');
    } on HttpException {
      return APIResponse(error: true, errormessage: 'Invalid HTTP Request');
    } catch (e) {
      return APIResponse(errormessage: 'Error Occured');
    }
  }

  Future<APIResponse<PostNoteModel>> postNotes(PostNoteModel note) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/notes'),
        headers: ApiConstants.headers,
        body: jsonEncode(
          note.toJson(),
        ),
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        log(response.body);
        return APIResponse(
          error: false,
          errormessage: '',
        );
      } else {
        return APIResponse(error: true, errormessage: 'Error Occured');
      }
    } on SocketException {
      return APIResponse(error: true, errormessage: 'Error With Connection');
    } on HttpException {
      return APIResponse(error: true, errormessage: 'Invalid HTTP Request');
    } catch (e) {
      return APIResponse(errormessage: 'Error Occured');
    }
  }

  Future<APIResponse<PostNoteModel>> updateNotes(
      String noteId, PostNoteModel note) async {
    try {
      final response = await http.put(
          Uri.parse('${ApiConstants.baseUrl}/notes/$noteId'),
          headers: ApiConstants.headers,
          body: jsonEncode(note.toJson()));

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        log(response.body);
        return APIResponse(
          error: false,
          errormessage: '',
        );
      } else {
        return APIResponse(error: true, errormessage: 'Error Occured');
      }
    } on SocketException {
      return APIResponse(error: true, errormessage: 'Error With Connection');
    } on HttpException {
      return APIResponse(error: true, errormessage: 'Invalid HTTP Request');
    } catch (e) {
      return APIResponse(errormessage: 'Error Occured');
    }
  }

  Future<APIResponse<PostNoteModel>> deleteNotes(String noteId) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConstants.baseUrl}/notes/$noteId'),
        headers: ApiConstants.headers,
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        log(response.body);
        return APIResponse(
          error: false,
          errormessage: '',
        );
      } else {
        return APIResponse(error: true, errormessage: 'Error Occured');
      }
    } on SocketException {
      return APIResponse(error: true, errormessage: 'Error With Connection');
    } on HttpException {
      return APIResponse(error: true, errormessage: 'Invalid HTTP Request');
    } catch (e) {
      return APIResponse(errormessage: 'Error Occured');
    }
  }
}
