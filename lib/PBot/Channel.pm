package PBot::Channel;

use strict;
use warnings;
use Moo;
use MooX::Types::MooseLike::Base qw(:all);
use base qw(EventedObject PBot::Channel::Functions PBot::Generic::Functions);

has name => (
    is       => 'rw',
    isa      => Str,
    required => 1
);

has topic => (
    is       => 'rw',
    isa      => Str,
);

has modes => (
    is      => 'rw',
    isa     => HashRef,
    default => sub { { } },
);

has network => (
    is       => 'ro',
    isa      => InstanceOf['PBot::Network'],
    required => 1,
    weak_ref => 1
);

has users => (
    is       => 'rw',
    isa      => ArrayRef[InstanceOf['PBot::User']],
    default  => sub { [ ] },
    weak_ref => 1
);

1;
