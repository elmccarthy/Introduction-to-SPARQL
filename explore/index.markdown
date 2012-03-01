Title:				SPARQL-intro: Exploring RDF data with SPARQL
Base Header Level:	2
Keywords:			RDF, SPARQL, Linked Data, Semantic Web
copyright:			2012 Luke McCarthy.
					This work is licensed under a Creative Commons License.  
					http://creativecommons.org/licenses/by-sa/3.0/

# Exploring RDF data with SPARQL #

## Getting a list of types ##

A good place to start is finding out what kinds of things are in the data:

<code markdown='1'>sparql \--data [../social.ttl][social.ttl] \--query [types.sparql][]</code>

query:
:
    SELECT DISTINCT ?type 
    WHERE {
        [] a ?type
    }

results:
:
    --------------------------------------
    | type                               |
    ======================================
    | <http://purl.org/dc/dcmitype/Text> |
    | <http://xmlns.com/foaf/0.1/Person> |
    --------------------------------------

## DESCRIBE queries ##

We can use a DESCRIBE query to get basic information about an individual. Exactly what data DESCRIBE will return is up to the particular SPARQL implementation, but it is often simply every statement in which the specified entity is the subject. We don't know any individuals in the dataset, so we'll pick a random individual of a type we're interested in:

<code markdown='1'>sparql \--data [../social.ttl][social.ttl] \--query [describe.sparql][]</code>

query:
:
    PREFIX foaf: <http://xmlns.com/foaf/0.1/>
    DESCRIBE ?subject
    WHERE {
        ?subject a foaf:Person
    } LIMIT 1

results:
:
	@prefix dc:      <http://purl.org/dc/terms/> .
	@prefix rdfs:    <http://www.w3.org/2000/01/rdf-schema#> .
	@prefix dctype:  <http://purl.org/dc/dcmitype/> .
	@prefix foaf:    <http://xmlns.com/foaf/0.1/> .
	@prefix rdf:     <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
	 
	<http://ca.linkedin.com/pub/matthew-links/44/381/647>
		rdf:type      foaf:Person ;
		foaf:knows    <http://www.linkedin.com/pub/mark-wilkinson/1/674/665> ;
		foaf:knows    <http://elmonline.ca/luke> ;
		foaf:name     "Matt Links" .

Notice the <code>LIMIT</code> clause in the query.  Also notice that the query returned RDF, rather than variable bindings.

[types.sparql]: types.sparql
  "List types of things"
[describe.sparql]: prefix.sparql
  "A SPARQL DESCRIBE query"
[social.ttl]: ../social.ttl
  "Simple social network"

[« Previous: Your first SPARQL query «][First]
[» Next: More complex SPARQL queries »][Complex]

[First]: ../first/ "Your first SPARQL query" class=prev
[Complex]: ../complex/ "More complex SPARQL queries" class=next
