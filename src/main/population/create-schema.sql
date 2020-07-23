
    create table `administrator` (
       `id` integer not null,
        `version` integer not null,
        `user_account_id` integer,
        primary key (`id`)
    ) engine=InnoDB;

    create table `anonymous` (
       `id` integer not null,
        `version` integer not null,
        `user_account_id` integer,
        primary key (`id`)
    ) engine=InnoDB;

    create table `authenticated` (
       `id` integer not null,
        `version` integer not null,
        `user_account_id` integer,
        primary key (`id`)
    ) engine=InnoDB;

    create table `banner` (
       `id` integer not null,
        `version` integer not null,
        `credit_card_brand` varchar(255),
        `credit_card_cvv` integer,
        `credit_card_exp_month` integer,
        `credit_card_exp_year` integer,
        `credit_card_holder_name` varchar(255),
        `credit_card_number` varchar(255),
        `picture` varchar(255),
        `slogan` varchar(255),
        `targeturl` varchar(255),
        primary key (`id`)
    ) engine=InnoDB;

    create table `challenge` (
       `id` integer not null,
        `version` integer not null,
        `average_goal_amount` double precision,
        `average_goal_currency` varchar(255),
        `average_reward_amount` double precision,
        `average_reward_currency` varchar(255),
        `deadline` datetime(6),
        `description` varchar(255),
        `expert_goal_amount` double precision,
        `expert_goal_currency` varchar(255),
        `expert_reward_amount` double precision,
        `expert_reward_currency` varchar(255),
        `rookie_goal_amount` double precision,
        `rookie_goal_currency` varchar(255),
        `rookie_reward_amount` double precision,
        `rookie_reward_currency` varchar(255),
        `title` varchar(255),
        primary key (`id`)
    ) engine=InnoDB;

    create table `consumer` (
       `id` integer not null,
        `version` integer not null,
        `user_account_id` integer,
        `company` varchar(255),
        `sector` varchar(255),
        primary key (`id`)
    ) engine=InnoDB;

    create table `customisation` (
       `id` integer not null,
        `version` integer not null,
        `activity_sectors` varchar(255),
        `spam_threshold` double precision,
        `spam_words` varchar(255),
        primary key (`id`)
    ) engine=InnoDB;

    create table `inquiry` (
       `id` integer not null,
        `version` integer not null,
        `creation` datetime(6),
        `deadline` datetime(6),
        `description` varchar(255),
        `email` varchar(255),
        `max_money_amount` double precision,
        `max_money_currency` varchar(255),
        `min_money_amount` double precision,
        `min_money_currency` varchar(255),
        `title` varchar(255),
        primary key (`id`)
    ) engine=InnoDB;

    create table `murillo_bulletin` (
       `id` integer not null,
        `version` integer not null,
        `author` varchar(255),
        `moment` datetime(6),
        `number` integer,
        `text` varchar(255),
        `title` varchar(255),
        `volumen` integer,
        primary key (`id`)
    ) engine=InnoDB;

    create table `notice` (
       `id` integer not null,
        `version` integer not null,
        `body` varchar(255),
        `creation` datetime(6),
        `deadline` datetime(6),
        `optional_links` varchar(255),
        `picture` varchar(255),
        `title` varchar(255),
        primary key (`id`)
    ) engine=InnoDB;

    create table `overture` (
       `id` integer not null,
        `version` integer not null,
        `creation` datetime(6),
        `deadline` datetime(6),
        `description` varchar(255),
        `email` varchar(255),
        `max_money_amount` double precision,
        `max_money_currency` varchar(255),
        `min_money_amount` double precision,
        `min_money_currency` varchar(255),
        `title` varchar(255),
        primary key (`id`)
    ) engine=InnoDB;

    create table `pazos_bulletin` (
       `id` integer not null,
        `version` integer not null,
        `author` varchar(255),
        `contact` varchar(255),
        `experience` bit,
        `food_handler` bit,
        `moment` datetime(6),
        `text` varchar(255),
        primary key (`id`)
    ) engine=InnoDB;

    create table `provider` (
       `id` integer not null,
        `version` integer not null,
        `user_account_id` integer,
        `company` varchar(255),
        `sector` varchar(255),
        primary key (`id`)
    ) engine=InnoDB;

    create table `rosa_bulletin` (
       `id` integer not null,
        `version` integer not null,
        `author` varchar(255),
        `description` varchar(255),
        `moment` datetime(6),
        `title` varchar(255),
        primary key (`id`)
    ) engine=InnoDB;

    create table `technology_record` (
       `id` integer not null,
        `version` integer not null,
        `activity_sector` varchar(255),
        `description` varchar(255),
        `email` varchar(255),
        `inventor` varchar(255),
        `open_source` bit,
        `stars` integer,
        `title` varchar(255),
        `website` varchar(255),
        primary key (`id`)
    ) engine=InnoDB;

    create table `tool_record` (
       `id` integer not null,
        `version` integer not null,
        `activity_sector` varchar(255),
        `description` varchar(255),
        `email` varchar(255),
        `inventor` varchar(255),
        `open_source` bit,
        `stars` integer,
        `title` varchar(255),
        `website` varchar(255),
        primary key (`id`)
    ) engine=InnoDB;

    create table `user_account` (
       `id` integer not null,
        `version` integer not null,
        `enabled` bit not null,
        `identity_email` varchar(255),
        `identity_name` varchar(255),
        `identity_surname` varchar(255),
        `password` varchar(255),
        `username` varchar(255),
        primary key (`id`)
    ) engine=InnoDB;

    create table `hibernate_sequence` (
       `next_val` bigint
    ) engine=InnoDB;

    insert into `hibernate_sequence` values ( 1 );

    alter table `user_account` 
       add constraint UK_castjbvpeeus0r8lbpehiu0e4 unique (`username`);

    alter table `administrator` 
       add constraint FK_2a5vcjo3stlfcwadosjfq49l1 
       foreign key (`user_account_id`) 
       references `user_account` (`id`);

    alter table `anonymous` 
       add constraint FK_6lnbc6fo3om54vugoh8icg78m 
       foreign key (`user_account_id`) 
       references `user_account` (`id`);

    alter table `authenticated` 
       add constraint FK_h52w0f3wjoi68b63wv9vwon57 
       foreign key (`user_account_id`) 
       references `user_account` (`id`);

    alter table `consumer` 
       add constraint FK_6cyha9f1wpj0dpbxrrjddrqed 
       foreign key (`user_account_id`) 
       references `user_account` (`id`);

    alter table `provider` 
       add constraint FK_b1gwnjqm6ggy9yuiqm0o4rlmd 
       foreign key (`user_account_id`) 
       references `user_account` (`id`);
