package PBot::Channel::Functions;

use strict;
use warnings;

sub has_user
{
    my ($self, $userName) = @_;
    foreach (@{$self->channels})
    {
        return 1 if lc($userName) eq lc($_->nick);
    }
    return undef;
}

sub add_user
{
    my ($self, $userObj) = @_;
    return if !ref $userObj || blessed($userObj) ne 'PBot::User';
    push(@{$self->users}, $userObj);
}

sub del_user
{
    my ($self, $channelObj) = @_;
    return if !ref $channelObj || blessed($channelObj) ne 'PBot::User';
    @{$self->channels} = grep { $channelObj != $_ } @{$self->channels};
}

sub add_mode
{

}

sub del_mode
{

}

1;
