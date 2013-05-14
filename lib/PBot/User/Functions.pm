package PBot::User::Functions;

use strict;
use warnings;

sub name { return shift->name; }

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

