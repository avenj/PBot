# PBot

package PBot;

use strict;
use warnings;
use Moo;

use IO::Async;
use IO::Async::Loop;

use PBot::Connection;
use PBot::Network;

has debug => (
    is      => 'ro',
    default => 0
);

has loop => (
    is      => 'ro',
    default => sub { IO::Async::Loop->new; }
);

sub start {
    my $self = shift;
    say "*** Starting PBot";
    say "*** Debug on" if $self->debug;
    say "*** Entering loop...";
    $self->loop->run;
}

1;
