use strict;
use warnings;

use IO::File;
binmode(STDOUT, ":utf8");

foreach my $file (@ARGV) {
    print "Processing $file\n";
    process_file($file);
}


sub process_file {
    my ($file) = @_;

    my $fh = IO::File->new($file, "r");
    
    $fh->binmode(':utf8');

    my %seen;

    while(my $row = <$fh>) {

	$row =~ m/<#((\p{Alphabetic}+)(\-\p{Alnum}+)?)>\n/g;

	if(defined($1)) {
	    $seen{$1}++;
	}
    }

    foreach my $key (keys %seen) {
	if($seen{$key} >= 2) {
	    print "Possible duplicate seen of $key\n seen " . $seen{$key} . " times\n";
	}
    }
}
