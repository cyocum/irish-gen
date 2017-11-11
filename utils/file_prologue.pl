use strict;
use warnings;
use feature 'unicode_strings';
use utf8;

binmode(STDOUT, ":utf8");

my $title = $ARGV[0];
my $section_num = $ARGV[1];

my $lc_title = lc $title;
$lc_title =~ s/\s/_/g;
$lc_title .= ".ttl";

print <<"END_PROLOGUE"
\@base <http://example.com/Rawl_B502/$lc_title>.
\@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
\@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
\@prefix foaf:  <http://xmlns.com/foaf/0.1/> .
\@prefix rel: <http://purl.org/vocab/relationship/>.
\@prefix owl: <http://www.w3.org/2002/07/owl#> .
\@prefix dcterms: <http://purl.org/dc/terms/> .
\@prefix dctype: <http://purl.org/dc/dcmitype/> .
\@prefix irishRel: <http://example.com/earlyIrishRelationship.ttl#> .
\@prefix prov: <http://www.w3.org/ns/prov#> .

<>
    a dctype:Dataset;
    dcterms:title "$title"\@sga;
    dcterms:isFormatOf <http://www.ucc.ie/celt/published/G105003/text$section_num.html>;
    dcterms:format "text/turtle" ;
    prov:asDerivedFrom <http://www.ucc.ie/celt/published/G105003/text$section_num.html> .

END_PROLOGUE
    

