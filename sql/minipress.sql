-- Adminer 5.4.2 MariaDB dump — minipress mock data
-- Généré le 2026-06-12

SET NAMES utf8mb4;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

-- --------------------------------------------------------
-- TABLE: user
-- Mots de passe :
--   alice@minipress.fr   → Admin2026!
--   bob@minipress.fr     → DevPro99!
--   maxence@gmail.com    → Admin2026!
--   hugo@mail.com        → HugoLeBg
--   clara@minipress.fr   → Clara2026
--   thomas@minipress.fr  → Thomas!web
--   leila@minipress.fr   → Soleil75!
--   vincent@minipress.fr → Montagne42
--   anon@minipress.fr    → password123
-- --------------------------------------------------------

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

INSERT INTO `user` (`id`, `email`, `mot_de_passe`, `is_admin`) VALUES
(1,   'alice@minipress.fr',   '$2y$12$3pOznk00lzTOryFfJP2sLenDnZkowNGSvcamDXH4JPxm7u.l/YSbK', 1),
(2,   'bob@minipress.fr',     '$2y$12$rg/q0.UR9QPv26GXoH1m2.tIQiA8Bi5FPOwO/LpFBAlmKZplkynd2', 0),
(100, 'maxence@gmail.com',    '$2y$12$3pOznk00lzTOryFfJP2sLenDnZkowNGSvcamDXH4JPxm7u.l/YSbK', 1),
(101, 'hugo@mail.com',        '$2y$12$VyR31OrN1LR9DAXWCio8PuXvtaplLv7MrAYPZHLs10EYyv/vm20mW', 0),
(102, 'clara@minipress.fr',   '$2y$12$YIIFcEqPJaJOsHiny6ojw.MdkAb2/qV/Y7CDKio1hMKX.2C1WedPC', 0),
(103, 'thomas@minipress.fr',  '$2y$12$HJP5nhxVt4.At.jSIgb7C.6Kkr5iXiMV5LLOopW11x/9La1vHwDuK', 0),
(104, 'leila@minipress.fr',   '$2y$12$/lZIwjds3ryFMqdB5tNep.GZYLRcT9LpdvqwhY/HGR3Pf29YHRx2W', 0),
(105, 'vincent@minipress.fr', '$2y$12$hhMxnV8VQgazL2LHlYGgS.6RgQb0l4vBNf2TdR3DmpuEWjUN1vu32', 0),
(106, 'anon@minipress.fr',    '$2y$12$yeMZAHEWnty5f9oMjAuP3OTASbc3CWM.aMChOnvYg3.e8gW/loHNu',  0);

