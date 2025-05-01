CREATE DATABASE IF NOT EXISTS Wubrg;
USE Wubrg;
-- Create the users table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Create the locations table
CREATE TABLE IF NOT EXISTS locations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS messages (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    sender_id BIGINT UNSIGNED NOT NULL,
    recipient_id BIGINT UNSIGNED,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(id),
    FOREIGN KEY (recipient_id) REFERENCES users(id)
);
CREATE TABLE IF NOT EXISTS cards (
    id VARCHAR(36) PRIMARY KEY,
    object VARCHAR(50),
    oracle_id VARCHAR(36),
    multiverse_ids JSON,
    tcgplayer_id INT,
    cardmarket_id INT,
    name VARCHAR(255),
    lang VARCHAR(10),
    released_at DATE,
    uri VARCHAR(255),
    scryfall_uri VARCHAR(255),
    layout VARCHAR(50),
    highres_image BOOLEAN,
    image_status VARCHAR(50),
    image_uris JSON,
    mana_cost VARCHAR(50),
    cmc DECIMAL(4,2),
    type_line VARCHAR(255),
    oracle_text TEXT,
    colors JSON,
    color_identity JSON,
    keywords JSON,
    legalities JSON,
    games JSON,
    reserved BOOLEAN,
    game_changer BOOLEAN,
    foil BOOLEAN,
    nonfoil BOOLEAN,
    finishes JSON,
    oversized BOOLEAN,
    promo BOOLEAN,
    reprint BOOLEAN,
    variation BOOLEAN,
    set_id VARCHAR(36),
    set_name VARCHAR(100),
    set_type VARCHAR(50),
    set_uri VARCHAR(255),
    set_search_uri VARCHAR(255),
    scryfall_set_uri VARCHAR(255),
    rulings_uri VARCHAR(255),
    prints_search_uri VARCHAR(255),
    collector_number VARCHAR(10),
    digital BOOLEAN,
    rarity VARCHAR(50),
    card_back_id VARCHAR(36),
    artist VARCHAR(100),
    artist_ids JSON,
    illustration_id VARCHAR(36),
    border_color VARCHAR(50),
    frame VARCHAR(50),
    full_art BOOLEAN,
    textless BOOLEAN,
    booster BOOLEAN,
    story_spotlight BOOLEAN,
    edhrec_rank INT,
    prices JSON,
    related_uris JSON,
    purchase_uris JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS sets (
    id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS cards (
    id VARCHAR(36) PRIMARY KEY,
    -- other card columns...
    set_id VARCHAR(36),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (set_id) REFERENCES sets(id)
) ENGINE=InnoDB;

