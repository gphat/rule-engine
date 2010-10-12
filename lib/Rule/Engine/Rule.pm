package Rule::Engine::Rule;
use Moose;

=head1 NAME

Rule::Engine::Rule - A Rule Engine Rule

=head1 ATTRIBUTES

=head2 condition

=cut

has 'condition' => (
    is => 'rw',
    isa => 'CodeRef',
    traits => [ 'Code' ],
    required => 1,
    handles => {
        execute => 'execute'
    }
);

=head2 description

Text describing this rule.

=cut

has 'description' => (
    is => 'rw',
    isa => 'Str'
);

=head2 name

The name of this rule.

=cut

has 'name' => (
    is => 'rw',
    isa => 'Str',
    required => 1
);

=head1 AUTHOR

Cory G Watson, C<< <gphat at cpan.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2010 Cory G Watson.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

__PACKAGE__->meta->make_immutable;
no Moose;
1;