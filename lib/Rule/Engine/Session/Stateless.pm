package Rule::Engine::Session::Stateless;
use Moose;

with 'Rule::Engine::Session';

__PACKAGE__->meta->make_immutable;
no Moose;
1;