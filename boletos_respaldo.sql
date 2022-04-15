--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: boletos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.boletos (
    id integer NOT NULL,
    pasajeros_rut_fk character varying(10),
    vuelos_fk integer
);


ALTER TABLE public.boletos OWNER TO postgres;

--
-- Name: boletos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.boletos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.boletos_id_seq OWNER TO postgres;

--
-- Name: boletos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.boletos_id_seq OWNED BY public.boletos.id;


--
-- Name: pasajeros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pasajeros (
    rut character varying(10) NOT NULL,
    nombre character varying(25),
    apellido character varying(25)
);


ALTER TABLE public.pasajeros OWNER TO postgres;

--
-- Name: vuelos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vuelos (
    id integer NOT NULL,
    costo integer,
    asientos smallint,
    nombre_ruta character varying(50),
    hora_despegue time without time zone,
    hora_aterrizaje time without time zone,
    CONSTRAINT vuelos_asientos_check CHECK ((asientos >= 0))
);


ALTER TABLE public.vuelos OWNER TO postgres;

--
-- Name: vuelos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vuelos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vuelos_id_seq OWNER TO postgres;

--
-- Name: vuelos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vuelos_id_seq OWNED BY public.vuelos.id;


--
-- Name: boletos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boletos ALTER COLUMN id SET DEFAULT nextval('public.boletos_id_seq'::regclass);


--
-- Name: vuelos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelos ALTER COLUMN id SET DEFAULT nextval('public.vuelos_id_seq'::regclass);


--
-- Data for Name: boletos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.boletos (id, pasajeros_rut_fk, vuelos_fk) FROM stdin;
3	23456789-1	3
4	34567890-2	4
5	11223345-3	2
6	11223345-3	3
7	87612345-5	2
8	90234567-4	2
9	90234567-4	1
10	90234567-4	1
\.


--
-- Data for Name: pasajeros; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pasajeros (rut, nombre, apellido) FROM stdin;
23456789-1	Josefa	Gutierrez
34567890-2	Pablo	Smith
11223345-3	Pedro	Kasparov
90234567-4	Juan	Maestro
87612345-5	Iskander	Martinez
\.


--
-- Data for Name: vuelos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vuelos (id, costo, asientos, nombre_ruta, hora_despegue, hora_aterrizaje) FROM stdin;
5	100000	200	Papua Nueva Guinea - Chile	04:00:00	19:00:00
4	100000	199	Marruecos - Papua Nueva Guinea	17:00:00	00:00:00
3	100000	198	Brasil - Marruecos	03:00:00	15:00:00
2	100000	197	Dinamarca - Brasil	02:00:00	13:00:00
1	100000	198	Alemania - Chile	01:00:00	11:00:00
\.


--
-- Name: boletos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.boletos_id_seq', 10, true);


--
-- Name: vuelos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vuelos_id_seq', 5, true);


--
-- Name: boletos boletos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boletos
    ADD CONSTRAINT boletos_pkey PRIMARY KEY (id);


--
-- Name: pasajeros pasajeros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pasajeros
    ADD CONSTRAINT pasajeros_pkey PRIMARY KEY (rut);


--
-- Name: vuelos vuelos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelos
    ADD CONSTRAINT vuelos_pkey PRIMARY KEY (id);


--
-- Name: boletos boletos_pasajeros_rut_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boletos
    ADD CONSTRAINT boletos_pasajeros_rut_fk_fkey FOREIGN KEY (pasajeros_rut_fk) REFERENCES public.pasajeros(rut);


--
-- Name: boletos boletos_vuelos_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boletos
    ADD CONSTRAINT boletos_vuelos_fk_fkey FOREIGN KEY (vuelos_fk) REFERENCES public.vuelos(id);


--
-- PostgreSQL database dump complete
--

