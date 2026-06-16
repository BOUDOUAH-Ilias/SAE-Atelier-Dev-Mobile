import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auteur.dart';
import '../services/api_client.dart';

final auteurNomProvider = FutureProvider.family<String, int>((
  ref,
  auteurId,
) async {
  try {
    final client = ApiClient();
    final json = await client.getAuteurById(auteurId);
    return Auteur.fromApi(json).nom;
  } catch (_) {
    return 'Auteur #$auteurId';
  }
});
