# Digitising Medieval Irish Genealogies in RDF

The goal of this project is to create a database of the early Irish
Genealogies.  To achieve this goal and due to the nature of the source
material, the curators chose the [Resource Description
Framework](https://www.w3.org/TR/rdf11-primer/) (RDF) to represent it.
Because this is a human curated database, a human readable
representation of RDF was needed, which, in this case, the curators
chose the [Turtle](https://www.w3.org/TR/turtle/) concrete
representation.

# Structure

The database is structured by dividing the genealogies by manuscript.
Each manuscript is given its own directory which is derived from its
common scholarly abbreviation.  For instance, all genealogies that
are derived from the _Book of Leinster_ are placed in the LL
directory. As for the ontologies, these are placed in the top
directory.

## Items

Each genealogy is divided into its "items" which represent one Turtle
file in its directory.  The item file name is created from its
manuscript header.  For instance "Aisneidem Di Araill" from the _Book
of Leinster_ has the file name <pre>aisneidem_di_araill.ttl</pre>.

## URL Structure

Within each item, the individual entries are given a URL to represent
that particular entry in the geneaology.  The URL for an individual
entry, which consitutes a node in the RDF graph, is generated from the
instance of their name directly from the manuscript.  If the same name
appears, whether or not it is the same person or not, then a UUID is
appended to differentiate between the different instances is added.
For example,

```turtle
<#CindFhaelad>
    a foaf:Person;
    irishRel:genName "Cind Fhaelad";
    irishRel:nomName "Cenn Faelad";
    rel:childOf <#Airnelaig>.

<#CindFhaelad-6e827350>
    a foaf:Person;
    irishRel:genName "Cind Fhaelad";
    irishRel:nomName "Cenn Faelad";
    rel:childOf <#Gairb>.
```

At the present moment, all URLs are prefixed with
<pre>http://example.com</pre> because a permanent URL has not been
purchased at this time.

## Individuals

While each entry in the geneaology has its own URL, many references
are to the same person.  To represent this, <pre>owl:sameAs</pre> is
used to link these persons together.  This is done: within a single
item file, across item files in the same manuscript, and across
manuscripts.  This ensures that the various versions of the
genealogies are referenced together.

# Utilties

There are several utility Perl scripts which ease the creation and
curation of the database.  Look in the <pre>utils</pre> directory for
more information.

