package Rule::Engine::Session;
use Moose;

=head1 ATTRIBUTES

=head2 environment

=cut

has 'environment' => (
    is => 'rw',
    isa => 'HashRef',
    traits => [ 'Hash' ],
    handles => {
        set_environment => 'set',
        get_environment => 'get'
    },
    default => sub { {} }
);

=head2 filter

=cut

has 'filter' => (
    is => 'rw',
    isa => 'Rule::Engine::Filter',
    predicate => 'has_filter'
);

=head2 rules

An array of rules.

=cut

has 'rules' => (
    is  => 'rw',
    isa => 'ArrayRef[Rule::Engine::Rule]',
    traits => [ 'Array' ],
    default => sub { [] },
    handles => {
        add_rule => 'push',
        rule_count => 'count'
    }
);

=head1 METHODS

=head2 add_rule($rule)

Add a rule

=head2 execute(\@objects)

Execute the rules against the objects provided

=cut

sub execute {
    my ($self, $objects) = @_;

    die 'Must supply some objects' unless defined($objects);

    # No sense doing nothing!
    return $objects if $self->rule_count == 0;

    if(ref($objects) ne 'ARRAY') {
        my @objs = ( $objects );
        $objects = \@objs;
    }

    foreach my $obj (@{ $objects }) {
        foreach my $rule (@{ $self->rules }) {
            $rule->execute($self, $obj);
        }
    }

    return $objects unless $self->has_filter;
    my @returnable = ();
    foreach my $obj (@{ $objects }) {
        push(@returnable, $obj) if($self->filter->check($obj));
    }

    return \@returnable;
}

=head2 rule_count

Returns the number of rules for this session.

=cut


__PACKAGE__->meta->make_immutable;
no Moose;

1;