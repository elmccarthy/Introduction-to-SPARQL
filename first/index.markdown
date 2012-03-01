Title:				SPARQL-intro: Your first SPARQL query
Base Header Level:	2
Keywords:			RDF, SPARQL, Linked Data, Semantic Web
copyright:			2012 Luke McCarthy.
					This work is licensed under a Creative Commons License.  
					http://creativecommons.org/licenses/by-sa/3.0/

# Your first SPARQL query #

## The simplest possible query [^simpler] ##

Here is a very simple SPARQL query:

<code markdown='1'>$ sparql \--data [../social.ttl][social.ttl] \--query [simple.sparql][]</code>

query:
:
    SELECT ?person
    WHERE {
        <http://elmonline.ca/luke> <http://xmlns.com/foaf/0.1/knows> ?person .
    }

results:
:
    ----------------------------------------------------------
    | person                                                 |
    ==========================================================
    | <http://www.linkedin.com/pub/matthew-links/44/381/647> |
    | <http://www.linkedin.com/pub/mark-wilkinson/1/674/665> |
    | <http://www.linkedin.com/in/mcourtot>                  |
    ----------------------------------------------------------

[^simpler]: Actually, the simplest possible query would be a DESCRIBE with 
a single node.  Something like:

    DESCRIBE <http://elmonline.ca/luke>

## Prefixes ##

We can add URI prefixes to make the query easier to read:

<code markdown='1'>$ sparql \--data [../social.ttl][social.ttl] \--query [prefix.sparql][]</code>

query:
:
    PREFIX foaf: <http://xmlns.com/foaf/0.1/>
    SELECT ?person
    WHERE {
        <http://elmonline.ca/luke> foaf:knows ?person .
    }

results:
:
    ----------------------------------------------------------
    | person                                                 |
    ==========================================================
    | <http://www.linkedin.com/pub/matthew-links/44/381/647> |
    | <http://www.linkedin.com/pub/mark-wilkinson/1/674/665> |
    | <http://www.linkedin.com/in/mcourtot>                  |
    ----------------------------------------------------------

[simple.sparql]: simple.sparql
  "Simple SPARQL query"
[prefix.sparql]: prefix.sparql
  "Simple SPARQL query with prefixes"
[social.ttl]: ../social.ttl
  "Simple social network"

But how did we know what URIs to use in our query?

[« Previous: ARQ «][ARQ]
[» Next: Exploring RDF data with SPARQL »][Explore]

[ARQ]: ../arq/ "ARQ" class=prev
[Explore]: ../explore/ "Exploring RDF data with SPARQL" class=next
