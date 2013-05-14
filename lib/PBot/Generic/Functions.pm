package PBot::Generic::Functions;

use strict;
use warnings;

sub message
{
    my ($self, $data) = @_;
    $self->network->write("PRIVMSG ".$self->name." :$data");
}

sub notice
{
    my ($self, $data) = @_;
    $self->network->write("NOTICE ".$self->name." :$data");
}

1;
