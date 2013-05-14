package PBot::Network::Functions;

use strict;
use warnings;
use PBot::Channel;
use PBot::User;

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
    $self->connection->on(data => sub { PBot->instance->fire(debug => "[".$self->name."] << ".$_[1]); });
}

sub write
{
    my ($self, $data) = @_;
    chomp $data;
    $self->connection->write("$data\r\n");
    PBot->instance->fire(debug => "[".$self->name."] >> ".$data);
}

sub add_channel
{
    my ($self, $channelName) = @_;
    my $channel = PBot::Channel->new(name => $channelName, network => $self);
    push(@{$self->channels}, $channel);
}

sub del_channel
{

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

sub add_user
{
    my ($self, $userNick, $userIdent, $userHost) = @_;
    my $channel = PBot::User->new(nick => $userNick, user => $userIdent, host => $userHost,  network => $self);
    push(@{$self->users}, $channel);
}

sub del_user
{

}


sub find_user
{
    my ($self, $userNick) = @_;
    foreach (@{$self->users})
    {
        return $_ if lc($_->name) eq lc($userNick);
    }
    return undef;
}


1;
