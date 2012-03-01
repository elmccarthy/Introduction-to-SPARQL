Title:				SPARQL-intro: More complex SPARQL queries
Base Header Level:	2
Keywords:			RDF, SPARQL, Linked Data, Semantic Web
copyright:			2012 Luke McCarthy.
					This work is licensed under a Creative Commons License.  
					http://creativecommons.org/licenses/by-sa/3.0/

# More complex SPARQL queries #

## Multiple clauses ##

We can have as many clauses in a SPARQL query as we need. Every clause must be satisfied to return a result:

<code markdown='1'>$ sparql \--data [../social.ttl][social.ttl] \--query [mbox.sparql][]</code>

query:
:
	PREFIX foaf: <http://xmlns.com/foaf/0.1/>
	SELECT ?name ?email
	WHERE {
	    ?person a foaf:Person .
	    ?person foaf:name ?name .
	    ?person foaf:mbox ?email .
	}

results:
:
	---------------------------------------------------
	| name            | email                         |
	===================================================
	| "Luke McCarthy" | <mailto:elmccarthy@gmail.com> |
	---------------------------------------------------

Notice that only one binding is returned, even though we know there are more people in the dataset.

## Optional clauses ##

We can make any clause (or group of clauses) optional:

<code markdown='1'>$ sparql \--data [../social.ttl][social.ttl] \--query [mbox-optional.sparql][]</code>

query:
:
	PREFIX foaf: <http://xmlns.com/foaf/0.1/>
	SELECT ?name ?email
	WHERE {
	    ?person a foaf:Person .
	    ?person foaf:name ?name .
	    OPTIONAL {
	        ?person foaf:mbox ?email .
	    }
	}

results:
:
	-----------------------------------------------------
	| name              | email                         |
	=====================================================
	| "Matt Links"      |                               |
	| "Mark Wilkinson"  |                               |
	| "Melanie Courtot" |                               |
	| "Luke McCarthy"   | <mailto:elmccarthy@gmail.com> |
	-----------------------------------------------------

Notice that now we get a binding for every person, but some bindings have no value bound to the <code>?email</code> variable.


## CONSTRUCT queries ##

We can use a SPARQL CONSTRUCT query to extract a subset of the RDF dataset being queried. For example, here we extract only the connections from the social network:

<code markdown='1'>$ sparql \--data [../social.ttl][social.ttl] \--query [construct-subset.sparql][]</code>

query:
:
	PREFIX foaf: <http://xmlns.com/foaf/0.1/>
	CONSTRUCT {
	    ?person foaf:knows ?connection .
	} WHERE {
	    ?person a foaf:Person .
	    ?person foaf:knows ?connection .
	}

results:
:
	@prefix dc:      <http://purl.org/dc/terms/> .
	@prefix rdfs:    <http://www.w3.org/2000/01/rdf-schema#> .
	@prefix mged:    <http://mged.sourceforge.net/ontologies/MGEDOntology.owl#> .
	@prefix dctype:  <http://purl.org/dc/dcmitype/> .
	@prefix foaf:    <http://xmlns.com/foaf/0.1/> .
	@prefix rdf:     <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
	 
	<http://www.linkedin.com/in/mcourtot>
	      foaf:knows    <http://www.linkedin.com/pub/mark-wilkinson/1/674/665> ;
	      foaf:knows    <http://elmonline.ca/luke> .
	 
	<http://www.linkedin.com/pub/mark-wilkinson/1/674/665>
	      foaf:knows    <http://www.linkedin.com/in/mcourtot> ;
	      foaf:knows    <http://www.linkedin.com/pub/matthew-links/44/381/647> ;
	      foaf:knows    <http://elmonline.ca/luke> .
	 
	<http://www.linkedin.com/pub/matthew-links/44/381/647>
	      foaf:knows    <http://www.linkedin.com/pub/mark-wilkinson/1/674/665> ;
	      foaf:knows    <http://elmonline.ca/luke> .
	 
	<http://elmonline.ca/luke>
	      foaf:knows    <http://www.linkedin.com/in/mcourtot> ;
	      foaf:knows    <http://www.linkedin.com/pub/mark-wilkinson/1/674/665> ;
	      foaf:knows    <http://www.linkedin.com/pub/matthew-links/44/381/647> .

Notice that the query returned RDF, rather than variable bindings. We can, of course, use OPTIONAL and FILTER clauses with CONSTRUCT queries just as with SELECT queries.

There is one final SPARQL query type: ASK. An ASK query simply returns true if there are any bindings that satisfy the WHERE clause, and false otherwise.

## Translating RDF vocabularies with CONSTRUCT queries ##

One important use of CONSTRUCT queries is to translate RDF data from one vocabulary to another:

<code markdown='1'>$ sparql \--data [../social.ttl][social.ttl] \--query [construct-translate.sparql][]</code>

query:
:
	PREFIX foaf: <http://xmlns.com/foaf/0.1/>
	PREFIX example: <http://example.com/>
	CONSTRUCT {
	    ?person example:connected ?connection .
	} WHERE {
	    ?person a foaf:Person .
	    ?connection a foaf:Person .
	    {
	        ?person foaf:knows ?connection .
	    } UNION {
	        ?connection foaf:knows ?person .
	    }
	}

