Title:				SPARQL-intro: ARQ
Base Header Level:	2
Keywords:			RDF, SPARQL, Linked Data, Semantic Web
copyright:			2012 Luke McCarthy.
					This work is licensed under a Creative Commons License.  
					http://creativecommons.org/licenses/by-sa/3.0/

# ARQ #

## Download ARQ ##

Download [ARQ 2.8.8][]. (we are using version 2.8.8 because the latest version has some stability issues)  Unzip the <code>arq-2.8.8.zip</code> file wherever you would like it to live.

[ARQ 2.8.8]: http://sourceforge.net/projects/jena/files/ARQ/ARQ-2.8.8/arq-2.8.8.zip/download
  "ARQ 2.8.8"

## Configure ARQ ##

You need to set a couple of environment variables to be able to use the scripts that come with the ARQ distribution. Specifically:

ARQROOT
:   the full path to the unzipped <code>arq-2.8.8.zip</code> file.
PATH
:   $ARQROOT/bin must be added to your path if you want to be able to access
    the ARQ scripts without specifying their full path every time.

Here is a snippet that can be added to your ~/.bashrc file on Linux and OS X to set the required environment variables.

    ARQROOT=$HOME/Code/lib/ARQ-2.8.8
    export ARQROOT
	PATH=$PATH:$ARQROOT/bin

## Use ARQ… ##

### …to query local data ###

    sparql \--data DATA_FILE \--query QUERY_FILE

### …to query remote data ###

	rsparql \--service=SPARQL_ENDPOINT_URL \--query QUERY_FILE

    rsparql \--service=http://beta.sparql.uniprot.org/ \--query uniprot.sparql

[« Previous: Introduction «][Intro]
[» Next: Your first SPARQL query »][First]

[Intro]: ../ "Introduction" class=prev
[First]: ../first/ "Your first SPARQL query" class=next
