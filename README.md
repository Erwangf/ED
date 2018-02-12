# Projet entrepot de données : United Nations Data

# Avancement
Pour l'instant, nous disposons de deux jeux de données tirés du même site, UN Data.
- Commodity Trades, un assez gros paquet de somme d'échanges par pays, par année et par type de produit
- World Development Indicators, quelques indicateur de développement par pays et année.

Pour l'instant on s'arrête là sur le chargement des données, on verra s'il nous manque des choses lors de la phase d'analyse.

# Mise en route

Pour pouvoir bosser sur ce projet, il faut installer 
- PostgreSQL 10
- StarUML
- Tableau Software

## PostgreSQL
Télécharger l'installateur de PostgreSQL 10 : https://www.enterprisedb.com/downloads/postgres-postgresql-downloads
Notez bien le mot de passe utilisé lors de l'installation ( on vous le demandera ! )
Après l'avoir installé, sous Windows, aller dans Services ( astuce : touche windows, puis taper "Services")

Vérifier qu'un service PostgreSQL existe, et qu'il tourne !

## StarUML
http://staruml.io/download

## Tableau Software
https://www.tableau.com/fr-fr/academic/students#form
Faut leur envoyer votre certificat de scolarité, normalement c'est assez rapide.

## Consulter et requêter la base de données

Vous pouvez utiliser n'importe quel logiciel de base de données comptatible avec PostgreSQL. Par defaut, l'installation de PostgreSQL contient PgAdmin, qui permet de consulter / modifier une base de données.
Le plus souvent, par défaut, l'identifiant d'une base de données est votre nom utilisateur de session, et le mot de passe est celui choisi lors de l'installation. Par defaut PgAdmin cherche à se login avec comme nom d'utilisateur "postgres", d'où certains soucis de connexion.

Solution : changer les paramètres de connexion : clic droit sur la connexion (local) puis properties, panneau connexion, puis changer le champs "username".

## Les données
Télécharger l'archive contenant les données :
https://www.dropbox.com/s/5dbc92gf16f3gln/data_raw.rar?dl=0
L'extraire (avec WinRAR par exemple) dans le répertoire de travail (ED). Normalement, cela doit rajouter un dossier appelé data_raw, dans le répertoire de travail.

## Les fichiers R
Dans le dossier scripts, se trouvent plusieurs scripts R permettant le remplissage de la base de donnée ( sous condition d'avoir les données dans data_raw)

Les fichiers se trouvant dans pré-traitement peuvent être lancé directement (après avoir fait "Session >> Set Working Directory >> To source file location" dans R, et peut être modifié les couples user / mot de passe pour la connexion à la base de donnée).

# To do :

- [ ] Rapport
	- [ ] Intro (>> ???)
	- [ ] 1 Description des données (>> ???)
	- [ ] 2 Objectifs d'analyse (>> ???)
	- [ ] 3 Modèle conceptuel multidimensionnel (>> Erwan)
	- [ ] 4 Implémentation du modèle (>> Erwan)
	- [ ] 5 Tâches d'ETL (>> Erwan)
	- [ ] 6 Analyses OLAP - Reporting (>> ???)
	- [ ] 7 Conclusion (>> ???)
- [ ] Réaliser les premières analyses sur Tableau Software (>> ???)
- [ ] Modèle conceptuel des données (>> Erwan)
- [ ] Chargement en BDD du dataset commodity_trades conforme au MCD (>> Erwan)


