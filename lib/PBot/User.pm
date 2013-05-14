package PBot::User;

use strict;
use warnings;
use Moo;
use MooX::Types::MooseLike::Base qw(:all);
use base qw(EventedObject PBot::User::Functions PBot::Generic::Functions);

has nick => (
    is       => 'rw',
    isa      => Str,
    required => 1
);

has user => (
    is       => 'rw',
    isa      => Str, 
    required => 1
);

has host => (
    is       => 'rw',
    isa      => Str,
    required => 1
);

has network => (
    is       => 'ro',
    isa      => InstanceOf['PBot::Network'],
    required => 1,
    weak_ref => 1
);

has channels => (
    is       => 'rw',
    isa      => ArrayRef[InstanceOf['PBot::Channel']],
    default  => sub { [ ] },
    weak_ref => 1
);

1;
