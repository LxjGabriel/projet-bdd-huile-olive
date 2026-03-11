SET search_path TO huile;

TRUNCATE TABLE
  ligne_commande,
  commande,
  stock,
  employe,
  client,
  role,
  produit,
  categorie,
  magasin
RESTART IDENTITY CASCADE;

-- catégories
INSERT INTO categorie (nom)
VALUES
('huile'),
('coffret');

-- produits
INSERT INTO produit (nom, description, prix, id_categorie)
VALUES
('Huile Extra Vierge 500ml', 'huile premium', 12.90, 1),
('Huile Bio 1L', 'huile biologique', 22.50, 1);

-- magasins
INSERT INTO magasin (nom, ville)
VALUES
('Boutique Paris', 'Paris'),
('Boutique Lyon', 'Lyon');

-- rôles
INSERT INTO role (nom)
VALUES
('vendeur'),
('manager');

-- clients
INSERT INTO client (nom, prenom, email)
VALUES
('Garcia', 'Ana', 'ana@email.com'),
('Martin', 'Lucas', 'lucas@email.com');

-- employés
INSERT INTO employe (nom, prenom, id_magasin, id_role)
VALUES
('Durand', 'Paul', 1, 1);

-- stock
INSERT INTO stock (id_magasin, id_produit, quantite)
VALUES
(1, 1, 20),
(1, 2, 15),
(2, 1, 10);

-- commandes
INSERT INTO commande (id_client, id_magasin)
VALUES
(1, 1),
(2, NULL);

-- lignes commande
INSERT INTO ligne_commande (id_commande, id_produit, quantite, prix_unitaire)
VALUES
(1, 1, 2, 12.90),
(1, 2, 1, 22.50),
(2, 1, 3, 12.90);