# PBot

package PBot;

use strict;
use warnings;
use feature qw(say switch);

use Moo;
with 'MooX::Singleton';
use MooX::Types::MooseLike::Base qw(:all);
use base qw(EventedObject);

use IO::Async;
use IO::Async::Loop;

use PBot::Connection;
use PBot::Network;
use PBot::Parser;

has debug => (
    is      => 'ro',
    isa     => Bool,
    default => 0
);

has loop => (
    is      => 'ro',
    isa     => InstanceOf['IO::Async::Loop'],
    default => sub { IO::Async::Loop->new; }
);

has parser => (
    is      => 'ro',
    isa     => InstanceOf['PBot::Parser'],
    default => sub { PBot::Parser->new; }
);

has networks => (
    is      => 'rw',
    isa     => ArrayRef[InstanceOf['PBot::Network']],
    default => sub { [ ] }
);

my %test = (
    'AlphaChat' => ['irc.alphachat.net', 6667],
    'mac-mini'  => ['irc.mac-mini.org', 6667]
);

sub start {
    my $self = shift;
    say "*** Starting PBot";
    say "*** Debug on" if $self->debug;
    PBot->instance->on(debug => sub { say $_[1] if $self->debug; });
    say "*** Entering loop...";
    foreach (keys %test)
    {
        my $network = PBot::Network->new(name => $_, host => $test{$_}[0], port => $test{$_}->[1]);
        $self->add_network($network);
    }
    say "*** Connecting...";
    $self->connect_all();
    $self->loop->run;
}

# XXX: Add logic for checking if it's a PBot::Network
sub add_network {
    my ($self, $network) = @_;
    push(@{$self->networks}, $network);
}

# XXX: Add logic for checking if it's a PBot::Network
sub find_network {
    my ($self, $networkName) = @_;
    foreach (@{$self->networks})
    {
        return $_ if lc($_->name) eq lc($networkName);
    }
    return undef;
}

# Connect all
sub connect_all
{
    my $self = shift;
    foreach (@{$self->networks})
    {
        $_->connect();
    }
}

# Disconnect all
sub disconnect_all
{
    # XXX: Disconnect not added yet
}

1;
