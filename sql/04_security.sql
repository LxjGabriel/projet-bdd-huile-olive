SET search_path TO huile;

-- =========================
-- Création des rôles
-- =========================

DO $$
BEGIN
   IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'huile_admin') THEN
      CREATE ROLE huile_admin LOGIN PASSWORD 'admin123';
   END IF;

   IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'huile_vendeur') THEN
      CREATE ROLE huile_vendeur LOGIN PASSWORD 'vendeur123';
   END IF;

   IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'huile_manager') THEN
      CREATE ROLE huile_manager LOGIN PASSWORD 'manager123';
   END IF;
END
$$;

-- =========================
-- Droits pour l’admin
-- =========================

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA huile TO huile_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA huile TO huile_admin;

-- =========================
-- Droits pour le vendeur
-- lecture seule sur les tables utiles
-- =========================

GRANT SELECT ON
    client,
    produit,
    categorie,
    magasin,
    stock,
    commande,
    ligne_commande
TO huile_vendeur;

-- =========================
-- Droits pour le manager
-- lecture + gestion des commandes et du stock
-- =========================

GRANT SELECT ON ALL TABLES IN SCHEMA huile TO huile_manager;

GRANT INSERT, UPDATE ON
    commande,
    ligne_commande,
    stock
TO huile_manager;

GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA huile TO huile_manager;