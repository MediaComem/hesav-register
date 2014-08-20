--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.5
-- Dumped by pg_dump version 9.3.1
-- Started on 2014-08-20 13:16:48 CEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- TOC entry 2307 (class 0 OID 17446)
-- Dependencies: 172
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO events VALUES (2, 'gouveole', 'Gouveole', 'Gouveole', '2014-07-14', '2014-10-01', true, '2014-07-29 08:35:01', '2014-07-29 08:35:01');
INSERT INTO events VALUES (1, 'psy14', '6ème Journée de psychiatrie', '6ème Journée de psychiatrie', '2014-07-14', '2014-10-01', true, '2014-07-29 08:35:01', '2014-07-29 08:35:01');


--
-- TOC entry 2312 (class 0 OID 0)
-- Dependencies: 171
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('events_id_seq', 1, false);


-- Completed on 2014-08-20 13:16:48 CEST

--
-- PostgreSQL database dump complete
--

