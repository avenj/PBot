# PBot

package PBot;

use strict;
use warnings;
use Moo;

use PBot::Network;

has debug => (
    is      => 'ro',
    default => 0
);

1;
