package PBot::User;

use strict;
use warnings;
use Moo;
use MooX::Types::MooseLike::Base qw(:all);
use base qw(EventedObject);

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

has channels => (
    is       => 'rw',
    isa      => ArrayRef[InstanceOf['PBot::Channel']],
    default  => sub { [ ] },
    weak_ref => 1
);

sub in_channel
{
    my ($self, $channelName) = @_;
    foreach (@{$self->channels})
    {
        return 1 if lc($channelName) eq lc($_->name);
    }
    return undef;
}

sub add_to_channel
{
    my ($self, $channelObj) = @_;
    return if !ref $channelObj || blessed($channelObj) ne 'PBot::Channel';
    push(@{$self->channels}, $channelObj);
}

sub del_from_channel
{
    my ($self, $channelObj) = @_;
    return if !ref $channelObj || blessed($channelObj) ne 'PBot::Channel';
    @{$self->channels} = grep { $channelObj != $_ } @{$self->channels};
}

1;
