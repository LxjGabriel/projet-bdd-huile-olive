CREATE SCHEMA IF NOT EXISTS huile;
SET search_path TO huile;



CREATE TABLE categorie (
  id_categorie  BIGSERIAL PRIMARY KEY,
  nom           TEXT NOT NULL UNIQUE
);

CREATE TABLE produit (
  id_produit    BIGSERIAL PRIMARY KEY,
  nom           TEXT NOT NULL,
  description   TEXT,
  prix          NUMERIC(10,2) NOT NULL CHECK (prix > 0),
  id_categorie  BIGINT NOT NULL REFERENCES categorie(id_categorie)
);

CREATE TABLE magasin (
  id_magasin    BIGSERIAL PRIMARY KEY,
  nom           TEXT NOT NULL,
  ville         TEXT NOT NULL
);

CREATE TABLE role (
  id_role       BIGSERIAL PRIMARY KEY,
  nom           TEXT NOT NULL UNIQUE
);



// persones

CREATE TABLE client (
  id_client     BIGSERIAL PRIMARY KEY,
  nom           TEXT NOT NULL,
  prenom        TEXT NOT NULL,
  email         TEXT NOT NULL UNIQUE
);

CREATE TABLE employe (
  id_employe    BIGSERIAL PRIMARY KEY,
  nom           TEXT NOT NULL,
  prenom        TEXT NOT NULL,
  id_magasin    BIGINT NOT NULL REFERENCES magasin(id_magasin),
  id_role       BIGINT NOT NULL REFERENCES role(id_role)
);

-- =============================================================

CREATE TABLE stock (
  id_magasin    BIGINT NOT NULL REFERENCES magasin(id_magasin) ON DELETE CASCADE,
  id_produit    BIGINT NOT NULL REFERENCES produit(id_produit) ON DELETE CASCADE,
  quantite      INTEGER NOT NULL CHECK (quantite >= 0),
  PRIMARY KEY (id_magasin, id_produit)
);

-- =============================================================

CREATE TABLE commande (
  id_commande   BIGSERIAL PRIMARY KEY,
  date_commande TIMESTAMPTZ NOT NULL DEFAULT now(),
  id_client     BIGINT NOT NULL REFERENCES client(id_client),
  id_magasin    BIGINT NULL REFERENCES magasin(id_magasin)

);

CREATE TABLE ligne_commande (
  id_commande   BIGINT NOT NULL REFERENCES commande(id_commande) ON DELETE CASCADE,
  id_produit    BIGINT NOT NULL REFERENCES produit(id_produit),
  quantite      INTEGER NOT NULL CHECK (quantite > 0),
  prix_unitaire NUMERIC(10,2) NOT NULL CHECK (prix_unitaire > 0),
  PRIMARY KEY (id_commande, id_produit)
);

