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
    is       => 'rw',
    isa      => ArrayRef[InstanceOf['PBot::Channel']],
    default  => sub { [ ] },
    weak_ref => 1
);

has users => (
    is       => 'rw',
    isa      => ArrayRef[InstanceOf['PBot::User']],
    default  => sub { [ ] },
    weak_ref => 1
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

1;
