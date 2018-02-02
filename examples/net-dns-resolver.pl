#!/usr/bin/perl
use warnings;
use strict;

use Net::DNS;

my $host = $ARGV[0];
my $type = $ARGV[1];

#print "domain is $domain\n";

my $nameserver = $ARGV[2];

#my($lookup_record);
# Create a YAML file
#my $stuff = YAML::Tiny->new;
#my $IP = shift;
#my ( $a, $b, $c, $d ) = split /\./, $IP;
#my $host = "txt.dns-exercise.dev";
#my $host = "spf.dns-exercise.dev";

print "looking up $host $type record\n";
my $res  = Net::DNS::Resolver->new;
$res->nameservers( 'ns-179.awsdns-22.com' );

# Important to specify a 'TXT' query
#my $query = $res->search( $host, 'TXT' ) or die "NULL\n";
my $query = $res->search( $host, $type ) or die "NULL\n";
foreach my $rr ( $query->answer ) {
    next unless $rr->type eq $type;
    print $rr->txtdata, "\n";
    }
