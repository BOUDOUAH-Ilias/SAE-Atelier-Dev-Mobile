class Auteur {
  final int id;
  final String nom;

  const Auteur({required this.id, required this.nom});
  factory Auteur.fromApi(Map<String, dynamic> json) {
    final auteur = json['auteur'] as Map<String, dynamic>;
    final id = (auteur['id'] as num).toInt();

    final nom = auteur['nom']?.toString();
    final prenom = auteur['prenom']?.toString();
    final pseudo = auteur['pseudo']?.toString();

    final nomComplet = [
      prenom,
      nom,
    ].where((s) => s != null && s.trim().isNotEmpty).join(' ').trim();

    final affichage = nomComplet.isNotEmpty
        ? nomComplet
        : (pseudo != null && pseudo.trim().isNotEmpty)
        ? pseudo
        : 'Auteur #$id';

    return Auteur(id: id, nom: affichage);
  }
}
