
create table if not exists sexes (
    id serial primary key,
    nom varchar(255) not null unique
);

insert into sexes (nom)
values ('Masculin'), ('Feminin')
on conflict (nom) do nothing;

create table if not exists patients (
    id serial primary key,
    nom varchar(255) not null,
    prenom varchar(255) not null,
    sexe_id int not null,
    numero_telephone varchar(20) not null,
    date_naissance date not null,
    adresse varchar(255) not null,
    email varchar(255) not null unique,
    mdp varchar(255) not null,
    constraint fk_patients_sexe
        foreign key (sexe_id) references sexes(id)
);

create table if not exists medicins (
    id serial primary key,
    nom varchar(255) not null,
    prenom varchar(255) not null,
    sexe_id int not null,
    numero_telephone varchar(20) not null,
    mdp varchar(255) not null,
    constraint fk_medicins_sexe
        foreign key (sexe_id) references sexes(id)
);
