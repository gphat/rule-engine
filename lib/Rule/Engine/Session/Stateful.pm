package Rule::Engine::Session::Stateful;
use Moose;

with 'Rule::Engine::Session';

__PACKAGE__->meta->make_immutable;
no Moose;
1;