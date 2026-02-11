# 🫒 Projet BDD – Plateforme de vente d’huile d’olive

## 📌 Prérequis

Avant de commencer, installer :

- Docker Desktop
- Beekeeper Studio (recommandé)
- Git

Vérifier que Docker fonctionne :

```bash
docker --version
```

---

# 🚀 1️⃣ Lancer la base de données

Depuis la racine du projet (où se trouve `docker-compose.yml`) :

```bash
docker compose up -d
```

Vérifier que le conteneur est actif :

```bash
docker compose ps
```

Le conteneur `huile_db` doit être en état **Up**.

---

# 🏗 2️⃣ Initialiser la base de données (MPD)

## 🔹 Sur Windows (PowerShell)

```powershell
Get-Content sql/mpd.sql | docker exec -i huile_db psql -U postgres -d huile_olive
```

## 🔹 Sur Mac / Linux / Git Bash

```bash
docker exec -i huile_db psql -U postgres -d huile_olive < sql/mpd.sql
```

Si aucune erreur n’apparaît, le schéma est correctement créé.

---

# 🧑‍💻 3️⃣ Se connecter via Beekeeper Studio

Créer une nouvelle connexion PostgreSQL avec les paramètres suivants :

| Champ      | Valeur        |
|------------|--------------|
| Host       | localhost     |
| Port       | 55432         |
| Database   | huile_olive   |
| User       | postgres      |
| Password   | postgres      |

Cliquer sur **Test Connection**, puis **Connect**.

---

# 🧪 4️⃣ Vérification

Dans Beekeeper, exécuter :

```sql
SELECT * FROM huile.client;
```

Si les tables apparaissent ou si la requête s’exécute sans erreur, la base est prête.

---

# 🛑 Arrêter la base

```bash
docker compose down
```

---

# 🔄 Réinitialiser complètement la base (si besoin)

```bash
docker compose down -v
docker compose up -d
```

Puis réexécuter le MPD.
