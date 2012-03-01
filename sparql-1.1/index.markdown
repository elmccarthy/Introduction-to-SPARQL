Title:				SPARQL-intro: SPARQL 1.1
Base Header Level:	2
Keywords:			RDF, SPARQL, Linked Data, Semantic Web
copyright:			2012 Luke McCarthy.
					This work is licensed under a Creative Commons License.  
					http://creativecommons.org/licenses/by-sa/3.0/

# SPARQL 1.1 #

## Aggregate functions ##

SPARQL 1.1 will add aggregate functions (GROUP BY, HAVING, etc.), which are sorely missed in SPARQL 1.0. ARQ 2.8.8 supports some SPARQL 1.1 features, but the support must be turned on with the <code>\--syntax ARQ</code> command-line option:

<code markdown='1'>$ sparql \--syntax ARQ \--data [../social.ttl][social.ttl] \--query [count.sparql][]</code>

query:
:
	PREFIX foaf: <http://xmlns.com/foaf/0.1/>
	SELECT ?name COUNT(?connection)
	WHERE {
	    ?person a foaf:Person .
	    ?person foaf:name ?name .
	    ?person foaf:knows ?connection .
	} GROUP BY ?name

results:
:
    --------------------------
    | name              | .1 |
    ==========================
    | "Melanie Courtot" | 2  |
    | "Mark Wilkinson"  | 3  |
    | "Matt Links"      | 2  |
    | "Luke McCarthy"   | 3  |
    --------------------------

COUNT is just one of the aggregate functions supported by SPARQL 1.1. There is a complete list in the [SPARQL 1.1 W3C Recommendation][]

[SPARQL 1.1 W3C Recommendation]: http://www.w3.org/TR/sparql11-query/#setFunctions
  "SPARQL 1.1 W3C Recommendation: set functions"

## Calculation ##

SPARQL 1.1 will also support inline calculation. Here is an example that is support by ARQ (with the <code>\--syntax ARQ</code> switch):

<code markdown='1'>$ sparql \--syntax ARQ \--data [../social.ttl][social.ttl] \--query [bmi.sparql][]</code>

query:
:
	PREFIX foaf: <http://xmlns.com/foaf/0.1/> 
	PREFIX mged: <http://mged.sourceforge.net/ontologies/MGEDOntology.owl#> 
	SELECT ?name ?bmi
	WHERE {
	    ?person a foaf:Person .
	    ?person foaf:name ?name .
	    ?person foaf:knows ?connection .
	    ?person mged:height ?height .
	    ?person mged:mass ?weight .
	} GROUP BY ?name ((?weight / (?height * ?height)) as ?bmi)

results:
:
	-----------------------------------------
	| name            | bmi                 |
	=========================================
	| "Luke McCarthy" | 26.32017237098755e0 |
	-----------------------------------------

No comment.

## NOT EXISTS clauses ##

This is the FILTER( !BOUND(…) ) query from the previous section, reworked to take advantage of the SPARQL 1.1 <code>NOT EXISTS</code> clause (again, the <code>\--syntax ARQ</code> switch is required):

<code markdown='1'>$ sparql \--syntax ARQ \--data [../social.ttl][social.ttl] \--query [not-exists.sparql][]</code>

query:
:
	PREFIX foaf: <http://xmlns.com/foaf/0.1/>
	SELECT ?person
	WHERE {
	    <http://elmonline.ca/luke> foaf:knows ?person .
	    NOT EXISTS { <http://www.linkedin.com/in/mcourtot> foaf:knows ?person  . }
	}

results:
:
    ----------------------------------------------------------
    | person                                                 |
    ==========================================================
    | <http://www.linkedin.com/pub/matthew-links/44/381/647> |
    | <http://www.linkedin.com/in/mcourtot>                  |
    ----------------------------------------------------------

[count.sparql]: count.sparql
  "Label"
[bmi.sparql]: bmi.sparql
  "Label"
[not-exists.sparql]: not-exists.sparql
  "Label"
[social.ttl]: ../social.ttl
  "Simple social network"

[« Previous: More complex SPARQL queries «][Complex]

[Complex]: ../complex/ "More complex SPARQL queries" class=prev

