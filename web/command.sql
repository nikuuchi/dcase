create database dcaseweb;

grant all on dcaseweb.* to dcase@localhost identified by 'dcase';

use dcaseweb;

create table users (
        id int(11) auto_increment primary key not null,
        twitter_user_id varchar(30) unique,
        twitter_screen_name varchar(15),
        twitter_profile_image_url varchar(255),
        twitter_access_token varchar(255),
        twitter_access_token_secret varchar(255),
        created  datetime,
        modified datetime
        );
