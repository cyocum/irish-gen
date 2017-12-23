use strict;
use warnings;

binmode(STDOUT, ":utf8");

my $str = $ARGV[0];

my @individuals = split(/\smic\s|\sm\s|\smc\s|\s\.?m\.?\s|\singen\s|\singine\s|\smeic\s|\smac-side\s/, $str);
my $output = '';

my $len = @individuals;

my %seen;

for(my $i = 0; $i < $len; $i++) {
    my $person = $individuals[$i];

    my $relationship = '';

    my $next = $individuals[$i+1];

    if($next) {
	my $space_removed = $next =~ s/\s+//gr;
	$relationship = ";\nrel:childOf <#$space_removed>.\n\n";
    } else { $relationship = "."; }

    my $person_no_space = $person =~ s/\s+//gr;
    
    $output .= "<#$person_no_space>\na foaf:Person;\n";
    
    if($i == 0) {
	$output .= "irishRel:nomName \"$person\"";
    } else  {
	$output .= "irishRel:genName \"$person\"";
    }
    
    $output .= $relationship;
}

print $output;