-- --------------------------------------------------------
-- TABLE: categorie
-- --------------------------------------------------------

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE `categorie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

INSERT INTO `categorie` (`id`, `nom`) VALUES
(1, 'Technologie'),
(2, 'Science'),
(3, 'Culture'),
(4, 'Société'),
(5, 'Environnement'),
(6, 'Économie'),
(7, 'Santé');

-- --------------------------------------------------------
-- TABLE: article
-- --------------------------------------------------------

DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) NOT NULL,
  `resume` text DEFAULT NULL,
  `contenu` text NOT NULL,
  `date_creation` datetime NOT NULL DEFAULT current_timestamp(),
  `publie` tinyint(1) NOT NULL DEFAULT 0,
  `image_url` varchar(500) DEFAULT NULL,
  `id_categorie` int(11) NOT NULL,
  `id_auteur` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_categorie` (`id_categorie`),
  KEY `id_auteur` (`id_auteur`),
  CONSTRAINT `article_ibfk_1` FOREIGN KEY (`id_categorie`) REFERENCES `categorie` (`id`),
  CONSTRAINT `article_ibfk_2` FOREIGN KEY (`id_auteur`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

INSERT INTO `article` (`id`, `titre`, `resume`, `contenu`, `date_creation`, `publie`, `image_url`, `id_categorie`, `id_auteur`) VALUES

-- === TECHNOLOGIE ===
(1, 'Intelligence artificielle générative : où en sommes-nous en 2026 ?',
'Les modèles de langage ont envahi nos outils du quotidien. Tour d\'horizon des avancées récentes, des usages professionnels aux dérives potentielles.',
'## Un tournant technologique sans précédent\n\nDepuis l\'émergence des grands modèles de langage en 2022, le rythme d\'adoption dans les entreprises françaises n\'a cessé de s\'accélérer. En 2026, il est rare de trouver un poste de développeur, de rédacteur ou d\'analyste qui ne fasse pas appel quotidiennement à un assistant IA.\n\n## Les usages professionnels dominants\n\nDans le secteur du développement logiciel, des outils comme GitHub Copilot ou Cursor ont transformé la façon d\'écrire du code. Les développeurs délèguent désormais la génération de tests unitaires, la documentation et certaines refactorisations. Côté marketing, la génération automatique de contenus SEO a fait exploser la production éditoriale, au risque de saturer le web de textes génériques.\n\n## Les limites qui demeurent\n\nMalgré ces progrès, les hallucinations restent un problème structurel. Les modèles confabulent des sources, inventent des faits et peinent sur les raisonnements mathématiques complexes. La question de la fiabilité est au cœur des débats dans les secteurs médicaux et juridiques, où l\'IA ne peut être utilisée sans supervision humaine stricte.\n\n## Perspectives réglementaires\n\nL\'AI Act européen, entré en vigueur progressivement depuis 2024, impose désormais aux systèmes à haut risque des obligations de transparence et d\'audit. Les PME françaises peinent encore à se mettre en conformité, faute de ressources juridiques adaptées.',
'2026-01-08 09:15:00', 1, NULL, 1, 1),

(2, 'Docker en production : bonnes pratiques pour 2026',
'Conteneuriser une application c\'est simple. La faire tourner de façon fiable en production, c\'est une autre histoire. Voici les pratiques qui font la différence.',
'## Pourquoi Docker reste incontournable\n\nMalgré la montée de Kubernetes et des solutions serverless, Docker reste la brique de base de la conteneurisation pour une grande majorité de projets. Sa simplicité de prise en main et son écosystème mature en font un choix solide, y compris pour de petites équipes sans ops dédiés.\n\n## Images légères et sécurisées\n\nLa première erreur en production est d\'utiliser des images de base trop lourdes. Préférer des images `alpine` ou `distroless` réduit la surface d\'attaque et accélère les déploiements. Penser aussi à utiliser le multi-stage build pour ne pas embarquer les outils de compilation dans l\'image finale.\n\n```dockerfile\nFROM node:20-alpine AS builder\nWORKDIR /app\nCOPY package*.json ./\nRUN npm ci --only=production\n\nFROM node:20-alpine\nWORKDIR /app\nCOPY --from=builder /app/node_modules ./node_modules\nCOPY . .\nCMD [\"node\", \"server.js\"]\n```\n\n## Gestion des secrets\n\nJamais de secrets dans les variables d\'environnement en clair dans un `docker-compose.yml` commité. Utiliser Docker Secrets, un coffre-fort comme Vault, ou à minima des fichiers `.env` exclus du dépôt.\n\n## Health checks et restart policies\n\nDéfinir des `HEALTHCHECK` dans vos Dockerfiles et configurer `restart: unless-stopped` (ou `always` en production) garantit une résilience minimale sans orchestrateur. Coupler avec un outil de monitoring comme Uptime Kuma pour être alerté rapidement.',
'2026-01-22 11:00:00', 1, NULL, 1, 2),

(3, 'Next.js 15 : ce qui change vraiment',
'La quinzième version de Next.js apporte des changements profonds dans la gestion du cache et des Server Actions. Décryptage pour les développeurs en production.',
'## App Router : la maturité enfin atteinte\n\nAprès deux ans de transition douloureuse depuis le Pages Router, l\'App Router de Next.js a atteint une maturité satisfaisante avec la version 15. Les Server Components sont désormais bien documentés et les edge cases connus, ce qui permet de migrer sans trop de surprises.\n\n## Le cache repensé de fond en comble\n\nLa grande nouveauté de Next.js 15 est la refonte du système de cache. Fini le cache agressif par défaut qui piégeait les développeurs : les `fetch` ne sont plus mis en cache automatiquement. Il faut désormais opter explicitement avec `{ cache: \'force-cache\' }` ou configurer une revalidation. Un changement de philosophie bienvenu.\n\n## Server Actions stabilisées\n\nLes Server Actions, introduites en expérimental, sont maintenant stables et constituent le pattern recommandé pour les mutations de données. Elles simplifient considérablement la gestion des formulaires sans avoir besoin d\'une API REST dédiée pour chaque opération.\n\n## Turbopack en production\n\nTurbopack, le bundler en Rust qui remplace Webpack, est désormais utilisable en production. Les gains de performance au build sont significatifs sur les projets de taille moyenne, avec des temps de compilation divisés par 3 à 5 selon les configurations.',
'2026-02-10 14:30:00', 1, NULL, 1, 101),

(4, 'Supabase vs Firebase en 2026 : quel backend choisir ?',
'Deux ans après l\'explosion de Supabase, la bataille des BaaS open source vs propriétaire mérite une réévaluation honnête.',
'## Le contexte a changé\n\nEn 2024, Supabase était encore perçu comme le challenger audacieux face au géant Firebase. En 2026, les deux plateformes ont évolué et la question n\'est plus aussi tranchée. Voici une comparaison basée sur des usages réels.\n\n## Supabase : les points forts\n\nLa base de données PostgreSQL est l\'atout majeur de Supabase. Elle offre toute la puissance du SQL et des extensions comme pgvector pour les usages IA. L\'authentification est robuste, la gestion des Row Level Security (RLS) est puissante même si sa courbe d\'apprentissage reste raide. Le fait que tout soit open source et auto-hébergeable rassure les équipes soucieuses du vendor lock-in.\n\n## Firebase : toujours pertinent\n\nFirebase brille sur les applications temps réel grâce à Firestore et sur les projets qui veulent aller vite avec le moins de configuration possible. L\'intégration avec l\'écosystème Google (Analytics, Crashlytics, Push Notifications) est imbattable pour les applications mobiles.\n\n## Notre verdict\n\nPour un projet web full-stack avec des données relationnelles : Supabase. Pour une app mobile avec beaucoup de temps réel et pas d\'équipe backend : Firebase. Dans les deux cas, éviter de coupler trop fort son code au SDK de la plateforme pour garder une porte de sortie.',
'2026-02-28 10:00:00', 1, NULL, 1, 101),

(5, 'Sécurité web : les failles OWASP Top 10 à ne pas ignorer',
'XSS, injections SQL, CSRF... Ces vulnérabilités existent depuis vingt ans et continuent de faire des ravages. Un rappel pratique des protections essentielles.',
'## Pourquoi ces failles persistent\n\nMalgré une sensibilisation croissante, les vulnérabilités listées par l\'OWASP Top 10 représentent encore la majorité des incidents de sécurité signalés en 2026. La raison principale : la pression du temps de développement et le turnover des équipes font que les bonnes pratiques ne sont pas toujours transmises.\n\n## Injection SQL : basique mais toujours présente\n\nUtiliser un ORM ne suffit pas si on exécute des requêtes brutes avec des données non sanitisées. Toujours utiliser des requêtes préparées. Avec PDO en PHP :\n\n```php\n$stmt = $pdo->prepare("SELECT * FROM user WHERE email = :email");\n$stmt->execute([\'email\' => $userInput]);\n```\n\n## XSS : échapper les sorties, pas les entrées\n\nL\'erreur classique est de filtrer à l\'entrée mais d\'oublier d\'échapper à la sortie. Dans Twig, le moteur de templates échappe automatiquement les variables. Attention cependant au filtre `|raw` qui désactive cette protection.\n\n## CSRF : les tokens comme bouclier\n\nPour toute action qui modifie l\'état côté serveur (formulaire POST, suppression), implémenter un token CSRF unique par session. En PHP/Slim, des middlewares dédiés existent pour automatiser cette protection.\n\n## Conclusion\n\nLa sécurité n\'est pas une fonctionnalité à ajouter en fin de projet. Elle doit être intégrée dès la conception, avec des revues de code systématiques sur les points critiques.',
'2026-03-15 09:00:00', 1, NULL, 1, 2),

-- Article non publié (brouillon)
(6, 'TypeScript 6 : les nouvelles fonctionnalités à surveiller',
'Un aperçu des propositions en cours pour la prochaine version majeure de TypeScript, entre inférence améliorée et nouveaux utilitaires de types.',
'## Brouillon en cours\n\nCet article est en cours de rédaction. Revenez plus tard !',
'2026-06-01 08:00:00', 0, NULL, 1, 103),

-- === SCIENCE ===
(7, 'La fusion nucléaire : enfin une énergie commercialement viable ?',
'Après des décennies de promesses, plusieurs startups annoncent des réacteurs à fusion commerciaux pour la fin de la décennie. Analyse des avancées réelles.',
'## Le rêve de la fusion\n\nL\'équation est simple en apparence : reproduire la réaction qui alimente le Soleil pour produire une énergie quasi-illimitée, sans déchets radioactifs durables et sans risque d\'emballement. En pratique, la fusion contrôlée s\'est avérée être l\'un des défis scientifiques les plus ardus de l\'histoire humaine.\n\n## Les percées de ces dernières années\n\nEn décembre 2022, le National Ignition Facility américain a franchi le seuil de l\'ignition : l\'énergie produite a dépassé l\'énergie laser injectée. En 2025, plusieurs startups comme Commonwealth Fusion Systems ont annoncé des aimants supraconducteurs à haute température capables de confiner le plasma de façon bien plus compacte qu\'ITER.\n\n## ITER : toujours en construction\n\nLe projet ITER en Provence, chantier titanesque impliquant 35 pays, progresse mais accuse des retards. Son rôle reste crucial : démontrer la faisabilité scientifique à grande échelle. La première phase de plasma est désormais attendue pour 2028.\n\n## Un horizon commercial réaliste ?\n\nLes estimations les plus optimistes tablent sur des premiers réacteurs commerciaux autour de 2035-2040. Réaliste pour les startups les mieux financées, le chemin reste parsemé d\'inconnues ingénieristes. Mais pour la première fois, la question n\'est plus "si" mais "quand".',
'2026-01-18 11:00:00', 1, NULL, 2, 1),

(8, 'CRISPR-Cas9 : bilan de dix ans d\'édition génomique',
'La technologie d\'édition du génome révolutionne la médecine et l\'agriculture. Dix ans après son adoption massive, quel est le bilan ?',
'## Une révolution silencieuse\n\nDepuis 2015, CRISPR-Cas9 est passé des laboratoires de recherche aux essais cliniques à une vitesse inédite dans l\'histoire biomédicale. En 2026, plusieurs thérapies géniques basées sur cette technologie ont obtenu des autorisations de mise sur le marché, notamment pour la drépanocytose et certaines formes de leucémie.\n\n## Les succès thérapeutiques\n\nLa première thérapie CRISPR approuvée, Casgevy, a montré des résultats remarquables : des patients atteints de drépanocytose, une maladie génétique douloureuse et handicapante, ont connu des rémissions durables après un traitement unique. Le prix reste prohibitif (plusieurs millions d\'euros), mais il ouvre la voie à d\'autres traitements.\n\n## Les enjeux éthiques non résolus\n\nLa modification du génome germinal — c\'est-à-dire héréditaire — reste interdite dans la plupart des pays après le scandale He Jiankui en 2018. Mais la pression des familles touchées par des maladies génétiques graves et les avancées techniques relancent régulièrement le débat. Où tracer la ligne entre thérapie et amélioration ?\n\n## Agriculture et biodiversité\n\nDu côté végétal, des variétés résistantes à la sécheresse ou aux maladies ont été développées via CRISPR. La réglementation européenne, longtemps bloquante, a évolué en 2024 pour distinguer l\'édition génomique précise des OGM traditionnels.',
'2026-02-12 13:00:00', 1, NULL, 2, 104),

(9, 'Exoplanètes habitables : le James Webb change la donne',
'Le télescope spatial James Webb analyse les atmosphères de planètes hors de notre système solaire. Les premières données soulèvent des questions fascinantes.',
'## Ce que le JWST peut faire qu\'Hubble ne pouvait pas\n\nLancé fin 2021 et opérationnel depuis 2022, le James Webb Space Telescope a transformé notre capacité à caractériser les atmosphères d\'exoplanètes. Sa sensibilité dans l\'infrarouge permet de détecter des signatures moléculaires — eau, méthane, CO2 — que le spectre visible d\'Hubble ne pouvait pas révéler.\n\n## TRAPPIST-1 sous la loupe\n\nLe système TRAPPIST-1, à 40 années-lumière, concentre l\'attention des astronomes. Ses sept planètes de taille terrestre, dont trois dans la zone habitable, constituent un laboratoire naturel exceptionnel. Les premières analyses atmosphériques de TRAPPIST-1b et 1c montrent l\'absence d\'atmosphère épaisse, décevant sur ces deux-là mais laissant l\'espoir intact pour les planètes plus intérieures.\n\n## La détection de DME : vraiment significatif ?\n\nEn 2025, une équipe a annoncé la détection de diméthylsulfure (DMS) dans l\'atmosphère de K2-18b, une planète hycéenne potentielle. Sur Terre, ce gaz est produit exclusivement par des organismes vivants. L\'annonce a fait sensation, mais la communauté scientifique reste prudente : le signal est faible et d\'autres explications chimiques abiotiques ne sont pas exclues.\n\n## La prochaine décennie\n\nAvec le futur Extremely Large Telescope (ELT) de l\'ESO, attendu pour 2028, et de futurs télescopes spatiaux, la caractérisation atmosphérique va s\'affiner considérablement. La réponse à la question de la vie extraterrestre intelligente pourrait être encore loin, mais celle de la vie microbienne se rapproche.',
'2026-03-05 10:30:00', 1, NULL, 2, 2),

(10, 'Microbiote intestinal : ce que la science sait vraiment',
'Entre les affirmations marketing et la recherche sérieuse, il est difficile de s\'y retrouver. Voici ce que les études robustes disent sur le microbiote.',
'## Un organe méconnu\n\nLe microbiote intestinal — l\'ensemble des micro-organismes vivant dans notre système digestif — est composé de plusieurs milliers de milliards de bactéries, virus et champignons. Son influence sur la santé humaine est réelle et documentée, même si la science est encore loin d\'avoir tout compris.\n\n## Ce qui est établi\n\nLa diversité du microbiote est corrélée à la bonne santé générale. Une alimentation riche en fibres variées favorise cette diversité. Les antibiotiques, nécessaires lors d\'infections bactériennes, perturbent significativement le microbiote et cette perturbation peut durer plusieurs mois. Le lien entre microbiote et obésité, maladies inflammatoires et même certains troubles de l\'humeur est documenté, sans que les mécanismes causaux soient toujours élucidés.\n\n## Ce qui est surestimé\n\nLes probiotiques vendus en pharmacie ont des effets limités chez les personnes en bonne santé. Les allégations marketing de nombreux produits "bons pour le microbiote" sont bien en avance sur les preuves scientifiques. Les compléments alimentaires génériques ne remplaceront jamais une alimentation diversifiée.\n\n## Ce qui est prometteur\n\nLa transplantation fécale (FMT) a montré des résultats remarquables contre les infections à Clostridioides difficile. Des recherches sont en cours pour explorer son potentiel dans le traitement de maladies inflammatoires de l\'intestin et de certains cancers.',
'2026-04-01 09:00:00', 1, NULL, 7, 104),

-- === CULTURE ===
(11, 'Cinéma français 2025 : l\'année de la rupture générationnelle',
'Une nouvelle vague de réalisatrices et réalisateurs trentenaires s\'impose à Cannes et au box-office. Portrait d\'une génération qui réinvente le cinéma d\'auteur.',
'## La génération post-pandémie\n\nLa pandémie de 2020-2021 a bouleversé les parcours des jeunes cinéastes. Beaucoup ont tourné leur premier long-métrage avec des budgets réduits, des équipes squelettiques et une liberté formelle totale. Ce contexte de contrainte a paradoxalement libéré des voix singulières.\n\n## Les films marquants de 2025\n\nSans citer de titres fictifs, la tendance dominante de la saison 2025 est celle du cinéma de genre qui assume pleinement ses références — horreur sociale, thriller paranoïaque, science-fiction intimiste — tout en ancrant ses histoires dans des réalités françaises très contemporaines : précarité, racisme systémique, crise du logement.\n\n## Cannes comme révélateur\n\nLa sélection officielle de Cannes 2025 a confirmé cette tendance avec une Palme d\'Or remise à une œuvre dérangeante et formellement ambitieuse, saluée par la critique internationale comme un renouveau du cinéma d\'auteur hexagonal.\n\n## La question du financement\n\nLe CNC joue un rôle crucial dans ce renouveau. Les aides sélectives ont été réorientées vers les premiers et deuxièmes films depuis 2023, permettant à des projets risqués d\'aboutir. La plateforme de streaming Canal+, en crise par ailleurs, continue néanmoins de financer des films ambitieux via des accords de préachat.',
'2026-01-30 14:00:00', 1, NULL, 3, 103),

(12, 'Jeu vidéo indépendant : la France comme nouvelle puissance créative',
'Des studios rennais aux collectifs lyonnais, le jeu vidéo indépendant français s\'impose sur la scène mondiale. Rencontre avec ceux qui font cette industrie.',
'## Un terreau fertile\n\nLa France est devenue l\'un des pays européens avec la plus forte densité de studios de jeu vidéo indépendants. Cette effervescence est portée par plusieurs facteurs : un système de formation solide (écoles spécialisées, IUT informatique, formations en alternance), un dispositif de crédit d\'impôt jeu vidéo avantageux, et une communauté active de jams et de festivals.\n\n## Des succès internationaux discrets\n\nSeveral French indie studios have achieved international recognition. Des studios comme Chasing Carrots ou des collectifs issus de game jams ont connu des succès notables sur Steam et les plateformes mobiles. Leur point commun : des directions artistiques marquées et des mécaniques de jeu originales plutôt qu\'une course aux graphismes AAA.\n\n## Les défis du secteur\n\nLe financement reste le nerf de la guerre. Les délais entre la conception et la sortie s\'allongent, mettant les petites équipes sous pression financière. Le marché Steam est saturé, rendant la visibilité plus difficile que jamais. Beaucoup de studios ne survivent pas à leur deuxième jeu.\n\n## La communauté comme ressource\n\nFace à ces défis, la mutualisation est devenue un réflexe. Des espaces de coworking dédiés aux créatifs du jeu vidéo, des associations comme l\'AFJV, et des événements comme la GameCamp permettent de partager ressources, outils et retours d\'expérience.',
'2026-02-20 11:30:00', 1, NULL, 3, 103),

(13, 'La bande dessinée franco-belge à l\'ère numérique',
'Webtoons, lecture sur mobile, intelligence artificielle... La BD traditionnelle doit se réinventer. Entre résistance et adaptation, un secteur en pleine mutation.',
'## Une institution bousculée\n\nLa bande dessinée franco-belge, pilier de la culture populaire depuis Hergé et Goscinny, traverse une crise profonde. Les ventes d\'albums traditionnels chutent depuis 2019, et la pandémie a accéléré la bascule vers le numérique.\n\n## Le déferlement des webtoons\n\nOrigine coréenne, le format webtoon — lecture verticale sur mobile, cases larges, souvent en couleur — a conquis une audience massive chez les 15-25 ans. Des plateformes comme Webtoon et Tapas proposent des milliers de séries, souvent gratuites avec un modèle freemium. Les auteurs français s\'y aventurent de plus en plus, adaptant leur storytelling au format scroll.\n\n## L\'IA : menace ou outil ?\n\nL\'intelligence artificielle générative d\'images (Midjourney, Stable Diffusion) bouleverse le secteur. Certains auteurs l\'utilisent pour les décors ou les recherches visuelles, d\'autres y voient une menace directe pour leur métier. La question des droits d\'auteur sur les données d\'entraînement reste un contentieux majeur, plusieurs auteurs français ayant rejoint des class actions américaines.\n\n## Les festivals résistent\n\nAngoulême, avec ses 200 000 visiteurs annuels, reste un rendez-vous incontournable qui résiste à la dématérialisation. Le festival a d\'ailleurs pris position fermement contre l\'usage de l\'IA générative dans les œuvres en compétition, alimentant un débat qui est loin d\'être clos.',
'2026-03-18 15:00:00', 1, NULL, 3, 105),

-- === SOCIÉTÉ ===
(14, 'Télétravail en France : bilan cinq ans après la pandémie',
'Que reste-t-il du grand bouleversement organisationnel de 2020 ? Entre retour au bureau imposé et hybridation durable, la réalité est contrastée.',
'## Le reflux attendu\n\nAprès l\'euphorie (ou le trauma, selon les cas) du télétravail généralisé de 2020, le retour partiel au bureau était prévisible. Ce qui l\'était moins, c\'est la brutalité avec laquelle certains grands groupes ont imposé ce retour en 2023-2024, au risque de perdre des talents qui avaient réorganisé leur vie autour du travail à distance.\n\n## Ce qui a durci\n\nPour les cadres qualifiés, le télétravail deux à trois jours par semaine est devenu la norme négociée. Le refuser entièrement est difficile pour un employeur soucieux d\'attirer des profils expérimentés. À l\'inverse, les postes nécessitant une présence physique — hôtellerie, santé, industrie — n\'ont jamais connu ce débat.\n\n## Les perdants silencieux\n\nLes jeunes en début de carrière sont les principales victimes du télétravail généralisé. L\'apprentissage informel, la transmission des pratiques, le réseau... tout cela passe par la présence physique. Plusieurs études montrent que les jeunes recrutés depuis 2020 ont une progression de carrière plus lente que leurs prédécesseurs.\n\n## L\'espace de travail réinventé\n\nLes entreprises qui ont gardé leurs locaux les ont repensés : moins de bureaux individuels fixes, plus d\'espaces collaboratifs. Le flex office, longtemps mal vécu, s\'est normalisé. Les espaces de coworking en dehors des grandes métropoles bénéficient de cet essor.',
'2026-02-03 10:00:00', 1, NULL, 4, 1),

(15, 'Génération Z et rapport au travail : mythes et réalités',
'Paresseux, exigeants, zappeurs... Les stéréotypes sur la génération Z dans le monde professionnel méritent d\'être nuancés. Les chiffres racontent une autre histoire.',
'## Le procès facile d\'une génération\n\nChaque génération a été accusée par la précédente de manquer de sérieux ou de sens de l\'effort. La génération Z — née entre 1997 et 2012 — n\'échappe pas à la règle. Pourtant, à y regarder de plus près, ses comportements au travail sont souvent plus rationnels qu\'il n\'y paraît.\n\n## Ce que disent les études\n\nLes enquêtes auprès des employeurs montrent que les jeunes actifs de la génération Z sont particulièrement attentifs à l\'alignement entre leurs valeurs et celles de l\'entreprise, à la transparence managériale et au sens de leur contribution. Ce n\'est pas de la paresse : c\'est une exigence différente de celle des baby-boomers.\n\n## La question de la loyauté\n\nLe taux de rotation plus élevé chez les moins de 30 ans est réel, mais s\'explique en partie par un marché du travail qui les y a encouragés. Quand on voit que les augmentations de salaire les plus significatives s\'obtiennent en changeant d\'employeur, la "valse des entreprises" est économiquement rationnelle.\n\n## Ce que les employeurs doivent changer\n\nRetenir les talents de la génération Z demande plus que la table de ping-pong et les after-works. Feedback fréquent, perspectives d\'évolution claires, équilibre vie pro/perso réel, et une culture qui dit ce qu\'elle fait : voilà les vrais leviers selon les DRH qui y arrivent.',
'2026-03-28 09:30:00', 1, NULL, 4, 105),

-- Article non publié (brouillon)
(16, 'Logement étudiant en France : une crise qui s\'aggrave',
'Loyers en hausse, résidences CROUS saturées, colocations indécentes... La galère du logement étudiant n\'est pas prête de se résoudre.',
'## En cours de rédaction\n\nCet article est un brouillon. Il sera publié prochainement.',
'2026-05-10 16:00:00', 0, NULL, 4, 102),

-- === ENVIRONNEMENT ===
(17, 'Rénovation énergétique en France : où en est-on vraiment ?',
'MaPrimeRénov\', CEE, éco-PTZ... Les aides existent mais le rythme des travaux est encore loin des objectifs climatiques. Analyse des blocages.',
'## Un impératif climatique et économique\n\nLe parc immobilier français est l\'un des plus énergivores d\'Europe. Chauffer des passoires thermiques coûte cher aux ménages et émet massivement du CO2. La rénovation énergétique est donc à la fois une urgence climatique et un enjeu de pouvoir d\'achat — une combinaison rare qui devrait faciliter le consensus politique.\n\n## Les aides : généreuses sur le papier\n\nMaPrimeRénov\' peut financer jusqu\'à 90 % des travaux pour les ménages très modestes. Les Certificats d\'Économies d\'Énergie (CEE) complètent ce dispositif. Sur le papier, rénover une maison passoire est devenu abordable. Dans les faits, la complexité administrative, les délais et la pénurie d\'artisans RGE (Reconnus Garants de l\'Environnement) freinent massivement le passage à l\'acte.\n\n## Le paradoxe des propriétaires bailleurs\n\nDepuis 2025, les logements classés G au DPE sont théoriquement interdits à la location. La réalité est plus complexe : de nombreux propriétaires préfèrent vendre ou contourner la réglementation plutôt que d\'investir dans des travaux. Dans certaines zones tendues, les locataires acceptent des logements illégaux faute de mieux.\n\n## Les signaux positifs\n\nLa filière des artisans et entreprises RGE se développe. Les formations se multiplient. Quelques communes ont mis en place des guichets uniques qui simplifient vraiment le parcours du propriétaire. Des modèles d\'avance sur subvention émergent pour ne pas bloquer sur l\'apport initial.',
'2026-01-25 10:00:00', 1, NULL, 5, 104),

(18, 'Agriculture régénératrice : une alternative au modèle intensif ?',
'Couverts végétaux, agroforesterie, zéro labour... Des agriculteurs français expérimentent des pratiques qui promettent de réconcilier production et écosystèmes.',
'## Un modèle à bout de souffle\n\nL\'agriculture intensive française a permis d\'atteindre une productivité record mais au prix d\'une érosion des sols, d\'une perte de biodiversité et d\'une dépendance aux intrants chimiques qui fragilisent les exploitations sur le long terme. Face à ces limites, un mouvement de fond émerge : l\'agriculture régénératrice.\n\n## Les principes fondamentaux\n\nL\'agriculture régénératrice n\'est pas un label certifié mais un ensemble de pratiques : couverture permanente des sols pour limiter l\'érosion, introduction de légumineuses dans les rotations pour fixer l\'azote, réduction ou abandon du labour, intégration d\'arbres (agroforesterie) pour créer des microclimats et abriter la faune auxiliaire.\n\n## Des pionniers dans les Hauts-de-France\n\nCertaines exploitations céréalières du nord de la France ont abandonné le labour il y a plus de dix ans. Leurs résultats sont nuancés mais encourageants : baisse des charges en carburant et en intrants, amélioration de la structure du sol sur le long terme, mais rendements parfois inférieurs les premières années de transition.\n\n## Les obstacles à la généralisation\n\nLa PAC (Politique Agricole Commune) reste largement calibrée pour récompenser la surface plutôt que les pratiques. Changer de modèle demande un investissement en temps, en formation et en acceptation du risque que beaucoup d\'agriculteurs surendettés ne peuvent pas se permettre.',
'2026-03-02 11:00:00', 1, NULL, 5, 104),

-- === ÉCONOMIE ===
(19, 'Freelance en France : réalités et illusions de l\'indépendance',
'Le nombre de micro-entrepreneurs ne cesse de croître. Mais entre le mythe de la liberté totale et la réalité des fins de mois difficiles, quel est le bilan honnête ?',
'## L\'explosion du travail indépendant\n\nLa France comptait plus de deux millions de micro-entrepreneurs actifs en 2025. Ce chiffre masque des réalités très différentes : du développeur web qui facture 600 euros par jour au livreur à vélo sous statut auto-entrepreneur, les situations n\'ont rien à voir.\n\n## Les avantages réels\n\nLa liberté de choisir ses missions, ses horaires et ses clients est réelle pour ceux qui ont développé une expertise suffisante et un réseau solide. Le régime micro-entrepreneur simplifie énormément les obligations comptables. Pour les profils qualifiés dans l\'IT, la communication ou le conseil, les revenus peuvent largement dépasser ceux d\'un salarié équivalent.\n\n## Les angles morts\n\nPas de cotisation chômage, donc pas d\'allocation en cas de creux d\'activité. La retraite se constitue lentement avec le régime micro. La protection sociale est moins favorable qu\'en régime général. Et surtout : trouver des clients, facturer, relancer les impayés, gérer sa comptabilité... tout ce temps non facturé réduit considérablement le taux horaire réel.\n\n## Conseils pour démarrer sereinement\n\nAvant de quitter un CDI, constituer un matelas de 6 mois de charges fixes. Construire son réseau et tester sa capacité à trouver des missions en parallèle de son emploi. Rejoindre des communautés (Malt, Comet, groupes Slack sectoriels) pour rompre l\'isolement et accéder à des opportunités.',
'2026-02-08 09:00:00', 1, NULL, 6, 1),

(20, 'Immobilier à Nancy en 2026 : le marché sous tension',
'Entre la hausse des taux et la pression étudiante, le marché immobilier nancéien offre des opportunités mais aussi de vrais pièges pour les primo-accédants.',
'## Un marché qui se rééquilibre\n\nAprès la flambée des prix de 2020-2022, le marché immobilier nancéien s\'est partiellement corrigé. Les prix au mètre carré dans les quartiers prisés comme Poincaré-Foch-Cathédrale ont reculé de 5 à 8 % en 2023-2024, offrant des opportunités à des acheteurs qui avaient été exclus du marché.\n\n## La pression étudiante\n\nNancy accueille plus de 50 000 étudiants. La demande locative est structurellement forte dans les quartiers proches de l\'université et de l\'IUT, notamment autour de Vandœuvre et Brabois. Les studios et T2 dans ces secteurs restent très demandés et les rendements locatifs y sont généralement corrects.\n\n## Les pièges à éviter\n\nL\'hypercentre haussmannien est attractif mais attention aux immeubles anciens mal isolés. Les obligations DPE rendent difficile la location de biens classés F ou G sans travaux coûteux. La Couronne Nord (Essey, Laxou) offre de meilleures surfaces pour le même prix mais avec moins de liquidité à la revente.\n\n## Financer son bien en 2026\n\nLes taux sont stabilisés autour de 3,2 % sur 20 ans. Le PTZ a été réélargi aux zones B2 comme Nancy en 2025, ce qui soutient les primo-accédants. Les banques restent exigeantes sur le taux d\'endettement et l\'apport personnel minimal de 10 à 15 %.',
'2026-04-15 14:00:00', 1, NULL, 6, 2),

-- === SANTÉ ===
(21, 'Sommeil et performances : ce que dit la science',
'Dormir 6 heures pour "optimiser" sa journée est contre-productif. Les recherches récentes sur les effets de la privation de sommeil sont sans appel.',
'## La dette de sommeil n\'existe pas vraiment\n\nContrairement à une croyance répandue, on ne "rattrape" pas durablement un sommeil insuffisant avec une longue nuit le week-end. Les effets cognitifs d\'une semaine de nuits courtes persistent même après récupération. Le cerveau n\'est pas une batterie qu\'on recharge simplement.\n\n## Combien d\'heures faut-il vraiment ?\n\nLes recommandations des organismes de santé convergent : 7 à 9 heures pour les adultes. Les "petits dormeurs" qui affirment fonctionner parfaitement avec 5 heures sont statistiquement rarissimes — il s\'agit d\'une mutation génétique touchant moins d\'1 % de la population. Pour les autres, la privation chronique dégrade insidieusement cognition, humeur et immunité.\n\n## Sommeil et composition corporelle\n\nPour ceux qui s\'entraînent, le lien est direct : c\'est pendant le sommeil profond que la GH (hormone de croissance) est sécrétée en masse, conditionnant la synthèse protéique et la récupération musculaire. Dormir moins de 7 heures réduit significativement le ratio masse maigre/masse grasse perdu lors d\'un régime hypocalorique.\n\n## Améliorer la qualité du sommeil\n\nTemperature fraîche (18-19 °C), obscurité totale, suppression des écrans 30 minutes avant le coucher, et surtout horaires réguliers : ce sont les interventions dont l\'efficacité est la mieux documentée. Les compléments comme la mélatonine sont utiles pour les décalages horaires mais peu efficaces au quotidien.',
'2026-03-10 08:00:00', 1, NULL, 7, 101),

(22, 'Sport et santé mentale : au-delà du slogan',
'L\'activité physique "ça aide pour le moral", tout le monde le dit. Mais quels mécanismes biologiques sont en jeu, et quels types d\'exercice sont réellement efficaces ?',
'## Plus qu\'une question de volonté\n\nDire à quelqu\'un en dépression de "faire du sport" peut sembler simpliste, voire blessant. Pourtant les preuves scientifiques de l\'effet antidépresseur de l\'activité physique régulière sont aujourd\'hui solides et reposent sur des mécanismes biologiques identifiés.\n\n## Les mécanismes en jeu\n\nL\'exercice physique stimule la neurogenèse dans l\'hippocampe, une région cérébrale impliquée dans la mémoire et la régulation émotionnelle. Il augmente les niveaux de BDNF (Brain-Derived Neurotrophic Factor), une protéine qui favorise la survie et la croissance des neurones. Il régule l\'axe HPA (hypothalamo-hypophyso-surrénalien) qui gouverne la réponse au stress, réduisant les niveaux de cortisol chroniquement élevés.\n\n## Quelle modalité d\'exercice ?\n\nLes études comparatives montrent que le cardio d\'intensité modérée (jogging, vélo, natation) 3 fois par semaine a des effets antidépresseurs comparables à certains traitements pharmacologiques sur les dépressions légères à modérées. La musculation apporte des bénéfices complémentaires sur l\'estime de soi et l\'anxiété. L\'idéal est probablement une combinaison des deux.\n\n## Les limites à connaître\n\nL\'exercice n\'est pas un substitut au traitement dans les dépressions sévères. L\'incapacité à s\'y mettre est souvent un symptôme de la dépression elle-même, créant un cercle vicieux. Des programmes supervisés avec un accompagnement professionnel sont bien plus efficaces que le conseil seul.',
'2026-04-20 11:00:00', 1, NULL, 7, 102);

-- --------------------------------------------------------
-- 2026-06-12 — minipress mock data
-- --------------------------------------------------------