package PBot::Network;

use strict;
use warnings;
use Moo;
use MooX::Types::MooseLike::Base qw(:all);
use PBot::Connection;
use base qw(EventedObject PBot::Network::Functions);

has name => (
    is       => 'ro',
    isa      => Str,
    required => 1
);

has host => (
    is       => 'ro',
    isa      => Str,
    required => 1
);

has port => (
    is      => 'ro',
    isa     => Int,
    default => sub { 6667 }
);

has ssl => (
    is      => 'ro',
    isa     => Bool,
    default => sub { 0 }
);

has channels => (
    is      => 'ro',
    isa     => ArrayRef[InstanceOf['PBot::Channel']],
    default => sub { [ ] }
);

has channel_modes => (
    is      => 'ro',
    isa     => ArrayRef[InstanceOf['PBot::Channel::Mode']],
    default => sub { [ ] }
);

has connection => (
    is       => 'rw',
    isa      => InstanceOf['PBot::Connection'],
    weak_ref => 1
);

sub connect 
{
    my $self = shift;
    $self->connection(my $connection = PBot::Connection->new(
        host    => $self->host,
        port    => $self->port,
        ssl     => $self->ssl,
        network => $self
    ));
    $self->connection->go();
    $self->connection->on(data => sub { print "irc: $_[1]\n"; });
}

1;
