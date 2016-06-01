# Digitising Medieval Irish Genealogies in RDF

Traditional Irish genealogies represented as Turtle RDF graphs.

This project is to transform the early Irish geneologies from HTML and
XML in the [CELT](http://celt.ucc.ie) site into a computer readable
[Turtle RDF](http://www.w3.org/TR/turtle/).  This will allow
researchers to manipulate and visualize the genealogies
programmatically.  This should allow researchers a more reliable and
quicker way to study the various genealogies.

# Conventions

There are a couple of conventions used to make referencing the various
people in the graph easier.  First, when a name is repeated, it's IRI
is appended with a random identifier of the first eight characters
created by uuidgen.  Second, when there are differing variants of a
name the OWL sameAs property is used.  Third, if there are two or more
variants of a particular decendant line, the same technique is use
where a new node with a uuidgen id is created but is connected to the
original node by an owl sameAs property.  The alternate line is then
attached to the uuidgen node.

Each set of files are listed by the manuscript they derive from. For
instance, files in the LL directory come from the Book of Leinster.
LL comes from the standard scholarly abbreviation for the book.

For the moment, until there is a proper IRI to reference, all the
turtle files use http://example.com as their base IRI. This makes
namespacing and linking easier over the files.  For instance,
dáil_caiss.ttl is in the LL directory and has a base IRI of
http://example.com/LL/dáil_caiss.ttl.