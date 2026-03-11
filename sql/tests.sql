SET search_path TO huile;

-- =========================
-- 1. Vérifier les données des clients
-- =========================
SELECT *
FROM client;

-- =========================
-- 2. Vérifier les produits et leurs catégories
-- =========================
SELECT
    p.id_produit,
    p.nom AS nom_produit,
    p.description,
    p.prix,
    c.nom AS categorie
FROM produit p
JOIN categorie c ON p.id_categorie = c.id_categorie
ORDER BY p.id_produit;

-- =========================
-- 3. Vérifier les commandes avec les informations client
-- =========================
SELECT
    co.id_commande,
    co.date_commande,
    cl.nom AS nom_client,
    cl.prenom AS prenom_client,
    co.id_magasin
FROM commande co
JOIN client cl ON co.id_client = cl.id_client
ORDER BY co.id_commande;

-- =========================
-- 4. Distinguer les commandes en ligne et en magasin
-- =========================
SELECT
    id_commande,
    date_commande,
    id_client,
    id_magasin,
    CASE
        WHEN id_magasin IS NULL THEN 'commande en ligne'
        ELSE 'commande en magasin'
    END AS type_commande
FROM commande
ORDER BY id_commande;

-- =========================
-- 5. Vérifier le détail des lignes de commande
-- =========================
SELECT
    lc.id_commande,
    p.nom AS nom_produit,
    lc.quantite,
    lc.prix_unitaire
FROM ligne_commande lc
JOIN produit p ON lc.id_produit = p.id_produit
ORDER BY lc.id_commande, p.nom;

-- =========================
-- 6. Voir les produits vendus et la quantité totale vendue
-- =========================
SELECT
    p.id_produit,
    p.nom AS nom_produit,
    SUM(lc.quantite) AS quantite_totale_vendue
FROM produit p
JOIN ligne_commande lc ON p.id_produit = lc.id_produit
GROUP BY p.id_produit, p.nom
ORDER BY quantite_totale_vendue DESC;

-- =========================
-- 7. Voir le stock par magasin et par produit
-- =========================
SELECT
    m.nom AS nom_magasin,
    m.ville,
    p.nom AS nom_produit,
    s.quantite
FROM stock s
JOIN magasin m ON s.id_magasin = m.id_magasin
JOIN produit p ON s.id_produit = p.id_produit
ORDER BY m.nom, p.nom;

-- =========================
-- 8. Identifier les produits avec un stock faible
-- =========================
SELECT
    m.nom AS nom_magasin,
    p.nom AS nom_produit,
    s.quantite
FROM stock s
JOIN magasin m ON s.id_magasin = m.id_magasin
JOIN produit p ON s.id_produit = p.id_produit
WHERE s.quantite < 15
ORDER BY s.quantite ASC;

-- =========================
-- 9. Exemple d'analyse avec un index
-- =========================
EXPLAIN ANALYZE
SELECT *
FROM commande
WHERE id_client = 1;