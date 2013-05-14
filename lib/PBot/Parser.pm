package PBot::Parser;

use strict;
use warnings;
use feature qw(switch);

use Moo;

sub parse
{
    my ($self, $network, $data) = @_;
    my $net = caller(0);
    my @spaceSplit = split(" ", $data);
    $network->fire("raw_".$spaceSplit[1] => @spaceSplit);
    $network->write("PONG $spaceSplit[1]") if $spaceSplit[0] eq 'PING';
}

1;