results:
:
	@prefix dc:      <http://purl.org/dc/terms/> .
	@prefix rdfs:    <http://www.w3.org/2000/01/rdf-schema#> .
	@prefix mged:    <http://mged.sourceforge.net/ontologies/MGEDOntology.owl#> .
	@prefix dctype:  <http://purl.org/dc/dcmitype/> .
	@prefix foaf:    <http://xmlns.com/foaf/0.1/> .
	@prefix rdf:     <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
	@prefix example:  <http://example.com/> .
	 
	<http://www.linkedin.com/in/mcourtot>
	      example:connected  <http://www.linkedin.com/pub/mark-wilkinson/1/674/665> ;
	      example:connected  <http://elmonline.ca/luke> .
	 
	<http://www.linkedin.com/pub/mark-wilkinson/1/674/665>
	      example:connected  <http://www.linkedin.com/in/mcourtot> ;
	      example:connected  <http://www.linkedin.com/pub/matthew-links/44/381/647> ;
	      example:connected  <http://elmonline.ca/luke> .
	 
	<http://www.linkedin.com/pub/matthew-links/44/381/647>
	      example:connected  <http://www.linkedin.com/pub/mark-wilkinson/1/674/665> ;
	      example:connected  <http://elmonline.ca/luke> .
	 
	<http://elmonline.ca/luke>
	      example:connected  <http://www.linkedin.com/in/mcourtot> ;
	      example:connected  <http://www.linkedin.com/pub/mark-wilkinson/1/674/665> ;
	      example:connected  <http://www.linkedin.com/pub/matthew-links/44/381/647> .

Notice that we have translated the <code>foaf:knows</code> property to a property of our own devising. Also notice the UNION clause, which simply allows either graph pattern to match. In this case, we are using the UNION clause to establish an <code>example:connection</code> relationship in any case where one party knows the other. If we were using a SPARQL processor backed by an OWL reasoner, we would be able to define <code>example:connection</code> as a symmetric property and automatically the relationship in the opposite direction, but that is a topic for a different tutorial.

## Filters ##

SPARQL allows you to exclude variable bindings that match specified expressions through a FILTER clause. This is often used to match text against a regular expression:

<code markdown='1'>$ sparql \--data [../social.ttl][social.ttl] \--query [filter.sparql][]</code>

query:
:
	PREFIX foaf: <http://xmlns.com/foaf/0.1/>
	SELECT ?person ?name
	WHERE {
	    <http://elmonline.ca/luke> foaf:knows ?person .
	    ?person foaf:name ?name .
        FILTER regex(?name, "matt", "i")
             # regex(?variable, regular_expression, flags)
	}

results:
:
	-------------------------------------------------------------------------
	| person                                                 | name         |
	=========================================================================
	| <http://www.linkedin.com/pub/matthew-links/44/381/647> | "Matt Links" |
	-------------------------------------------------------------------------

Notice the comment that spells out the syntax of the <code>regex</code> operator. Looking at the results of the query, you might think you could match the regular expression against the <code>?person</code> variable instead of the <code>?name</code> variable, but a URI will never match a regular expression. It must first be converted to a string with the <code>str</code> operator, like so: <code>FILTER regex(str(?person), "matt", "i")</code>.

There are many other operators in SPARQL. There is a long list in the [SPARQL W3C Recommendation][].

[SPARQL W3C Recommendation]: http://www.w3.org/TR/rdf-sparql-query/#OperatorMapping 
  "SPARQL W3C Recommendation: operators"

## Filtering bound/unbound optional variables ##

Another common use of the FILTER clause is to test whether or not an optional variable has been bound. This occurs in several of the more baroque constructs that are required to get around the deficiencies of SPARQL 1.0. As an example, consider this query to find people I know that Melanie does not:

<code markdown='1'>$ sparql \--data [../social.ttl][social.ttl] \--query [filter-unbound.sparql][]</code>

query:
:
	PREFIX foaf: <http://xmlns.com/foaf/0.1/>
	SELECT ?person
	WHERE {
	    <http://elmonline.ca/luke> foaf:knows ?person .
	    OPTIONAL { 
	        <http://www.linkedin.com/in/mcourtot> foaf:knows ?person2 .
	        FILTER (?person = ?person2)
	    } FILTER ( !BOUND(?person2) )
	    # SPARQL 1.1 will replace this complex OPTIONAL/FILTER clause with:
	    # NOT EXISTS { <http://www.linkedin.com/in/mcourtot> foaf:knows ?person  . }
	}

results:
:
	----------------------------------------------------------
	| person                                                 |
	==========================================================
	| <http://www.linkedin.com/pub/matthew-links/44/381/647> |
	| <http://www.linkedin.com/in/mcourtot>                  |
	----------------------------------------------------------

Notice that the entire OPTIONAL/FILTER clause can be replaced by a SPARQL 1.1 NOT EXISTS clause. Also notice that Melanie does not know herself. This is yet another problem that could be solved by using a SPARQL processor backed by an OWL reasoner (in this case we would be able to define <code>foaf:knows</code> as a reflexive property and automatically infer that Melanie knows herself).

[mbox.sparql]: mbox.sparql
  "Names and email addresses"
[mbox-optional.sparql]: mbox-optional.sparql
  "Names and, optionally, email addresses"
[construct-subset.sparql]: construct-subset.sparql
  "A CONSTRUCT query"
[construct-translate.sparql]: construct-translate.sparql
  "A CONSTRUCT query with translation"
[filter.sparql]: filter.sparql
  "FILTER regex()"
[filter-unbound.sparql]: filter-unbound.sparql
  "FILTER !BOUND"
[social.ttl]: ../social.ttl
  "Simple social network"

[« Previous: Exploring RDF data with SPARQL «][Explore]
[» Next: SPARQL 1.1 »][SPARQL-1.1]

[Explore]: ../first/ "Exploring RDF data with SPARQL" class=prev
[SPARQL-1.1]: ../sparql-1.1/ "SPARQL 1.1" class=next
