DROP TABLE IF EXISTS user_sessions;
CREATE TABLE user_sessions(
 session_date date,
 user_id int,
 time_spent_in_mins int
);

DaDROP TABLE IF EXISTS user_data;
CREATE TABLE user_data(
 user_id int,
 country char(3),
 age int
);
