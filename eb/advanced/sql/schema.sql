CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP TABLE IF EXISTS answers; 
DROP TABLE IF EXISTS questions; 

CREATE TABLE public.answers (
  uuid UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  question_uuid UUID NOT NULL,
  choice CHAR(1) NOT NULL,
  is_correct BOOLEAN NOT NULL,
  created_at TIMESTAMP default current_timestamp NOT NULL
);

CREATE TABLE public.questions (
  uuid UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  question TEXT NOT NULL,
  option_a TEXT NOT NULL,
  option_b TEXT NOT NULL,
  option_c TEXT NOT NULL,
  option_d TEXT NOT NULL,
  correct_answer CHAR(1) NOT NULL
);