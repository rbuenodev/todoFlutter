CREATE SEQUENCE todos_seq;

CREATE TABLE IF NOT EXISTS todos (
  id int NOT NULL DEFAULT NEXTVAL ('todos_seq'),
  description varchar(255),
  created_at timestamp(6) NOT NULL,
  completion_date timestamp(6),
  status  int,
  PRIMARY KEY (id)
);
