package PBot::Network::Functions;

use strict;
use warnings;
use PBot::Channel;

sub add_channel
{
    my ($self, $channelName) = @_;
    my $channel = PBot::Channel->new(name => $channelName);
    push(@{$self->channels}, $channel);
}

sub find_channel
{
    my ($self, $channelName) = @_;
    foreach (@{$self->channels})
    {
        return $_ if lc($_->name) eq lc($channelName);
    }
    return undef;
}

1;
