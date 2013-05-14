package PBot::Channel;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

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
    default => [ ],
);

has users => (
    is       => 'rw',
    isa      => ArrayRef[InstanceOf['PBot::User']],
    default  => { },
    weak_ref => 1
);

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
    return if !ref $channelObj || blessed($channelObj) ne 'PBot::Channel';
    @{$self->channels} = grep { $channelObj != $_ } @{$self->channels};
}

sub add_mode
{

}

sub del_mode
{

}
