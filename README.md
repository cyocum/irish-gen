# Digitising Medieval Irish Genealogies in RDF

The goal of this project is to create a database of the early Irish
Genealogies.  To achieve this goal and due to the nature of the source
material, the curators chose the [Resource Description
Framework](https://www.w3.org/TR/rdf11-primer/) (RDF) to represent it.
Because this is a human curated database, a human readable
representation of RDF was needed, which, in this case, the curators
chose the [TRiG](https://www.w3.org/TR/trig/) concrete representation
of RDF.  It is recommended for those who may not have experience with
RDF serializations to read the [Turtle](https://www.w3.org/TR/turtle/)
specification first before reading the TRiG one.

# Structure

The database is structured by dividing the genealogies by manuscript.
Each manuscript is given its own directory which is derived from its
common scholarly abbreviation.  For instance, all genealogies that are
derived from the _Book of Leinster_ are placed in the LL directory. As
for the ontologies, these are placed in the top level directory.

## Items

Each genealogy is divided into its "items" which represent one Turtle
file in its directory.  The item file name is created from its
manuscript header.  For instance "Aisneidem Di Araill" from the _Book
of Leinster_ has the file name `aisneidem_di_araill.trig`.

The curators have not always been consistant in the naming of the
items.  Especally in LL, "Genelogia" or "De Genelach" have been
omitted.

## URL Structure

Within each item, the individual entries are given a URL to represent
that particular entry in the genealogy.  The URL for an individual
entry, which constitutes a node in the RDF graph, is generated from
the instance of their name directly from the manuscript.  If the same
name appears in exactly the same form appears, whether or not it is
the same person, then the first eight characters of a UUID generated
by `uuidgen -r` are appended to differentiate between the different
instances is added.  For example,

```turtle
<CindFhaelad>
    a foaf:Person;
    irishRel:genName "Cind Fhaelad";
    irishRel:nomName "Cenn Faelad";
    rel:childOf <#Airnelaig>.

<CindFhaelad-6e827350>
    a foaf:Person;
    irishRel:genName "Cind Fhaelad";
    irishRel:nomName "Cenn Faelad";
    rel:childOf <#Gairb>.
```

At the present moment, all URLs are prefixed with `http://example.com`
because a permanent URL has not been purchased at this time.  For
example, a full URL for `<CindFhaelad-6e827350>` would be
`http://example.com/LL/ceniuil_lugdach/CindFhaelad-6e827350`.

## Named Graph (RDF Dataset)

Each item belongs to a manuscript and while this is represented in the
URL as described above, it is inconvenient to address the manuscript
itself.  To allow for this and to allow queries which are easily
narrowed by manuscript, an extention to the triple format, called a
[TRiG](https://www.w3.org/TR/trig/), is used.  This extention allows
for the use of Named Graphs (see more
[here](https://www.w3.org/TR/rdf11-concepts/#section-dataset)).  In
the case of this project, the manuscript is identified by its URL and
is the named graph for the triples.  For instance, from
`aisneidem_di_araill.trig`:

```turtle

<http://example.com/LL> {
<>
        a dctype:Dataset;
        dcterms:title "Aisneidem Di Araill"@sga;
        dcterms:isFormatOf <http://www.ucc.ie/celt/published/G800011F/text028.html>;
        dcterms:format "application/trig" ;
        prov:asDerivedFrom <http://www.ucc.ie/celt/published/G800011F/text028.html> .

     <Conchobuir>
        a foaf:Person;
        irishRel:genName "Conchobuir";
        irishRel:nomName "Conchobar";
        rel:childOf <Fhactnai>.

     <Fhactnai>
        a foaf:Person;
        irishRel:nomName "Fhactnai".
}

```

This snippet identifies these triples as being a part of the
`<http://example.com/LL>` graph.  In this way, queries can be done on
particular graphs and the user can programmatically determine which
triples belong to which manuscript.

## Individuals

While each entry in the genealogy has its own URL, many references are
to the same individuals.  To represent this, `owl:sameAs` is used to
link these URLs together.  This is done: within a single item file,
across item files in the same manuscript, and across manuscripts.
This ensures that the various versions of the genealogies are
referenced together.

Occasionally, individuals will have alternate genealogies.  For ease
of curation, these alternate genealogies are attached directly where
they appear in the manuscript.  This will often make an individual
look like they have three or more parents.

## Individuals with no name

There are many instances where there are individuals who are mentioned
but have no name.  RDF [blank
nodes](https://www.w3.org/TR/rdf11-concepts/#section-blank-nodes) are
used to identify the individual.  The curators chose a format which
uses a `_:missing` plus a UUID fragment like above. For instance,

```turtle
_:missing-04015614
    a foaf:Person ;
    foaf:gender "female" ;
	agrelon:hasChild <Conmáel>, <h-Ér>, <Orbba>, <Ferón>, <#ergna>;
    rel:parentOf <Conmáel>, <h-Ér>, <Orbba>, <Ferón>, <#ergna>;
	agrelon:hasParent <Militis>;
    rel:childOf <Militis>;
	agrelon:hasSibling <Díl>;
    rel:siblingOf <Díl>.
```

The alternate form of the blank node is used where convenient.

## Population Groups

Often important individuals are credited with founding a clan or
tribe.  In this case the population group is created as its own URL
which is constructed using the same principles as for a person, as
above.  For instance:

```turtle
<Coscrach>
    a foaf:Person;
    irishRel:nomName "Coscrach";
	agrelon:hasParent <Lorcan>;
    rel:childOf <Lorcan>;
    irishRel:numChild 12 ;
    irishRel:ancestorOfGroup <ClandCosraig>.

<ClandCosraig>
    a irishRel:PopulationGroup ;
    irishRel:PopulationGroup "Cland Cosraig" .
```

## Comments on entries

Occationally, in the manuscript sources, there is more information
about an individual which is added to the entry by using
`rdfs:comment`.  This is done because the curators wished to capture
relevant non-structured information to capture the context of an
entry.  For instance,

```turtle
#Lachtna-32e54830>
    a foaf:Person;
    irishRel:nomName "Lachtna";
	agrelon:hasParent <#Cennétig>;
    rel:childOf <#Cennétig>;
    irishRel:numChild 0;
    rdfs:comment "is é ro gab ríge dar éis Cennetig. Unde dicitur Grianan Lactnai i Creicc Léith...".
```

# Utilities

There are several utility Perl scripts which ease the creation and
curation of the database.  Look in the `utils` directory for more
information.

# Blog

More specific information about the project can be found on the blog:
[IrishGen Occasional Topics](https://cyocum.github.io/).

