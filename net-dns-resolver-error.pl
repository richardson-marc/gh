#!/usr/bin/perl

use warnings;

use strict;

use YAML::Tiny;
use Data::Dumper;
use Net::DNS;
my $configfile = $ARGV[0];
my $domain = $ARGV[1];

#print "domain is $domain\n";

my $nameserver = $ARGV[2];

my($lookup_record);
# Create a YAML file
my $stuff = YAML::Tiny->new;

# Open the config
$stuff = YAML::Tiny->read( 'config/expected.yaml' );
#my %stuff;

#my %subkey;
#my $value;
#my $subkey;
#my $type;
foreach my $key (keys %{ $stuff->[0] }) {

my $type = $stuff->[0]->{$key}{type};
my $value = $stuff->[0]->{$key}{value};
	    my $domain = "dns-exercise.dev";
    $lookup_record = join ".", $key, $domain;
	    do_dns_lookup($lookup_record,$type);
}




sub do_dns_lookup {
    my ($lookup_record, $type) = @_;
    # need to capitalize the type string
#my $type = uc($type);

my $res  = Net::DNS::Resolver->new;
$res->nameservers( 'ns-179.awsdns-22.com' );

# Important to specify a 'TXT' query
    #my $query = $res->search( $host, 'TXT' ) or die "NULL\n";

    my $query = $res->search( $lookup_record, $type ) or die "NULL\n";
        print "\t$lookup_record\t$type\n";
foreach my $rr ( $query->answer ) {
    next unless $rr->type eq $type;
    print $rr->txtdata, "\n";
}
}


__END__

# this script exits with this error:
# which is bafffling...
***  FATAL PROGRAM ERROR!!	Unknown instance method 'txtdata'
***  which the program has attempted to call for the object:
***
www.sub.dns-exercise.dev.	300	IN	A	2.2.3.6
***
***  THIS IS A BUG IN THE CALLING SOFTWARE, which incorrectly assumes
***  that the object would be of a particular type.  The type of an
***  object should be checked before calling any of its methods.
***
Net::DNS::RR::A 1597 at ./almost-tiny.pl line 73.
	main::do_dns_lookup('www.sub.dns-exercise.dev', 'A') called at ./almost-tiny.pl line 47
    
