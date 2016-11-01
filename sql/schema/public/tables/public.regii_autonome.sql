-- Table: public.regii_autonome

-- DROP TABLE public.regii_autonome;

CREATE TABLE public.regii_autonome
(
  id serial NOT NULL,
  judet text NOT NULL,
  url text NOT NULL,
  CONSTRAINT regii_autonome_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.regii_autonome
  OWNER TO postgres;
 
