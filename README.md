# 🏆 Tournois LoL - App de gestion de tournois League of Legends

Une application de gestion de tournois League of Legends permettant de gérer les équipes, les joueurs et les matchs.

---

## ✨ Fonctionnalités

- CRUD complet sur les joueurs, équipes, matchs et resultats
- Attribution de rôle et d'équipe par joueur
- Filtrage lors de recherche de joueurs, équipes, matchs
- Interface responsive avec TailwindCSS

---

## ❌ Contraintes

- Une équipe doit avoir au moins un joueur pour être valide
- Un joueur ne peut pas être supprimé si son équipe a des matchs associés
- Une équipe ne peut pas être supprimée si elle a des joueurs ou des matchs associés
- Un match ne peut pas être modifié s'il est en cours ou terminé

---

## 📜 Modèles

### Team (Équipe)

- `name`: Nom de l'équipe
- Relations :
  - `has_many :players` - Les joueurs de l'équipe
  - `has_many :home_matches` - Matchs où l'équipe est la première équipe
  - `has_many :away_matches` - Matchs où l'équipe est la deuxième équipe

### Player (Joueur)

- `first_name`: Prénom du joueur
- `last_name`: Nom du joueur
- `role`: Rôle du joueur (Top laner, Jungler, Mid laner, ADC, Support)
- `team_id`: Référence à l'équipe du joueur
- Relations :
  - `belongs_to :team` - L'équipe à laquelle appartient le joueur

### Match

- `first_team_id`: Référence à la première équipe
- `second_team_id`: Référence à la deuxième équipe
- `date`: Date et heure du match
- `status`: Statut du match (upcoming, in_progress, completed, cancelled)
- Relations :
  - `belongs_to :first_team`
  - `belongs_to :second_team`
  - `has_one :result`
  - `has_many :match_players`
  - `has_many :players, through: :match_players`

### Result

- `match_id`: Référence au match
- `first_team_score`: Score de la première équipe
- `second_team_score`: Score de la deuxième équipe
- Relations :
  - `belongs_to :match`

---

## 🛠️ Stack technique

- Ruby **3.4.3**
- Rails **7.1.5.1**
- Base de données : **SQLite3**
- Frontend : **Hotwire (Turbo + Stimulus)** & **TailwindCSS**
- Importmap (pas besoin de Node/Yarn)

---

## ⚙️ Installation

1. Clonez le dépôt :

```bash
git clone https://github.com/theoMich19/Ruby_crud_lol.git
cd Ruby_crud_lol
```

2. Installez les dépendances Ruby :

```bash
bundle install
```

3. Configurez la base de données avec les données de la seed :

```bash
rails db:setup
```

4. Lancez le serveur de développement :

```bash
rails server
```

L'application sera accessible à l'adresse `http://localhost:3000`
