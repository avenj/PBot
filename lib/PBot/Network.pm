package PBot::Network;

use strict;
use warnings;
use Moo;
use MooX::Types::MooseLike::Base qw(:all);
use PBot::Connection;
use PBot::Channel;
use PBot::User;

use parent 'EventedObject';
with 'PBot::Network::Functions';

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
    is       => 'rw',
    isa      => ArrayRef[InstanceOf['PBot::Channel']],
    default  => sub { [ ] },
);

has users => (
    is       => 'rw',
    isa      => ArrayRef[InstanceOf['PBot::User']],
    default  => sub { [ ] },
);

has status_modes => (
    is      => 'rwp',
    isa     => HashRef,
    default => sub { { } }
);

has connection => (
    is       => 'rw',
    isa      => InstanceOf['PBot::Connection'],
    weak_ref => 1
);

1;
