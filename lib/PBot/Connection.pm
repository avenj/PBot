package PBot::Connection;

use strict;
use warnings;
use Moo;
use MooX::Types::MooseLike::Base qw(:all);
use base qw(EventedObject);

my $socketPackage;
my $streamPackage;

has ssl => (
    is       => 'ro',
    isa      => Bool,
    trigger  => sub {
        my ($self, $useSSL) = @_;
        if ($useSSL)
        {
            $streamPackage = 'IO::Async::SSLStream';
            $socketPackage = 'IO::Socket::SSL';
        }
        else
        {
            $streamPackage = 'IO::Async::Stream';
            $socketPackage = 'IO::Socket::IP';
        }
        eval "require $streamPackage";
        eval "require $socketPackage";
    },
    default  => sub { 0 },
    required => 1
);

has host => (
    is       => 'ro',
    isa      => Str,
    required => 1
);

has port => (
    is       => 'ro',
    isa      => Int,
    required => 1
);

has bind => (
    is       => 'ro',
    isa      => Str,
    default  => sub { '0.0.0.0' },
    required => 0
);

has stream => (
    is      => 'rwp'
);

sub go
{
    my $self = shift;
    my $socketHandle = $socketPackage->new(
        Proto     => 'tcp',
        PeerAddr  => $self->host,
        PeerPort  => $self->port,
        LocalAddr => $self->bind,
        Timeout   => 10
    );
    my $streamObject = $streamPackage->new(
        handle  => $socketHandle,
        on_read => sub {
            my ($this, $buffref, $eof) = @_;
            while ($$buffref =~ s/(.*)\n//)
            {
                $self->fire(data => $1);
            }
            return 0;
        },
     );
     $self->_set_stream($streamObject);
     PBot->instance->loop->add($streamObject);
     $self->on(write => sub {
             my ($event, $data) = @_;
             $streamObject->write($data);
        }
    );
}

sub write { 
    my ($self, $data) = @_;
    $self->stream->write($data);
}

1;
