CREATE DATABASE ronilacki_klub;

USE ronilacki_klub;

CREATE TABLE zaposleni(
    jmbg CHAR(13) PRIMARY KEY, 
    ime VARCHAR(30), 
    prezime VARCHAR(30), 
    adresa TEXT
);

CREATE TABLE sss(
    ime VARCHAR(30) PRIMARY KEY
);

CREATE TABLE radnik(
    jmbg_z CHAR(13) PRIMARY KEY, 
    vrijeme INT, 
    CONSTRAINT FK_RADNIK_ZAP FOREIGN KEY (jmbg_z) REFERENCES zaposleni(jmbg)
); 

CREATE TABLE menadzer(
    jmbg_z CHAR(13) PRIMARY KEY, 
    ime_s VARCHAR(30) NOT NULL, 
    CONSTRAINT FK_MENADZER_SSS FOREIGN KEY (ime_s) REFERENCES sss(ime), 
    CONSTRAINT FK_MENADZER_ZAP FOREIGN KEY (jmbg_z) REFERENCES zaposleni(jmbg) 
);

CREATE TABLE instruktor(
    jmbg_z CHAR(13) PRIMARY KEY,  
    CONSTRAINT FK_JMBG FOREIGN KEY (jmbg_z) REFERENCES zaposleni(jmbg) 
);

CREATE TABLE ruta(
    ime VARCHAR(50) PRIMARY KEY, 
    dubina DECIMAL(7, 2), 
    tezina_rute VARCHAR(50),
    lokacija VARCHAR(50)
);

CREATE TABLE licenca(
    ime VARCHAR(50) PRIMARY KEY
);

CREATE TABLE tura(
    broj INT PRIMARY KEY, 
    datum DATETIME2,
    broj_ljudi INT,
    lokacija VARCHAR(50),
    ime_r VARCHAR(50) NOT NULL,
    jmbg_i CHAR(13) NOT NULL,
    CONSTRAINT FK_TURA_RUTA FOREIGN KEY (ime_r) REFERENCES ruta(ime),
    CONSTRAINT FK_TURA_INSTRUKTOR FOREIGN KEY (jmbg_i) REFERENCES instruktor(jmbg_z)
);

CREATE TABLE ruta_instruktor(
    ime_r VARCHAR(50),
    jmbg_i CHAR(13),
    ime_l VARCHAR(50) NOT NULL,
    PRIMARY KEY (ime_r, jmbg_i), 
    CONSTRAINT FK_RUTA_INSTRUKTOR_RUTA FOREIGN KEY  (ime_r) REFERENCES ruta(ime), 
    CONSTRAINT FK_RUTA_INSTRUKTOR_INSTRUKTOR FOREIGN KEY (jmbg_i) REFERENCES instruktor(jmbg_z)
);

CREATE TABLE klijent(
    broj_racuna INT PRIMARY KEY,
    broj_telefona INT,
    adresa TEXT,
    ime VARCHAR(50),
    prezime VARCHAR(50),
    ronilacka_licenca TEXT
);


CREATE TABLE klijent_tura(
    broj_racuna_k INT,
    broj_t INT,
    jmbg_m CHAR(13),
    PRIMARY KEY (broj_racuna_k,broj_t),
    CONSTRAINT FK_KLIJENT_TURA_KLIJENT FOREIGN KEY (broj_racuna_k) REFERENCES klijent(broj_racuna),
    CONSTRAINT FK_KLIJENT_TURA_TURA FOREIGN KEY (broj_t) REFERENCES tura(broj),
    CONSTRAINT FK_KLIJENT_TURA_MENADZER FOREIGN KEY (jmbg_m) REFERENCES menadzer(jmbg_z)
)
