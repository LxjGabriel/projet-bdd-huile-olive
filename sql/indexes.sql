SET search_path TO huile;

-- Index pour retrouver rapidement les commandes d’un client
CREATE INDEX idx_commande_id_client
ON commande(id_client);

-- Index pour filtrer les commandes par magasin
CREATE INDEX idx_commande_id_magasin
ON commande(id_magasin);

-- Index pour retrouver rapidement le stock d’un produit
CREATE INDEX idx_stock_id_produit
ON stock(id_produit);

-- Index pour filtrer les produits par catégorie
CREATE INDEX idx_produit_id_categorie
ON produit(id_categorie);

-- Index pour analyser les ventes par produit
CREATE INDEX idx_ligne_commande_id_produit
ON ligne_commande(id_produit);
